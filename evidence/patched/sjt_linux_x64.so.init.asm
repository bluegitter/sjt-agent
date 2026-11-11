
/Users/yanfei/Downloads/jiamiTest/analysis/sjt-agent/multiplatform/patched/sjt_linux_x64.so:	file format elf64-x86-64

Disassembly of section .text:

0000000000030828 <.text>:
   31af0:      	pushq	%rbx
   31af1:      	movq	%rdi, %rbx
   31af4:      	subq	$320, %rsp              # imm = 0x140
   31afb:      	leaq	2281534(%rip), %rcx     # 0x25eb40 <sysconf+0x25eb40>
   31b02:      	leaq	2281535(%rip), %rdx     # 0x25eb48 <sysconf+0x25eb48>
   31b09:      	leaq	2281492(%rip), %r9      # 0x25eb24 <sysconf+0x25eb24>
   31b10:      	leaq	2281489(%rip), %r8      # 0x25eb28 <sysconf+0x25eb28>
   31b17:      	leaq	2281522(%rip), %rsi     # 0x25eb50 <sysconf+0x25eb50>
   31b1e:      	leaq	2281523(%rip), %rdi     # 0x25eb58 <sysconf+0x25eb58>
   31b25:      	movq	$0, 8(%rsp)
   31b2e:      	pushq	2106532(%rip)           # 0x233fd8 <sysconf+0x233fd8>
   31b34:      	pushq	2106542(%rip)           # 0x233fe8 <sysconf+0x233fe8>
   31b3a:      	callq	0x32190 <JNI_OnLoad+0x440>
   31b3f:      	testl	%eax, %eax
   31b41:      	popq	%rdx
   31b42:      	popq	%rcx
   31b43:      	jne	0x31c74 <.text+0x144c>
   31b49:      	movq	(%rbx), %rax
   31b4c:      	movq	%rbx, %rdi
   31b4f:      	leaq	8(%rsp), %rsi
   31b54:      	movl	$805372160, %edx        # imm = 0x30010100
   31b59:      	callq	*48(%rax)
   31b5c:      	testl	%eax, %eax
   31b5e:      	movl	%eax, %ebx
   31b60:      	jne	0x31c48 <.text+0x1420>
   31b66:      	movq	8(%rsp), %rdi
   31b6b:      	pxor	%xmm0, %xmm0
   31b6f:      	leaq	16(%rsp), %rsi
   31b74:      	movq	(%rdi), %rax
   31b77:      	movaps	%xmm0, 16(%rsp)
   31b7c:      	movb	$0, 20(%rsp)
   31b81:      	movb	$8, 16(%rsp)
   31b86:      	movb	$-84, 19(%rsp)
   31b8b:      	callq	*1128(%rax)
   31b91:      	testl	%eax, %eax
   31b93:      	je	0x31b9e <.text+0x1376>
   31b95:      	cmpl	$98, %eax
   31b98:      	jne	0x31c30 <.text+0x1408>
   31b9e:      	leaq	32(%rsp), %rdi
   31ba3:      	xorl	%eax, %eax
   31ba5:      	movl	$35, %ecx
   31baa:      	leaq	32(%rsp), %rsi
   31baf:      	movl	$280, %edx              # imm = 0x118
   31bb4:      	rep		stosq	%rax, %es:(%rdi)
   31bb7:      	leaq	-1710(%rip), %rax       # 0x31510 <.text+0xce8>
   31bbe:      	movq	8(%rsp), %rdi
   31bc3:      	movq	%rax, 64(%rsp)
   31bc8:      	movq	(%rdi), %rax
   31bcb:      	callq	*968(%rax)
   31bd1:      	testl	%eax, %eax
   31bd3:      	jne	0x31c60 <.text+0x1438>
   31bd9:      	movq	8(%rsp), %rdi
   31bde:      	xorl	%ecx, %ecx
   31be0:      	xorl	%eax, %eax
   31be2:      	movl	$54, %edx
   31be7:      	movl	$1, %esi
   31bec:      	movq	(%rdi), %r8
   31bef:      	callq	*8(%r8)
   31bf3:      	testl	%eax, %eax
   31bf5:      	jne	0x31c10 <.text+0x13e8>
   31bf7:      	leaq	2281250(%rip), %rax     # 0x25eb20 <sysconf+0x25eb20>
   31bfe:      	movb	$1, (%rax)
   31c01:      	addq	$320, %rsp              # imm = 0x140
   31c08:      	movl	%ebx, %eax
   31c0a:      	popq	%rbx
   31c0b:      	retq
   31c0c:      	nopl	(%rax)
   31c10:      	leaq	3969(%rip), %rdi        # 0x32b98 <sysconf+0x32b98>
   31c17:      	movl	%eax, %ebx
   31c19:      	movl	%eax, %esi
   31c1b:      	xorl	%eax, %eax
   31c1d:      	callq	0x307c0 <printf@plt>
   31c22:      	addq	$320, %rsp              # imm = 0x140
   31c29:      	movl	%ebx, %eax
   31c2b:      	popq	%rbx
   31c2c:      	retq
   31c2d:      	nopl	(%rax)
   31c30:      	leaq	3857(%rip), %rdi        # 0x32b48 <sysconf+0x32b48>
   31c37:      	movl	%eax, %ebx
   31c39:      	movl	%eax, %esi
   31c3b:      	xorl	%eax, %eax
   31c3d:      	callq	0x307c0 <printf@plt>
   31c42:      	jmp	0x31c01 <.text+0x13d9>
   31c44:      	nopl	(%rax)
   31c48:      	leaq	3793(%rip), %rdi        # 0x32b20 <sysconf+0x32b20>
   31c4f:      	callq	0x307a0 <puts@plt>
   31c54:      	jmp	0x31c01 <.text+0x13d9>
   31c56:      	nopw	%cs:(%rax,%rax)
   31c60:      	leaq	3849(%rip), %rdi        # 0x32b70 <sysconf+0x32b70>
   31c67:      	movl	%eax, %ebx
   31c69:      	movl	%eax, %esi
   31c6b:      	xorl	%eax, %eax
   31c6d:      	callq	0x307c0 <printf@plt>
   31c72:      	jmp	0x31c01 <.text+0x13d9>
   31c74:      	leaq	3709(%rip), %rdi        # 0x32af8 <sysconf+0x32af8>
   31c7b:      	movl	$4294967295, %ebx       # imm = 0xFFFFFFFF
   31c80:      	callq	0x307a0 <puts@plt>
   31c85:      	jmp	0x31c01 <.text+0x13d9>
   31c8a:      	nopw	(%rax,%rax)
