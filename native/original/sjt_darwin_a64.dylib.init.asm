
/Users/yanfei/Downloads/jiamiTest/analysis/sjt-agent/multiplatform/original/sjt_darwin_a64.dylib:	file format mach-o arm64

Disassembly of section __TEXT,__text:

000000000007a6cc <__text>:
   7ae20:      	sub	sp, sp, #384
   7ae24:      	stp	x22, x21, [sp, #336]
   7ae28:      	stp	x20, x19, [sp, #352]
   7ae2c:      	stp	x29, x30, [sp, #368]
   7ae30:      	add	x29, sp, #368
   7ae34:      	adrp	x20, 0xaa000 <__text+0x828>
   7ae38:      	ldrb	w8, [x20, #2804]
   7ae3c:      	cbz	w8, 0x7ae48 <__text+0x77c>
   7ae40:      	mov	w19, #0
   7ae44:      	b	0x7aedc <__text+0x810>
   7ae48:      	mov	x19, x0
   7ae4c:      	stur	xzr, [x29, #-40]
   7ae50:      	adr	x0, #195688
   7ae54:      	nop
   7ae58:      	adr	x1, #195688
   7ae5c:      	nop
   7ae60:      	adr	x2, #195688
   7ae64:      	nop
   7ae68:      	adr	x3, #195688
   7ae6c:      	nop
   7ae70:      	adr	x4, #195704
   7ae74:      	nop
   7ae78:      	adr	x5, #195704
   7ae7c:      	nop
   7ae80:      	adr	x6, #195672
   7ae84:      	nop
   7ae88:      	adr	x7, #195672
   7ae8c:      	nop
   7ae90:      	bl	0x7b45c <__text+0xd90>
   7ae94:      	cbz	w0, 0x7aeac <__text+0x7e0>
   7ae98:      	adr	x0, #4306
   7ae9c:      	nop
   7aea0:      	bl	0x7bca8 <_JNI_OnLoad+0xcb8>
   7aea4:      	mov	w19, #-1
   7aea8:      	b	0x7aedc <__text+0x810>
   7aeac:      	ldr	x8, [x19]
   7aeb0:      	ldr	x8, [x8, #48]
   7aeb4:      	sub	x1, x29, #40
   7aeb8:      	mov	x0, x19
   7aebc:      	mov	w2, #256
   7aec0:      	movk	w2, #12289, lsl #16
   7aec4:      	blr	x8
   7aec8:      	cbz	w0, 0x7aef4 <__text+0x828>
   7aecc:      	mov	x19, x0
   7aed0:      	adr	x0, #4213
   7aed4:      	nop
   7aed8:      	bl	0x7bca8 <_JNI_OnLoad+0xcb8>
   7aedc:      	mov	x0, x19
   7aee0:      	ldp	x29, x30, [sp, #368]
   7aee4:      	ldp	x20, x19, [sp, #352]
   7aee8:      	ldp	x22, x21, [sp, #336]
   7aeec:      	add	sp, sp, #384
   7aef0:      	ret
   7aef4:      	mov	x8, #8
   7aef8:      	movk	x8, #44032, lsl #16
   7aefc:      	movk	x8, #96, lsl #32
   7af00:      	stp	x8, xzr, [x29, #-64]
   7af04:      	ldur	x0, [x29, #-40]
   7af08:      	ldr	x8, [x0]
   7af0c:      	ldr	x8, [x8, #1128]
   7af10:      	sub	x1, x29, #64
   7af14:      	blr	x8
   7af18:      	cbz	w0, 0x7af28 <__text+0x85c>
   7af1c:      	mov	x19, x0
   7af20:      	cmp	w0, #98
   7af24:      	b.ne	0x7af94 <__text+0x8c8>
   7af28:      	str	xzr, [sp, #288]
   7af2c:      	movi.2d	v0, #0000000000000000
   7af30:      	stp	q0, q0, [sp, #256]
   7af34:      	stp	q0, q0, [sp, #224]
   7af38:      	stp	q0, q0, [sp, #192]
   7af3c:      	stp	q0, q0, [sp, #160]
   7af40:      	stp	q0, q0, [sp, #128]
   7af44:      	stp	q0, q0, [sp, #96]
   7af48:      	stp	q0, q0, [sp, #64]
   7af4c:      	stp	q0, q0, [sp, #32]
   7af50:      	str	q0, [sp, #16]
   7af54:      	adr	x8, #-1572
   7af58:      	nop
   7af5c:      	str	x8, [sp, #48]
   7af60:      	ldur	x0, [x29, #-40]
   7af64:      	ldr	x8, [x0]
   7af68:      	ldr	x8, [x8, #968]
   7af6c:      	add	x1, sp, #16
   7af70:      	mov	w2, #280
   7af74:      	blr	x8
   7af78:      	cbz	w0, 0x7afa8 <__text+0x8dc>
   7af7c:      	mov	x19, x0
   7af80:      	str	x19, [sp]
   7af84:      	adr	x0, #3955
   7af88:      	nop
   7af8c:      	bl	0x7bc90 <_JNI_OnLoad+0xca0>
   7af90:      	b	0x7aedc <__text+0x810>
   7af94:      	str	x19, [sp]
   7af98:      	adr	x0, #3896
   7af9c:      	nop
   7afa0:      	bl	0x7bc90 <_JNI_OnLoad+0xca0>
   7afa4:      	b	0x7aedc <__text+0x810>
   7afa8:      	ldur	x0, [x29, #-40]
   7afac:      	ldr	x8, [x0]
   7afb0:      	ldr	x8, [x8, #8]
   7afb4:      	mov	w21, #1
   7afb8:      	mov	w1, #1
   7afbc:      	mov	w2, #54
   7afc0:      	mov	x3, #0
   7afc4:      	blr	x8
   7afc8:      	mov	x19, x0
   7afcc:      	cbz	w0, 0x7afe4 <__text+0x918>
   7afd0:      	str	x19, [sp]
   7afd4:      	adr	x0, #3914
   7afd8:      	nop
   7afdc:      	bl	0x7bc90 <_JNI_OnLoad+0xca0>
   7afe0:      	b	0x7aedc <__text+0x810>
   7afe4:      	strb	w21, [x20, #2804]
   7afe8:      	b	0x7aedc <__text+0x810>
   7afec:      	b	0x7ae20 <__text+0x754>
