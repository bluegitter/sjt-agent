
/Users/yanfei/Downloads/jiamiTest/analysis/sjt-agent/multiplatform/original/sjt_linux_a32hf.so:	file format elf32-littlearm

Disassembly of section .text:

0003c714 <.text>:
   3cc28:      	push.w	{r4, r5, r6, r7, r8, lr}
   3cc2c:      	movs	r5, #0
   3cc2e:      	ldr	r4, [pc, #292]          @ 0x3cd54 <.text+0x640>
   3cc30:      	sub	sp, #176
   3cc32:      	ldr	r3, [pc, #292]          @ 0x3cd58 <.text+0x644>
   3cc34:      	add	r4, pc
   3cc36:      	ldr	r6, [r4, r3]
   3cc38:      	ldrb	r3, [r6]
   3cc3a:      	cbz	r3, 0x3cc44 <.text+0x530> @ imm = #6
   3cc3c:      	mov	r0, r5
   3cc3e:      	add	sp, #176
   3cc40:      	pop.w	{r4, r5, r6, r7, r8, pc}
   3cc44:      	ldr	r2, [pc, #276]          @ 0x3cd5c <.text+0x648>
   3cc46:      	mov	r8, r0
   3cc48:      	str	r3, [sp, #16]
   3cc4a:      	ldr	r1, [pc, #276]          @ 0x3cd60 <.text+0x64c>
   3cc4c:      	ldr	r2, [r4, r2]
   3cc4e:      	ldr	r3, [pc, #276]          @ 0x3cd64 <.text+0x650>
   3cc50:      	ldr	r0, [pc, #276]          @ 0x3cd68 <.text+0x654>
   3cc52:      	mov	r5, r2
   3cc54:      	ldr	r2, [pc, #276]          @ 0x3cd6c <.text+0x658>
   3cc56:      	ldr	r7, [pc, #280]          @ 0x3cd70 <.text+0x65c>
   3cc58:      	ldr	r3, [r4, r3]
   3cc5a:      	ldr	r2, [r4, r2]
   3cc5c:      	ldr	r1, [r4, r1]
   3cc5e:      	ldr	r0, [r4, r0]
   3cc60:      	str	r5, [sp, #12]
   3cc62:      	ldr	r5, [r4, r7]
   3cc64:      	ldr	r7, [pc, #268]          @ 0x3cd74 <.text+0x660>
   3cc66:      	str	r5, [sp, #8]
   3cc68:      	ldr	r5, [r4, r7]
   3cc6a:      	ldr	r7, [pc, #268]          @ 0x3cd78 <.text+0x664>
   3cc6c:      	str	r5, [sp, #4]
   3cc6e:      	ldr	r7, [r4, r7]
   3cc70:      	str	r7, [sp]
   3cc72:      	bl	0x3d05c <JNI_OnLoad+0x2c4> @ imm = #998
   3cc76:      	cmp	r0, #0
   3cc78:      	bne	0x3cd44 <.text+0x630>   @ imm = #200
   3cc7a:      	ldr.w	r3, [r8]
   3cc7e:      	mov	r0, r8
   3cc80:      	mov.w	r2, #256
   3cc84:      	add	r1, sp, #16
   3cc86:      	movt	r2, #12289
   3cc8a:      	ldr	r3, [r3, #24]
   3cc8c:      	blx	r3
   3cc8e:      	mov	r5, r0
   3cc90:      	cmp	r0, #0
   3cc92:      	bne	0x3cd1e <.text+0x60a>   @ imm = #136
   3cc94:      	ldr	r0, [sp, #16]
   3cc96:      	add	r1, sp, #20
   3cc98:      	uxtb	r3, r5
   3cc9a:      	str	r5, [r1, #4]
   3cc9c:      	orr	r3, r3, #96
   3cca0:      	uxtb	r2, r5
   3cca2:      	ldr	r7, [r0]
   3cca4:      	orr	r2, r2, #8
   3cca8:      	strb.w	r3, [sp, #24]
   3ccac:      	lsrs	r3, r5, #24
   3ccae:      	str	r5, [sp, #20]
   3ccb0:      	orr	r3, r3, #172
   3ccb4:      	strd	r5, r5, [r1, #8]
   3ccb8:      	strb.w	r3, [sp, #23]
   3ccbc:      	ldr.w	r7, [r7, #564]
   3ccc0:      	strb.w	r2, [sp, #20]
   3ccc4:      	blx	r7
   3ccc6:      	cmp	r0, #0
   3ccc8:      	it	ne
   3ccca:      	cmpne	r0, #98
   3cccc:      	mov	r3, r0
   3ccce:      	bne	0x3cd28 <.text+0x614>   @ imm = #86
   3ccd0:      	add	r3, sp, #36
   3ccd2:      	movs	r2, #140
   3ccd4:      	mov	r1, r5
   3ccd6:      	ldr	r7, [pc, #164]          @ 0x3cd7c <.text+0x668>
   3ccd8:      	mov	r0, r3
   3ccda:      	blx	0x3c6dc <.plt+0xa4>     @ imm = #-1536
   3ccde:      	movs	r2, #140
   3cce0:      	ldr	r4, [r4, r7]
   3cce2:      	mov	r3, r0
   3cce4:      	ldr	r0, [sp, #16]
   3cce6:      	mov	r1, r3
   3cce8:      	ldr	r3, [r0]
   3ccea:      	str	r4, [sp, #52]
   3ccec:      	ldr.w	r3, [r3, #484]
   3ccf0:      	blx	r3
   3ccf2:      	cbnz	r0, 0x3cd36 <.text+0x622> @ imm = #64
   3ccf4:      	ldr	r0, [sp, #16]
   3ccf6:      	mov	r3, r5
   3ccf8:      	movs	r2, #54
   3ccfa:      	movs	r1, #1
   3ccfc:      	ldr	r4, [r0]
   3ccfe:      	ldr	r4, [r4, #4]
   3cd00:      	blx	r4
   3cd02:      	cbnz	r0, 0x3cd10 <.text+0x5fc> @ imm = #10
   3cd04:      	movs	r3, #1
   3cd06:      	mov	r0, r5
   3cd08:      	strb	r3, [r6]
   3cd0a:      	add	sp, #176
   3cd0c:      	pop.w	{r4, r5, r6, r7, r8, pc}
   3cd10:      	mov	r5, r0
   3cd12:      	ldr	r0, [pc, #108]          @ 0x3cd80 <.text+0x66c>
   3cd14:      	mov	r1, r5
   3cd16:      	add	r0, pc
   3cd18:      	blx	0x3c680 <.plt+0x48>     @ imm = #-1692
   3cd1c:      	b	0x3cc3c <.text+0x528>   @ imm = #-228
   3cd1e:      	ldr	r0, [pc, #100]          @ 0x3cd84 <.text+0x670>
   3cd20:      	add	r0, pc
   3cd22:      	blx	0x3c6b8 <.plt+0x80>     @ imm = #-1644
   3cd26:      	b	0x3cc3c <.text+0x528>   @ imm = #-238
   3cd28:      	mov	r5, r0
   3cd2a:      	ldr	r0, [pc, #92]           @ 0x3cd88 <.text+0x674>
   3cd2c:      	mov	r1, r3
   3cd2e:      	add	r0, pc
   3cd30:      	blx	0x3c680 <.plt+0x48>     @ imm = #-1716
   3cd34:      	b	0x3cc3c <.text+0x528>   @ imm = #-252
   3cd36:      	mov	r5, r0
   3cd38:      	ldr	r0, [pc, #80]           @ 0x3cd8c <.text+0x678>
   3cd3a:      	mov	r1, r5
   3cd3c:      	add	r0, pc
   3cd3e:      	blx	0x3c680 <.plt+0x48>     @ imm = #-1728
   3cd42:      	b	0x3cc3c <.text+0x528>   @ imm = #-266
   3cd44:      	ldr	r0, [pc, #72]           @ 0x3cd90 <.text+0x67c>
   3cd46:      	mov.w	r5, #4294967295
   3cd4a:      	add	r0, pc
   3cd4c:      	blx	0x3c6b8 <.plt+0x80>     @ imm = #-1688
   3cd50:      	b	0x3cc3c <.text+0x528>   @ imm = #-280
