
/Users/yanfei/Downloads/jiamiTest/analysis/sjt-agent/multiplatform/original/sjt_linux_a64.so:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000090ad0 <.text>:
   91b28:      	stp	x29, x30, [sp, #-336]!
   91b2c:      	adrp	x7, 0xa3000 <.text+0x10a4>
   91b30:      	adrp	x6, 0xa3000 <.text+0x10a8>
   91b34:      	adrp	x5, 0xa3000 <.text+0x10ac>
   91b38:      	adrp	x4, 0xa3000 <.text+0x10b0>
   91b3c:      	adrp	x3, 0xa3000 <.text+0x10b4>
   91b40:      	adrp	x2, 0xa3000 <.text+0x10b8>
   91b44:      	adrp	x1, 0xa3000 <.text+0x10bc>
   91b48:      	adrp	x8, 0xa3000 <.text+0x10c0>
   91b4c:      	mov	x29, sp
   91b50:      	ldr	x7, [x7, #3944]
   91b54:      	str	x19, [sp, #16]
   91b58:      	mov	x19, x0
   91b5c:      	ldr	x6, [x6, #3984]
   91b60:      	ldr	x5, [x5, #3952]
   91b64:      	ldr	x4, [x4, #3936]
   91b68:      	ldr	x3, [x3, #3960]
   91b6c:      	ldr	x2, [x2, #4064]
   91b70:      	ldr	x1, [x1, #3976]
   91b74:      	ldr	x0, [x8, #4024]
   91b78:      	str	xzr, [x29, #32]
   91b7c:      	bl	0x922b8 <JNI_OnLoad+0x518>
   91b80:      	cbnz	w0, 0x91ccc <.text+0x11fc>
   91b84:      	ldr	x3, [x19]
   91b88:      	mov	w2, #256
   91b8c:      	mov	x0, x19
   91b90:      	movk	w2, #12289, lsl #16
   91b94:      	add	x1, x29, #32
   91b98:      	ldr	x3, [x3, #48]
   91b9c:      	blr	x3
   91ba0:      	mov	w19, w0
   91ba4:      	cbnz	w0, 0x91c8c <.text+0x11bc>
   91ba8:      	ldr	x0, [x29, #32]
   91bac:      	mov	w2, #96
   91bb0:      	stp	xzr, xzr, [x29, #40]
   91bb4:      	mov	w1, #8
   91bb8:      	strb	w2, [x29, #44]
   91bbc:      	ldr	x2, [x0]
   91bc0:      	strb	w1, [x29, #40]
   91bc4:      	mov	w1, #-84
   91bc8:      	strb	w1, [x29, #43]
   91bcc:      	add	x1, x29, #40
   91bd0:      	ldr	x2, [x2, #1128]
   91bd4:      	blr	x2
   91bd8:      	cmp	w0, #98
   91bdc:      	ccmp	w0, #0, #4, ne
   91be0:      	b.ne	0x91c9c <.text+0x11cc>
   91be4:      	add	x3, x29, #56
   91be8:      	mov	x2, #280
   91bec:      	mov	w1, #0
   91bf0:      	mov	x0, x3
   91bf4:      	bl	0x90a40 <memset@plt>
   91bf8:      	mov	x1, x0
   91bfc:      	ldr	x5, [x29, #32]
   91c00:      	adrp	x4, 0xa3000 <.text+0x1178>
   91c04:      	mov	w2, #280
   91c08:      	mov	x0, x5
   91c0c:      	ldr	x3, [x4, #3920]
   91c10:      	ldr	x5, [x5]
   91c14:      	str	x3, [x29, #88]
   91c18:      	ldr	x3, [x5, #968]
   91c1c:      	blr	x3
   91c20:      	cbnz	w0, 0x91cb4 <.text+0x11e4>
   91c24:      	ldr	x4, [x29, #32]
   91c28:      	mov	x3, #0
   91c2c:      	mov	w2, #54
   91c30:      	mov	w1, #1
   91c34:      	mov	x0, x4
   91c38:      	ldr	x4, [x4]
   91c3c:      	ldr	x4, [x4, #8]
   91c40:      	blr	x4
   91c44:      	cbnz	w0, 0x91c68 <.text+0x1198>
   91c48:      	adrp	x0, 0xa3000 <.text+0x11c0>
   91c4c:      	mov	w1, #1
   91c50:      	ldr	x0, [x0, #4016]
   91c54:      	strb	w1, [x0]
   91c58:      	mov	w0, w19
   91c5c:      	ldr	x19, [sp, #16]
   91c60:      	ldp	x29, x30, [sp], #336
   91c64:      	ret
   91c68:      	mov	w19, w0
   91c6c:      	adrp	x0, 0x92000 <.text+0x11a0>
   91c70:      	mov	w1, w19
   91c74:      	add	x0, x0, #3320
   91c78:      	bl	0x90ab0 <printf@plt>
   91c7c:      	mov	w0, w19
   91c80:      	ldr	x19, [sp, #16]
   91c84:      	ldp	x29, x30, [sp], #336
   91c88:      	ret
   91c8c:      	adrp	x0, 0x92000 <.text+0x11c0>
   91c90:      	add	x0, x0, #3200
   91c94:      	bl	0x90a70 <puts@plt>
   91c98:      	b	0x91c58 <.text+0x1188>
   91c9c:      	mov	w19, w0
   91ca0:      	adrp	x0, 0x92000 <.text+0x11d4>
   91ca4:      	mov	w1, w19
   91ca8:      	add	x0, x0, #3240
   91cac:      	bl	0x90ab0 <printf@plt>
   91cb0:      	b	0x91c58 <.text+0x1188>
   91cb4:      	mov	w19, w0
   91cb8:      	adrp	x0, 0x92000 <.text+0x11ec>
   91cbc:      	mov	w1, w19
   91cc0:      	add	x0, x0, #3280
   91cc4:      	bl	0x90ab0 <printf@plt>
   91cc8:      	b	0x91c58 <.text+0x1188>
   91ccc:      	adrp	x0, 0x92000 <.text+0x1200>
   91cd0:      	mov	w19, #-1
   91cd4:      	add	x0, x0, #3160
   91cd8:      	bl	0x90a70 <puts@plt>
   91cdc:      	b	0x91c58 <.text+0x1188>
