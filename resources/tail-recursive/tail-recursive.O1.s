	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 12
	.globl	__Z16sumTailRecursiveii
	.align	4, 0x90
__Z16sumTailRecursiveii:                ## @_Z16sumTailRecursiveii
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
	cmpl	$2, %edi
	jl	LBB0_2
## BB#1:
	leal	-3(%rdi), %eax
	leal	-2(%rdi), %ecx
	addl	%edi, %esi
	decl	%edi
	imull	%ecx, %edi
	addl	%esi, %edi
	imulq	%rcx, %rax
	shrq	%rax
	subl	%eax, %edi
	movl	%edi, %esi
	movl	$1, %edi
LBB0_2:
	addl	%edi, %esi
	movl	%esi, %eax
	popq	%rbp
	retq
	.cfi_endproc


.subsections_via_symbols
