	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	__Z3sumi                ## -- Begin function _Z3sumi
	.p2align	4, 0x90
__Z3sumi:                               ## @_Z3sumi
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
	.cfi_offset %rbx, -24
	movl	%edi, %ebx
	cmpl	$2, %ebx
	jge	LBB0_1
## %bb.2:
	movl	%ebx, %eax
	jmp	LBB0_3
LBB0_1:
	leal	-1(%rbx), %edi
	callq	__Z3sumi
	addl	%ebx, %eax
LBB0_3:
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
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
	je	LBB1_2
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
LBB1_2:
	movl	%esi, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	movq	__ZNSt3__14coutE@GOTPCREL(%rip), %rdi
	movl	$1784293664, %esi       ## imm = 0x6A5A2920
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	movq	%rax, %rbx
	movq	(%rbx), %rax
	movq	-24(%rax), %rsi
	addq	%rbx, %rsi
	leaq	-24(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZNKSt3__18ios_base6getlocEv
Ltmp0:
	movq	__ZNSt3__15ctypeIcE2idE@GOTPCREL(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp1:
## %bb.1:
	movq	(%rax), %rcx
Ltmp2:
	movl	$10, %esi
	movq	%rax, %rdi
	callq	*56(%rcx)
	movl	%eax, %r14d
Ltmp3:
## %bb.2:
	leaq	-24(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
	movsbl	%r14b, %esi
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	movq	%rbx, %rdi
	callq	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB2_3:
Ltmp4:
	movq	%rax, %rbx
Ltmp5:
	leaq	-24(%rbp), %rdi
	callq	__ZNSt3__16localeD1Ev
Ltmp6:
## %bb.4:
	movq	%rbx, %rdi
	callq	__Unwind_Resume
	ud2
LBB2_5:
Ltmp7:
	movq	%rax, %rdi
	callq	___clang_call_terminate
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table2:
Lexception0:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	155                     ## @TType Encoding = indirect pcrel sdata4
	.byte	73                      ## @TType base offset
	.byte	3                       ## Call site Encoding = udata4
	.byte	65                      ## Call site table length
Lset0 = Lfunc_begin0-Lfunc_begin0       ## >> Call Site 1 <<
	.long	Lset0
Lset1 = Ltmp0-Lfunc_begin0              ##   Call between Lfunc_begin0 and Ltmp0
	.long	Lset1
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset2 = Ltmp0-Lfunc_begin0              ## >> Call Site 2 <<
	.long	Lset2
Lset3 = Ltmp3-Ltmp0                     ##   Call between Ltmp0 and Ltmp3
	.long	Lset3
Lset4 = Ltmp4-Lfunc_begin0              ##     jumps to Ltmp4
	.long	Lset4
	.byte	0                       ##   On action: cleanup
Lset5 = Ltmp3-Lfunc_begin0              ## >> Call Site 3 <<
	.long	Lset5
Lset6 = Ltmp5-Ltmp3                     ##   Call between Ltmp3 and Ltmp5
	.long	Lset6
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lset7 = Ltmp5-Lfunc_begin0              ## >> Call Site 4 <<
	.long	Lset7
Lset8 = Ltmp6-Ltmp5                     ##   Call between Ltmp5 and Ltmp6
	.long	Lset8
Lset9 = Ltmp7-Lfunc_begin0              ##     jumps to Ltmp7
	.long	Lset9
	.byte	1                       ##   On action: 1
Lset10 = Ltmp6-Lfunc_begin0             ## >> Call Site 5 <<
	.long	Lset10
Lset11 = Lfunc_end0-Ltmp6               ##   Call between Ltmp6 and Lfunc_end0
	.long	Lset11
	.long	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.byte	1                       ## >> Action Record 1 <<
                                        ##   Catch TypeInfo 1
	.byte	0                       ##   No further actions
                                        ## >> Catch TypeInfos <<
	.long	0                       ## TypeInfo 1
	.p2align	2
                                        ## -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	___clang_call_terminate ## -- Begin function __clang_call_terminate
	.globl	___clang_call_terminate
	.weak_def_can_be_hidden	___clang_call_terminate
	.p2align	4, 0x90
___clang_call_terminate:                ## @__clang_call_terminate
## %bb.0:
	pushq	%rax
	callq	___cxa_begin_catch
	callq	__ZSt9terminatev
                                        ## -- End function

.subsections_via_symbols
