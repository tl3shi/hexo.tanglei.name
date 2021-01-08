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
                                        ## kill: def %edi killed %edi def %rdi
	testl	%edi, %edi
	je	LBB0_2
## %bb.1:
	leal	-1(%rdi), %eax
	leal	-2(%rdi), %ecx
	imulq	%rax, %rcx
                                        ## kill: def %eax killed %eax killed %rax
	imull	%eax, %eax
	shrq	%rcx
	addl	%edi, %esi
	addl	%eax, %esi
	subl	%ecx, %esi
LBB0_2:
	movl	%esi, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
