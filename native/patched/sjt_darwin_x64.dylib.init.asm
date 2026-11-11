
/Users/yanfei/Downloads/jiamiTest/analysis/sjt-agent/multiplatform/patched/sjt_darwin_x64.dylib:	file format mach-o 64-bit x86-64

Disassembly of section __TEXT,__text:

00000000000026e0 <__text>:
    2e00:      	pushq	%rbp
    2e01:      	movq	%rsp, %rbp
    2e04:      	pushq	%r14
    2e06:      	pushq	%rbx
    2e07:      	subq	$304, %rsp              ## imm = 0x130
    2e0e:      	xorl	%ebx, %ebx
    2e10:      	cmpb	$0, 195845(%rip)        ## 0x32b1c <dyld_stub_binder+0x32b1c>
    2e17:      	jne	0x2f36 <__text+0x856>
    2e1d:      	movq	%rdi, %r14
    2e20:      	movq	$0, -24(%rbp)
    2e28:      	leaq	195801(%rip), %rax      ## 0x32b08 <dyld_stub_binder+0x32b08>
    2e2f:      	leaq	195786(%rip), %rbx      ## 0x32b00 <dyld_stub_binder+0x32b00>
    2e36:      	leaq	195747(%rip), %rdi      ## 0x32ae0 <dyld_stub_binder+0x32ae0>
    2e3d:      	leaq	195748(%rip), %rsi      ## 0x32ae8 <dyld_stub_binder+0x32ae8>
    2e44:      	leaq	195749(%rip), %rdx      ## 0x32af0 <dyld_stub_binder+0x32af0>
    2e4b:      	leaq	195750(%rip), %rcx      ## 0x32af8 <dyld_stub_binder+0x32af8>
    2e52:      	leaq	195767(%rip), %r8       ## 0x32b10 <dyld_stub_binder+0x32b10>
    2e59:      	leaq	195768(%rip), %r9       ## 0x32b18 <dyld_stub_binder+0x32b18>
    2e60:      	pushq	%rax
    2e61:      	pushq	%rbx
    2e62:      	callq	0x3480 <_JNI_OnLoad+0x4e0>
    2e67:      	addq	$16, %rsp
    2e6b:      	testl	%eax, %eax
    2e6d:      	je	0x2e85 <__text+0x7a5>
    2e6f:      	leaq	4338(%rip), %rdi        ## 0x3f68 <dyld_stub_binder+0x3f68>
    2e76:      	callq	0x3ce2 <dyld_stub_binder+0x3ce2>
    2e7b:      	movl	$4294967295, %ebx       ## imm = 0xFFFFFFFF
    2e80:      	jmp	0x2f36 <__text+0x856>
    2e85:      	movq	(%r14), %rax
    2e88:      	leaq	-24(%rbp), %rsi
    2e8c:      	movq	%r14, %rdi
    2e8f:      	movl	$805372160, %edx        ## imm = 0x30010100
    2e94:      	callq	*48(%rax)
    2e97:      	testl	%eax, %eax
    2e99:      	je	0x2eae <__text+0x7ce>
    2e9b:      	movl	%eax, %ebx
    2e9d:      	leaq	4255(%rip), %rdi        ## 0x3f43 <dyld_stub_binder+0x3f43>
    2ea4:      	callq	0x3ce2 <dyld_stub_binder+0x3ce2>
    2ea9:      	jmp	0x2f36 <__text+0x856>
    2eae:      	movabsq	$2885681160, %rax       ## imm = 0xAC000008
    2eb8:      	movq	%rax, -40(%rbp)
    2ebc:      	movq	$0, -32(%rbp)
    2ec4:      	movq	-24(%rbp), %rdi
    2ec8:      	movq	(%rdi), %rax
    2ecb:      	leaq	-40(%rbp), %rsi
    2ecf:      	callq	*1128(%rax)
    2ed5:      	testl	%eax, %eax
    2ed7:      	je	0x2ee0 <__text+0x800>
    2ed9:      	movl	%eax, %ebx
    2edb:      	cmpl	$98, %eax
    2ede:      	jne	0x2f26 <__text+0x846>
    2ee0:      	leaq	-320(%rbp), %rbx
    2ee7:      	movl	$280, %esi              ## imm = 0x118
    2eec:      	movq	%rbx, %rdi
    2eef:      	callq	0x3cb2 <dyld_stub_binder+0x3cb2>
    2ef4:      	leaq	-1435(%rip), %rax       ## 0x2960 <__text+0x280>
    2efb:      	movq	%rax, -288(%rbp)
    2f02:      	movq	-24(%rbp), %rdi
    2f06:      	movq	(%rdi), %rax
    2f09:      	movq	%rbx, %rsi
    2f0c:      	movl	$280, %edx              ## imm = 0x118
    2f11:      	callq	*968(%rax)
    2f17:      	testl	%eax, %eax
    2f19:      	je	0x2f44 <__text+0x864>
    2f1b:      	movl	%eax, %ebx
    2f1d:      	leaq	4049(%rip), %rdi        ## 0x3ef5 <dyld_stub_binder+0x3ef5>
    2f24:      	jmp	0x2f2d <__text+0x84d>
    2f26:      	leaq	4001(%rip), %rdi        ## 0x3ece <dyld_stub_binder+0x3ece>
    2f2d:      	movl	%ebx, %esi
    2f2f:      	xorl	%eax, %eax
    2f31:      	callq	0x3cd6 <dyld_stub_binder+0x3cd6>
    2f36:      	movl	%ebx, %eax
    2f38:      	addq	$304, %rsp              ## imm = 0x130
    2f3f:      	popq	%rbx
    2f40:      	popq	%r14
    2f42:      	popq	%rbp
    2f43:      	retq
    2f44:      	movq	-24(%rbp), %rdi
    2f48:      	movq	(%rdi), %r8
    2f4b:      	xorl	%ebx, %ebx
    2f4d:      	movl	$1, %esi
    2f52:      	movl	$54, %edx
    2f57:      	xorl	%ecx, %ecx
    2f59:      	xorl	%eax, %eax
    2f5b:      	callq	*8(%r8)
    2f5f:      	testl	%eax, %eax
    2f61:      	je	0x2f7b <__text+0x89b>
    2f63:      	movl	%eax, %r14d
    2f66:      	leaq	4015(%rip), %rdi        ## 0x3f1c <dyld_stub_binder+0x3f1c>
    2f6d:      	movl	%eax, %esi
    2f6f:      	xorl	%eax, %eax
    2f71:      	callq	0x3cd6 <dyld_stub_binder+0x3cd6>
    2f76:      	movl	%r14d, %ebx
    2f79:      	jmp	0x2f36 <__text+0x856>
    2f7b:      	movb	$1, 195482(%rip)        ## 0x32b1c <dyld_stub_binder+0x32b1c>
    2f82:      	jmp	0x2f36 <__text+0x856>
    2f84:      	nopw	%cs:(%rax,%rax)
    2f8e:      	nop
