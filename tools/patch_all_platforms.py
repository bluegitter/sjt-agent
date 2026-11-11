"""Version-pinned cross-platform SJT capability patch; never changes Java classes."""

import argparse
import copy
from dataclasses import dataclass
import hashlib
import json
import os
from pathlib import Path
import struct
import subprocess
import tempfile
import zipfile


ROOT = Path(__file__).resolve().parents[1]
EVIDENCE = ROOT / "build-output"
SOURCE_SHA256 = "8163f2221a115ef51364a1f8924842f53904bfc1595bb14633d47a91b941a89a"


@dataclass(frozen=True)
class Profile:
    name: str
    sha256: str
    offset: int
    before: str
    after: str
    address: int
    start: int
    stop: int
    triple: str = ""


PROFILES = (
    Profile("sjt_windows_x64.dll", "8e1fb5cdf84f43bd549f3bea0816894155e3c005ef3f5c2d1267cf6deea09172",
            0x65F, "c784247401000060000000", "c784247401000000000000", 0x18000125F, 0x180001170, 0x180001331),
    Profile("sjt_windows_x86.dll", "7d3e031c58630f0deaaa6b86ebc3c57b0d97b075f583bd16e4967a54bf408a72",
            0x619, "c784249800000060000000", "c784249800000000000000", 0x10001219, 0x10001130, 0x10001320),
    Profile("sjt_linux_x64.so", "7e0e281318fc5bed35ffdf9b1811f757ee4e9f19c083a31ee2aac2ab0416ccc0",
            0x31B7C, "c644241460", "c644241400", 0x31B7C, 0x31AF0, 0x31C90),
    Profile("sjt_linux_x86.so", "934a09a70cc451b7bd87ac44690befe930cdfad6c8e1dd1ed1e5734426d66cef",
            0x22EBA, "c644241060", "c644241000", 0x22EBA, 0x22DF0, 0x22FF0),
    Profile("sjt_linux_a64.so", "2d6e7edf80e05e57c5e7df8c3386ca99534fb064ffa83ba143879b0c5584909d",
            0x91BAC, "020c8052", "02008052", 0x91BAC, 0x91B28, 0x91CE0),
    Profile("sjt_linux_a32hf.so", "8dd57bc66c621127c0cf1bea2acd56d681ed7229e8cec4fd45155d2139546c2a",
            0x3CC9C, "43f06003", "43f00003", 0x3CC9C, 0x3CC28, 0x3CD52, "thumbv7-linux-gnueabihf"),
    Profile("sjt_darwin_a64.dylib", "dd04079bf2e8da074443dead1731ee876af881ca58826739cc027f8e6f5265a5",
            0x7AEFC, "080cc0f2", "0800c0f2", 0x7AEFC, 0x7AE20, 0x7AFF0),
    Profile("sjt_darwin_x64.dylib", "825c95f2d82041180f199014e20d2a6e333aa3e55fe5154d1e331f36b160f2fa",
            0x2EAE, "48b8080000ac00000000", "48b8080000ac00000000", 0x2EAE, 0x2E00, 0x2F90),
)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def macho_sections(data):
    if data[:4] != bytes.fromhex("cffaedfe"):
        raise ValueError("Expected a little-endian 64-bit Mach-O")
    sections = {}
    position = 32
    for _ in range(struct.unpack_from("<I", data, 16)[0]):
        command, size = struct.unpack_from("<II", data, position)
        if command == 0x19:
            count = struct.unpack_from("<I", data, position + 64)[0]
            for index in range(count):
                fields = struct.unpack_from("<16s16sQQ8I", data, position + 72 + index * 80)
                section, segment, _, length, offset, _, _, _, flags, *_ = fields
                if flags & 255 in (1, 12, 18):
                    continue
                sections[(segment, section)] = data[offset:offset + length]
        position += size
    return sections


def patch_bytes(profile, original):
    if sha(original) != profile.sha256:
        raise ValueError(f"Unknown library hash: {profile.name}")
    before, after = bytes.fromhex(profile.before), bytes.fromhex(profile.after)
    if len(before) != len(after) or original[profile.offset:profile.offset + len(before)] != before:
        raise ValueError(f"Unexpected capability instruction: {profile.name}")
    patched = bytearray(original)
    patched[profile.offset:profile.offset + len(before)] = after
    if profile.before != profile.after:
        assert sum(a != b for a, b in zip(original, patched)) == 1
    return bytes(patched)


def disassemble(profile, path):
    command = ["/usr/bin/objdump", "-d", "--no-show-raw-insn",
               f"--start-address={profile.start}", f"--stop-address={profile.stop}"]
    if profile.triple:
        command.append(f"--triple={profile.triple}")
    text = subprocess.check_output(command + [str(path)], text=True)
    target = next((line for line in text.splitlines()
                   if line.strip().startswith(f"{profile.address:x}:")), None)
    if target is None or "<unknown>" in target:
        raise ValueError(f"Cannot decode capability instruction: {profile.name}")
    return text, target


