
/Users/yanfei/Downloads/jiamiTest/analysis/sjt-agent/multiplatform/patched/sjt_windows_x86.dll:	file format coff-i386

Disassembly of section .text:

10001000 <.text>:
10001130:      	subl	$164, %esp
10001136:      	movl	268724792, %eax
1000113b:      	xorl	%esp, %eax
1000113d:      	movl	%eax, 160(%esp)
10001144:      	cmpb	$0, 268727128
1000114b:      	pushl	%esi
1000114c:      	movl	172(%esp), %esi
10001153:      	jne	0x10001307 <.text+0x307>
10001159:      	pushl	$268727116              # imm = 0x1004734C
1000115e:      	pushl	$268727112              # imm = 0x10047348
10001163:      	pushl	$268727124              # imm = 0x10047354
10001168:      	pushl	$268727120              # imm = 0x10047350
1000116d:      	pushl	$268727108              # imm = 0x10047344
10001172:      	pushl	$268727104              # imm = 0x10047340
10001177:      	pushl	$268727100              # imm = 0x1004733C
1000117c:      	pushl	$268727096              # imm = 0x10047338
10001181:      	movl	$0, 36(%esp)
10001189:      	calll	0x10001ca0 <JNI_OnLoad+0x6a0>
1000118e:      	addl	$32, %esp
10001191:      	testl	%eax, %eax
10001193:      	je	0x100011bb <.text+0x1bb>
10001195:      	pushl	$268521884              # imm = 0x1001519C
1000119a:      	calll	0x10001630 <JNI_OnLoad+0x30>
1000119f:      	addl	$4, %esp
100011a2:      	orl	$-1, %eax
100011a5:      	popl	%esi
100011a6:      	movl	160(%esp), %ecx
100011ad:      	xorl	%esp, %ecx
100011af:      	calll	0x10002162 <JNI_OnLoad+0xb62>
100011b4:      	addl	$164, %esp
100011ba:      	retl
100011bb:      	movl	(%esi), %eax
100011bd:      	leal	4(%esp), %ecx
100011c1:      	pushl	$805372160              # imm = 0x30010100
100011c6:      	pushl	%ecx
100011c7:      	pushl	%esi
100011c8:      	movl	24(%eax), %eax
100011cb:      	calll	*%eax
100011cd:      	movl	%eax, %esi
100011cf:      	testl	%esi, %esi
100011d1:      	je	0x100011f8 <.text+0x1f8>
100011d3:      	pushl	$268521924              # imm = 0x100151C4
100011d8:      	calll	0x10001630 <JNI_OnLoad+0x30>
100011dd:      	addl	$4, %esp
100011e0:      	movl	%esi, %eax
100011e2:      	popl	%esi
100011e3:      	movl	160(%esp), %ecx
100011ea:      	xorl	%esp, %ecx
100011ec:      	calll	0x10002162 <JNI_OnLoad+0xb62>
100011f1:      	addl	$164, %esp
100011f7:      	retl
100011f8:      	movl	4(%esp), %eax
100011fc:      	leal	148(%esp), %edx
10001203:      	xorps	%xmm0, %xmm0
10001206:      	movups	%xmm0, 148(%esp)
1000120e:      	orl	$2885681160, 148(%esp)  # imm = 0xAC000008
10001219:      	movl	$0, 152(%esp)
10001224:      	movl	(%eax), %ecx
10001226:      	pushl	%edx
10001227:      	pushl	%eax
10001228:      	movl	564(%ecx), %eax
1000122e:      	calll	*%eax
10001230:      	movl	%eax, %esi
10001232:      	testl	%esi, %esi
10001234:      	je	0x10001261 <.text+0x261>
10001236:      	cmpl	$98, %esi
10001239:      	je	0x10001261 <.text+0x261>
1000123b:      	pushl	%esi
1000123c:      	pushl	$268521964              # imm = 0x100151EC
10001241:      	calll	0x10001630 <JNI_OnLoad+0x30>
10001246:      	addl	$8, %esp
10001249:      	movl	%esi, %eax
1000124b:      	popl	%esi
1000124c:      	movl	160(%esp), %ecx
10001253:      	xorl	%esp, %ecx
10001255:      	calll	0x10002162 <JNI_OnLoad+0xb62>
1000125a:      	addl	$164, %esp
10001260:      	retl
10001261:      	pushl	$140
10001266:      	leal	12(%esp), %eax
1000126a:      	pushl	$0
1000126c:      	pushl	%eax
1000126d:      	calll	0x100032e0 <JNI_OnLoad+0x1ce0>
10001272:      	movl	16(%esp), %eax
10001276:      	leal	20(%esp), %edx
1000127a:      	addl	$12, %esp
1000127d:      	movl	$268440352, 24(%esp)    # imm = 0x10001320
10001285:      	movl	(%eax), %ecx
10001287:      	pushl	$140
1000128c:      	pushl	%edx
1000128d:      	pushl	%eax
1000128e:      	movl	484(%ecx), %eax
10001294:      	calll	*%eax
10001296:      	movl	%eax, %esi
10001298:      	testl	%esi, %esi
1000129a:      	je	0x100012c2 <.text+0x2c2>
1000129c:      	pushl	%esi
1000129d:      	pushl	$268522004              # imm = 0x10015214
100012a2:      	calll	0x10001630 <JNI_OnLoad+0x30>
100012a7:      	addl	$8, %esp
100012aa:      	movl	%esi, %eax
100012ac:      	popl	%esi
100012ad:      	movl	160(%esp), %ecx
100012b4:      	xorl	%esp, %ecx
100012b6:      	calll	0x10002162 <JNI_OnLoad+0xb62>
100012bb:      	addl	$164, %esp
100012c1:      	retl
100012c2:      	pushl	$0
100012c4:      	pushl	$54
100012c6:      	pushl	$1
100012c8:      	pushl	16(%esp)
100012cc:      	calll	0x10001120 <.text+0x120>
100012d1:      	movl	%eax, %esi
100012d3:      	addl	$16, %esp
100012d6:      	testl	%esi, %esi
100012d8:      	je	0x10001300 <.text+0x300>
100012da:      	pushl	%esi
100012db:      	pushl	$268522044              # imm = 0x1001523C
100012e0:      	calll	0x10001630 <JNI_OnLoad+0x30>
100012e5:      	addl	$8, %esp
100012e8:      	movl	%esi, %eax
100012ea:      	popl	%esi
100012eb:      	movl	160(%esp), %ecx
100012f2:      	xorl	%esp, %ecx
100012f4:      	calll	0x10002162 <JNI_OnLoad+0xb62>
100012f9:      	addl	$164, %esp
100012ff:      	retl
10001300:      	movb	$1, 268727128
10001307:      	movl	164(%esp), %ecx
1000130e:      	xorl	%eax, %eax
10001310:      	popl	%esi
10001311:      	xorl	%esp, %ecx
10001313:      	calll	0x10002162 <JNI_OnLoad+0xb62>
10001318:      	addl	$164, %esp
1000131e:      	retl
1000131f:      	int3
