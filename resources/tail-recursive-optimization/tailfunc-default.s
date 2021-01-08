	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	__Z7tailsumii           ## -- Begin function _Z7tailsumii
	.p2align	4, 0x90
__Z7tailsumii:                          ## @_Z7tailsumii
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$0, -8(%rbp)
	jne	LBB0_2
## %bb.1:
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	LBB0_3
LBB0_2:
	movl	-8(%rbp), %eax
	subl	$1, %eax
	movl	-12(%rbp), %ecx
	addl	-8(%rbp), %ecx
	movl	%eax, %edi
	movl	%ecx, %esi
	callq	__Z7tailsumii
	movl	%eax, -4(%rbp)
LBB0_3:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
