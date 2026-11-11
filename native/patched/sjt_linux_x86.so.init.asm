
/Users/yanfei/Downloads/jiamiTest/analysis/sjt-agent/multiplatform/patched/sjt_linux_x86.so:	file format elf32-i386

Disassembly of section .text:

00022610 <.text>:
   22df0:      	pushl	%ebp
   22df1:      	pushl	%edi
   22df2:      	pushl	%esi
   22df3:      	pushl	%ebx
   22df4:      	xorl	%esi, %esi
   22df6:      	calll	0x22610 <.text>
   22dfb:      	addl	$12805, %ebx            # imm = 0x3205
   22e01:      	subl	$172, %esp
   22e07:      	leal	174808(%ebx), %ebp
   22e0d:      	cmpb	$0, (%ebp)
   22e11:      	je	0x22e20 <.text+0x810>
   22e13:      	addl	$172, %esp
   22e19:      	movl	%esi, %eax
   22e1b:      	popl	%ebx
   22e1c:      	popl	%esi
   22e1d:      	popl	%edi
   22e1e:      	popl	%ebp
   22e1f:      	retl
   22e20:      	movl	$0, (%esp)
   22e27:      	pushl	-56(%ebx)
   22e2d:      	pushl	-32(%ebx)
   22e33:      	pushl	-52(%ebx)
   22e39:      	pushl	-60(%ebx)
   22e3f:      	pushl	-44(%ebx)
   22e45:      	pushl	-4(%ebx)
   22e4b:      	pushl	-36(%ebx)
   22e51:      	pushl	-20(%ebx)
   22e57:      	calll	0x23480 <JNI_OnLoad+0x470>
   22e5c:      	addl	$32, %esp
   22e5f:      	testl	%eax, %eax
   22e61:      	jne	0x22fca <.text+0x9ba>
   22e67:      	subl	$4, %esp
   22e6a:      	movl	196(%esp), %eax
   22e71:      	movl	(%eax), %eax
   22e73:      	pushl	$805372160              # imm = 0x30010100
   22e78:      	leal	8(%esp), %edx
   22e7c:      	pushl	%edx
   22e7d:      	pushl	204(%esp)
   22e84:      	calll	*24(%eax)
   22e87:      	addl	$16, %esp
   22e8a:      	testl	%eax, %eax
   22e8c:      	movl	%eax, %esi
   22e8e:      	jne	0x22f90 <.text+0x980>
   22e94:      	movl	(%esp), %eax
   22e97:      	movl	$0, 4(%esp)
   22e9f:      	subl	$8, %esp
   22ea2:      	movl	$0, 16(%esp)
   22eaa:      	movl	$0, 20(%esp)
   22eb2:      	movl	$0, 24(%esp)
   22eba:      	movb	$0, 16(%esp)
   22ebf:      	movb	$8, 12(%esp)
   22ec4:      	movb	$-84, 15(%esp)
   22ec9:      	leal	12(%esp), %ecx
   22ecd:      	movl	(%eax), %edx
   22ecf:      	pushl	%ecx
   22ed0:      	pushl	%eax
   22ed1:      	calll	*564(%edx)
   22ed7:      	addl	$16, %esp
   22eda:      	testl	%eax, %eax
   22edc:      	je	0x22ee7 <.text+0x8d7>
   22ede:      	cmpl	$98, %eax
   22ee1:      	jne	0x22f70 <.text+0x960>
   22ee7:      	leal	20(%esp), %edi
   22eeb:      	xorl	%eax, %eax
   22eed:      	movl	$35, %ecx
   22ef2:      	subl	$4, %esp
   22ef5:      	rep		stosl	%eax, %es:(%edi)
   22ef7:      	leal	-14192(%ebx), %eax
   22efd:      	movl	%eax, 40(%esp)
   22f01:      	movl	4(%esp), %eax
   22f05:      	movl	(%eax), %edx
   22f07:      	pushl	$140
   22f0c:      	leal	28(%esp), %ecx
   22f10:      	pushl	%ecx
   22f11:      	pushl	%eax
   22f12:      	calll	*484(%edx)
   22f18:      	addl	$16, %esp
   22f1b:      	testl	%eax, %eax
   22f1d:      	jne	0x22fb0 <.text+0x9a0>
   22f23:      	movl	(%esp), %eax
   22f26:      	movl	(%eax), %edx
   22f28:      	pushl	$0
   22f2a:      	pushl	$54
   22f2c:      	pushl	$1
   22f2e:      	pushl	%eax
   22f2f:      	calll	*4(%edx)
   22f32:      	addl	$16, %esp
   22f35:      	testl	%eax, %eax
   22f37:      	jne	0x22f50 <.text+0x940>
   22f39:      	movb	$1, (%ebp)
   22f3d:      	addl	$172, %esp
   22f43:      	movl	%esi, %eax
   22f45:      	popl	%ebx
   22f46:      	popl	%esi
   22f47:      	popl	%edi
   22f48:      	popl	%ebp
   22f49:      	retl
   22f4a:      	leal	(%esi), %esi
   22f50:      	subl	$8, %esp
   22f53:      	movl	%eax, %esi
   22f55:      	pushl	%eax
   22f56:      	leal	-8736(%ebx), %eax
   22f5c:      	pushl	%eax
   22f5d:      	calll	0x22560 <printf@plt>
   22f62:      	addl	$16, %esp
   22f65:      	jmp	0x22e13 <.text+0x803>
   22f6a:      	leal	(%esi), %esi
   22f70:      	subl	$8, %esp
   22f73:      	movl	%eax, %esi
   22f75:      	pushl	%eax
   22f76:      	leal	-8816(%ebx), %eax
   22f7c:      	pushl	%eax
   22f7d:      	calll	0x22560 <printf@plt>
   22f82:      	addl	$16, %esp
   22f85:      	jmp	0x22e13 <.text+0x803>
   22f8a:      	leal	(%esi), %esi
   22f90:      	leal	-8856(%ebx), %eax
   22f96:      	subl	$12, %esp
   22f99:      	pushl	%eax
   22f9a:      	calll	0x225b0 <puts@plt>
   22f9f:      	addl	$16, %esp
   22fa2:      	jmp	0x22e13 <.text+0x803>
   22fa7:      	movl	%esi, %esi
   22fa9:      	leal	(%edi,%eiz), %edi
   22fb0:      	subl	$8, %esp
   22fb3:      	movl	%eax, %esi
   22fb5:      	pushl	%eax
   22fb6:      	leal	-8776(%ebx), %eax
   22fbc:      	pushl	%eax
   22fbd:      	calll	0x22560 <printf@plt>
   22fc2:      	addl	$16, %esp
   22fc5:      	jmp	0x22e13 <.text+0x803>
   22fca:      	leal	-8896(%ebx), %eax
   22fd0:      	subl	$12, %esp
   22fd3:      	orl	$-1, %esi
   22fd6:      	pushl	%eax
   22fd7:      	calll	0x225b0 <puts@plt>
   22fdc:      	addl	$16, %esp
   22fdf:      	jmp	0x22e13 <.text+0x803>
   22fe4:      	leal	(%esi), %esi
   22fea:      	leal	(%edi), %edi