def build(source, output, evidence=EVIDENCE):
    source, output = source.resolve(), output.resolve()
    if source == output:
        raise ValueError("Build to a separate file; install atomically only after verification")
    original_jar = source.read_bytes()
    if sha(original_jar) != SOURCE_SHA256:
        raise ValueError("Unknown source archive SHA-256; refusing to patch")
    evidence.mkdir(parents=True, exist_ok=True)
    before_dir, after_dir = evidence / "original", evidence / "patched"
    before_dir.mkdir(exist_ok=True)
    after_dir.mkdir(exist_ok=True)
    replacements, rows = {}, []
    with zipfile.ZipFile(source) as archive:
        for profile in PROFILES:
            entry = "libs/" + profile.name
            original = archive.read(entry)
            patched = patch_bytes(profile, original)
            old_path, new_path = before_dir / profile.name, after_dir / profile.name
            old_path.write_bytes(original)
            new_path.write_bytes(patched)
            old_asm, old_instruction = disassemble(profile, old_path)
            if profile.name == "sjt_darwin_a64.dylib":
                subprocess.run(["codesign", "--force", "--sign", "-", str(new_path)], check=True)
                subprocess.run(["codesign", "--verify", "--strict", str(new_path)], check=True)
                signed = new_path.read_bytes()
                if macho_sections(patched) != macho_sections(signed):
                    raise ValueError("Signing unexpectedly modified ARM64 section contents")
                patched = signed
            elif profile.name == "sjt_darwin_x64.dylib":
                subprocess.run(["codesign", "--verify", "--strict", str(new_path)], check=True)
            if patched[profile.offset:profile.offset + len(bytes.fromhex(profile.after))] != bytes.fromhex(profile.after):
                raise ValueError(f"Patched instruction was not preserved: {profile.name}")
            new_asm, new_instruction = disassemble(profile, new_path)
            (before_dir / (profile.name + ".init.asm")).write_text(old_asm)
            (after_dir / (profile.name + ".init.asm")).write_text(new_asm)
            replacements[entry] = patched
            rows.append({"member": entry, "changed": original != patched,
                         "source_sha256": sha(original), "output_sha256": sha(patched),
                         "instruction_file_offset": hex(profile.offset),
                         "instruction_address": hex(profile.address),
                         "before_hex": profile.before, "after_hex": profile.after,
                         "before_instruction": old_instruction.strip(),
                         "after_instruction": new_instruction.strip(),
                         "runtime_tested": profile.name == "sjt_darwin_x64.dylib"})
        with tempfile.TemporaryDirectory(dir=evidence) as directory:
            staged = Path(directory) / "patched.jar"
            with zipfile.ZipFile(staged, "w") as result:
                result.comment = archive.comment
                for entry in archive.infolist():
                    result.writestr(copy.copy(entry), replacements.get(entry.filename,
                                    archive.read(entry.filename)))
            with zipfile.ZipFile(staged) as result:
                if result.testzip() is not None or result.namelist() != archive.namelist():
                    raise ValueError("Archive integrity check failed")
                for entry in archive.namelist():
                    expected = replacements.get(entry, archive.read(entry))
                    if result.read(entry) != expected:
                        raise ValueError(f"Archive member mismatch: {entry}")
            output.write_bytes(staged.read_bytes())
    if source.read_bytes() != original_jar:
        raise ValueError("Source changed during build; do not install")
    report = {"source_sha256": sha(original_jar), "output_sha256": sha(output.read_bytes()),
              "source": str(source), "output": str(output), "members": rows,
              "other_archive_entries_identical": True,
              "cross_platform_runtime_validation": "pending; static verification only outside macOS x86-64"}
    (evidence / "patch-manifest.json").write_text(json.dumps(report, indent=2) + "\n")
    return report


def install(source, output, evidence=EVIDENCE):
    source, output = source.resolve(), output.resolve()
    report = json.loads((evidence / "patch-manifest.json").read_text())
    original, patched = source.read_bytes(), output.read_bytes()
    if sha(original) != report["source_sha256"] or sha(patched) != report["output_sha256"]:
        raise ValueError("Source or staged output changed; refusing install")
    backup = evidence / ("sjt_agent-before-" + sha(original)[:12] + ".jar")
    if backup.exists() and backup.read_bytes() != original:
        raise ValueError("Backup collision")
    backup.write_bytes(original)
    with tempfile.TemporaryDirectory(dir=source.parent) as directory:
        staged = Path(directory) / source.name
        staged.write_bytes(patched)
        staged.chmod(source.stat().st_mode & 0o777)
        if source.read_bytes() != original:
            raise ValueError("Source changed before install")
        os.replace(staged, source)
    return backup


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=ROOT / "sjt_agent.jar")
    parser.add_argument("--output", type=Path, default=ROOT / "sjt_agent-multiplatform-otel-compat.jar")
    parser.add_argument("--install", action="store_true")
    args = parser.parse_args()
    print(json.dumps(build(args.source, args.output), indent=2))
    if args.install:
        print("Installed; backup:", install(args.source, args.output))
