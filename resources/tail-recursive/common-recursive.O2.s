	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.globl	__Z9sumCommoni
	.align	4, 0x90
__Z9sumCommoni:                         ## @_Z9sumCommoni
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp2:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
Ltmp3:
	.cfi_offset %rbx, -24
	movl	%edi, %ebx
	cmpl	$2, %ebx
	jge	LBB0_1
## BB#2:
	movl	%ebx, %eax
	jmp	LBB0_3
LBB0_1:
	leal	-1(%rbx), %edi
	callq	__Z9sumCommoni
	addl	%ebx, %eax
LBB0_3:
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
	.cfi_endproc


.subsections_via_symbols
