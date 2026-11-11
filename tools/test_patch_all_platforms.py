from dataclasses import replace
import json
from pathlib import Path
import tempfile
import unittest

import patch_all_platforms as patcher


class MultiPlatformPatchTests(unittest.TestCase):
    def setUp(self):
        # Immutable pre-patch fixtures allow verification after installing the new JAR.
        self.original = patcher.ROOT / "native/original"

    def test_all_eight_reviewed_libraries_are_covered(self):
        self.assertEqual(len(patcher.PROFILES), 8)
        self.assertEqual(sum(p.before != p.after for p in patcher.PROFILES), 7)

    def test_exactly_one_instruction_byte_changes_per_new_platform(self):
        for profile in patcher.PROFILES:
            with self.subTest(platform=profile.name):
                original = (self.original / profile.name).read_bytes()
                patched = patcher.patch_bytes(profile, original)
                self.assertEqual(len(original), len(patched))
                differences = [i for i, (a, b) in enumerate(zip(original, patched)) if a != b]
                expected = [profile.offset + i for i, (a, b) in enumerate(
                    zip(bytes.fromhex(profile.before), bytes.fromhex(profile.after))) if a != b]
                self.assertEqual(differences, expected)
                self.assertEqual(len(differences), 0 if profile.before == profile.after else 1)

    def test_capability_immediates_clear_only_the_two_retransformation_bits(self):
        for profile in patcher.PROFILES:
            with self.subTest(platform=profile.name):
                before, after = bytes.fromhex(profile.before), bytes.fromhex(profile.after)

                def high_byte(instruction):
                    if profile.name.startswith("sjt_windows"):
                        return int.from_bytes(instruction[-4:], "little")
                    if profile.name.startswith("sjt_linux_x"):
                        return instruction[-1]
                    if "a32hf" in profile.name:
                        return instruction[2]
                    if "a64" in profile.name:
                        return (int.from_bytes(instruction, "little") >> 5) & 0xFFFF
                    return (int.from_bytes(instruction[2:], "little") >> 32) & 255

                old, new = high_byte(before), high_byte(after)
                self.assertEqual(old, 0 if profile.before == profile.after else 0x60)
                self.assertEqual(new, 0)
                old_mask, new_mask = (old << 32) | 0xAC000008, (new << 32) | 0xAC000008
                self.assertEqual(old_mask ^ new_mask, 0 if old == 0 else (1 << 37) | (1 << 38))

    def test_wrong_library_hash_rejected_for_every_platform(self):
        for profile in patcher.PROFILES:
            with self.subTest(platform=profile.name):
                original = (self.original / profile.name).read_bytes()
                with self.assertRaisesRegex(ValueError, "Unknown library hash"):
                    patcher.patch_bytes(profile, original + b"tampered")

    def test_instruction_guard_is_independent_of_hash_guard(self):
        profile = patcher.PROFILES[0]
        data = bytearray((self.original / profile.name).read_bytes())
        data[profile.offset] ^= 1
        reviewed = replace(profile, sha256=patcher.sha(data))
        with self.assertRaisesRegex(ValueError, "Unexpected capability instruction"):
            patcher.patch_bytes(reviewed, data)

    def test_macos_x64_is_byte_identical(self):
        profile = patcher.PROFILES[-1]
        original = (self.original / profile.name).read_bytes()
        self.assertEqual(patcher.patch_bytes(profile, original), original)

    def test_unknown_archive_rejected_without_creating_output(self):
        with tempfile.TemporaryDirectory() as directory:
            source, output = Path(directory) / "source.jar", Path(directory) / "out.jar"
            source.write_bytes(b"unknown archive")
            with self.assertRaisesRegex(ValueError, "Unknown source archive"):
                patcher.build(source, output, Path(directory) / "evidence")
            self.assertFalse(output.exists())

    def test_in_place_build_rejected(self):
        with self.assertRaisesRegex(ValueError, "separate file"):
            patcher.build(patcher.ROOT / "sjt_agent.jar", patcher.ROOT / "sjt_agent.jar")

    def test_install_rejects_changed_output(self):
        with tempfile.TemporaryDirectory() as directory:
            base = Path(directory)
            source, output = base / "source.jar", base / "output.jar"
            source.write_bytes(b"original")
            output.write_bytes(b"tampered")
            (base / "patch-manifest.json").write_text(json.dumps({
                "source_sha256": patcher.sha(b"original"), "output_sha256": patcher.sha(b"expected")
            }))
            with self.assertRaisesRegex(ValueError, "refusing install"):
                patcher.install(source, output, base)
            self.assertEqual(source.read_bytes(), b"original")

    def test_install_is_backed_up_and_preserves_permissions(self):
        with tempfile.TemporaryDirectory() as directory:
            base = Path(directory)
            source, output = base / "source.jar", base / "output.jar"
            source.write_bytes(b"original")
            source.chmod(0o640)
            output.write_bytes(b"patched")
            (base / "patch-manifest.json").write_text(json.dumps({
                "source_sha256": patcher.sha(b"original"), "output_sha256": patcher.sha(b"patched")
            }))
            backup = patcher.install(source, output, base)
            self.assertEqual(backup.read_bytes(), b"original")
            self.assertEqual(source.read_bytes(), b"patched")
            self.assertEqual(source.stat().st_mode & 0o777, 0o640)


if __name__ == "__main__":
    unittest.main()
