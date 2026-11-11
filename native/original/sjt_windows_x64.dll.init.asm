
/Users/yanfei/Downloads/jiamiTest/analysis/sjt-agent/multiplatform/original/sjt_windows_x64.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180001000 <.text>:
180001170:     	pushq	%rbx
180001172:     	subq	$400, %rsp              # imm = 0x190
180001179:     	movq	309480(%rip), %rax      # 0x18004ca68
180001180:     	xorq	%rsp, %rax
180001183:     	movq	%rax, 384(%rsp)
18000118b:     	cmpb	$0, 312238(%rip)        # 0x18004d540
180001192:     	movq	%rcx, %rbx
180001195:     	jne	0x180001316 <.text+0x316>
18000119b:     	leaq	312206(%rip), %rax      # 0x18004d530
1800011a2:     	movq	$0, 64(%rsp)
1800011ab:     	movq	%rax, 56(%rsp)
1800011b0:     	leaq	312165(%rip), %r9       # 0x18004d51c
1800011b7:     	leaq	312170(%rip), %rax      # 0x18004d528
1800011be:     	movq	%rax, 48(%rsp)
1800011c3:     	leaq	312150(%rip), %r8       # 0x18004d520
1800011ca:     	leaq	312163(%rip), %rax      # 0x18004d534
1800011d1:     	movq	%rax, 40(%rsp)
1800011d6:     	leaq	312123(%rip), %rdx      # 0x18004d518
1800011dd:     	leaq	312148(%rip), %rax      # 0x18004d538
1800011e4:     	leaq	312101(%rip), %rcx      # 0x18004d510
1800011eb:     	movq	%rax, 32(%rsp)
1800011f0:     	callq	0x180001ea0 <JNI_OnLoad+0x7d0>
1800011f5:     	testl	%eax, %eax
1800011f7:     	je	0x18000120f <.text+0x20f>
1800011f9:     	leaq	90456(%rip), %rcx       # 0x180017358
180001200:     	callq	0x180001700 <JNI_OnLoad+0x30>
180001205:     	movl	$4294967295, %eax       # imm = 0xFFFFFFFF
18000120a:     	jmp	0x180001318 <.text+0x318>
18000120f:     	movq	(%rbx), %rax
180001212:     	leaq	64(%rsp), %rdx
180001217:     	movl	$805372160, %r8d        # imm = 0x30010100
18000121d:     	movq	%rbx, %rcx
180001220:     	callq	*48(%rax)
180001223:     	movl	%eax, %ebx
180001225:     	testl	%eax, %eax
180001227:     	je	0x18000123c <.text+0x23c>
180001229:     	leaq	90448(%rip), %rcx       # 0x180017380
180001230:     	callq	0x180001700 <JNI_OnLoad+0x30>
180001235:     	movl	%ebx, %eax
180001237:     	jmp	0x180001318 <.text+0x318>
18000123c:     	movq	64(%rsp), %rcx
180001241:     	leaq	368(%rsp), %rdx
180001249:     	xorps	%xmm0, %xmm0
18000124c:     	movups	%xmm0, 368(%rsp)
180001254:     	orl	$2885681160, 368(%rsp)  # imm = 0xAC000008
18000125f:     	movl	$96, 372(%rsp)
18000126a:     	movq	(%rcx), %rax
18000126d:     	callq	*1128(%rax)
180001273:     	movl	%eax, %ebx
180001275:     	testl	%eax, %eax
180001277:     	je	0x180001293 <.text+0x293>
180001279:     	cmpl	$98, %eax
18000127c:     	je	0x180001293 <.text+0x293>
18000127e:     	movl	%eax, %edx
180001280:     	leaq	90401(%rip), %rcx       # 0x1800173a8
180001287:     	callq	0x180001700 <JNI_OnLoad+0x30>
18000128c:     	movl	%ebx, %eax
18000128e:     	jmp	0x180001318 <.text+0x318>
180001293:     	xorl	%edx, %edx
180001295:     	leaq	80(%rsp), %rcx
18000129a:     	movl	$280, %r8d              # imm = 0x118
1800012a0:     	callq	0x1800039b0 <JNI_OnLoad+0x22e0>
1800012a5:     	movq	64(%rsp), %rcx
1800012aa:     	leaq	143(%rip), %rax         # 0x180001340 <.text+0x340>
1800012b1:     	movq	%rax, 112(%rsp)
1800012b6:     	leaq	80(%rsp), %rdx
1800012bb:     	movl	$280, %r8d              # imm = 0x118
1800012c1:     	movq	(%rcx), %rax
1800012c4:     	callq	*968(%rax)
1800012ca:     	movl	%eax, %ebx
1800012cc:     	testl	%eax, %eax
1800012ce:     	je	0x1800012e2 <.text+0x2e2>
1800012d0:     	movl	%eax, %edx
1800012d2:     	leaq	90359(%rip), %rcx       # 0x1800173d0
1800012d9:     	callq	0x180001700 <JNI_OnLoad+0x30>
1800012de:     	movl	%ebx, %eax
1800012e0:     	jmp	0x180001318 <.text+0x318>
1800012e2:     	movq	64(%rsp), %rcx
1800012e7:     	xorl	%r9d, %r9d
1800012ea:     	leal	1(%r9), %edx
1800012ee:     	leal	54(%r9), %r8d
1800012f2:     	callq	0x180001160 <.text+0x160>
1800012f7:     	movl	%eax, %ebx
1800012f9:     	testl	%eax, %eax
1800012fb:     	je	0x18000130f <.text+0x30f>
1800012fd:     	movl	%eax, %edx
1800012ff:     	leaq	90354(%rip), %rcx       # 0x1800173f8
180001306:     	callq	0x180001700 <JNI_OnLoad+0x30>
18000130b:     	movl	%ebx, %eax
18000130d:     	jmp	0x180001318 <.text+0x318>
18000130f:     	movb	$1, 311850(%rip)        # 0x18004d540
180001316:     	xorl	%eax, %eax
180001318:     	movq	384(%rsp), %rcx
180001320:     	xorq	%rsp, %rcx
180001323:     	callq	0x180002500 <JNI_OnLoad+0xe30>
180001328:     	addq	$400, %rsp              # imm = 0x190
18000132f:     	popq	%rbx
180001330:     	retq
