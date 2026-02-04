/*	This Source Code Form is subject to the terms of the Mozilla Public
	License, v. 2.0. If a copy of the MPL was not distributed with this
	file, You can obtain one at https://mozilla.org/MPL/2.0/.

	SPDX-License-Identifier: MPL-2.0
*/

/* patching over the difference between sysV and win64 with cpp */
#ifdef SYSV_CALL

#	define arg1 rdi
#	define arg2 rsi
#	define SP_DEC_AMT	0x38

#elif defined(WIN_CALL)

#	define arg1 rcx
#	define arg2 rdx
#	define SP_DEC_AMT	0x108


#	define STACK_BASE 	0x08
#	define STACK_LIMIT 	0x10
#	define FIBER_DATA	0x20
#	define DEALLOC_STACK 	0x1478

#else
#error no calling convention defined
#endif


.text

.global asco_init_routine

.global asco_swap

asco_init_routine:

	mov	%rbx, %arg1
	call	*%r12

	mov	(%r13), %rsp

	ldmxcsr	(%rsp)
	fldcw	4(%rsp)
	movq	8(%rsp), %rbp
	movq	0x10(%rsp), %rbx
	movq	0x18(%rsp), %r12
	movq	0x20(%rsp), %r13
	movq	0x28(%rsp), %r14
	movq	0x30(%rsp), %r15

#ifdef WIN_CALL
	/* load %rdi. %rsi comes later */
	movq	0x38(%rsp), %rdi

	/* get TEB */
	movq	%gs:(0x30), %r10

	/* load stuff from TEB */
	movq	0x40(%rsp), %r11
	movq	%r11, STACK_BASE(%r10)
	movq	0x48(%rsp), %r11
	movq	%r11, STACK_LIMIT(%r10)
	movq	0x50(%rsp), %r11
	movq	%r11, FIBER_DATA(%r10)
	movq	0x58(%rsp), %r11
	movq	%r11, DEALLOC_STACK(%r10)
	
	/* load float regs */
	movdqu	0x60(%rsp), %xmm6
	movdqu	0x70(%rsp), %xmm7
	movdqu	0x80(%rsp), %xmm8
	movdqu	0x90(%rsp), %xmm9
	movdqu	0xa0(%rsp), %xmm10
	movdqu	0xb0(%rsp), %xmm11
	movdqu	0xc0(%rsp), %xmm12
	movdqu	0xd0(%rsp), %xmm13
	movdqu	0xe0(%rsp), %xmm14
	movdqu	0xf0(%rsp), %xmm15

	/* load %rsi */
	movq	0x100(%rsp), %rsi
#endif

	leaq	SP_DEC_AMT(%rsp), %rsp
	ret



/* void asco_swap(asco_ctx *cur_ctx, asco_ctx new_ctx) */

asco_swap:
	/* ret addr already pushed, thanks x86_64 */

	/* decrement %rsp */
	leaq	-SP_DEC_AMT(%rsp), %rsp

	/* save fp state */
	stmxcsr	(%rsp)
	fstcw	4(%rsp)

	/* save sysv regs */
	movq	%rbp, 0x08(%rsp)
	movq	%rbx, 0x10(%rsp)
	movq	%r12, 0x18(%rsp)
	movq	%r13, 0x20(%rsp)
	movq	%r14, 0x28(%rsp)
	movq	%r15, 0x30(%rsp)

#ifdef WIN_CALL
	/* save %rdi. %rsi comes later */
	movq	%rdi, 0x38(%rsp)

	/* get TEB */
	movq	%gs:(0x30), %r10

	/* save stuff from TEB */
	movq	STACK_BASE(%r10), %r11
	movq	%r11, 0x40(%rsp)
	movq	STACK_LIMIT(%r10), %r11
	movq	%r11, 0x48(%rsp)
	movq	FIBER_DATA(%r10), %r11
	movq	%r11, 0x50(%rsp)
	movq	DEALLOC_STACK(%r10), %r11
	movq	%r11, 0x58(%rsp)
	
	/* save float regs */
	movdqu	%xmm6, 0x60(%rsp)
	movdqu	%xmm7, 0x70(%rsp)
	movdqu	%xmm8, 0x80(%rsp)
	movdqu	%xmm9, 0x90(%rsp)
	movdqu	%xmm10, 0xa0(%rsp)
	movdqu	%xmm11, 0xb0(%rsp)
	movdqu	%xmm12, 0xc0(%rsp)
	movdqu	%xmm13, 0xd0(%rsp)
	movdqu	%xmm14, 0xe0(%rsp)
	movdqu	%xmm15, 0xf0(%rsp)

	/* save %rsi. might as well align FPU memory accesses
	...dont know if that is helpful but it cant hurt */
	movq	%rsi, 0x100(%rsp)

#endif

	movq	%rsp, (%arg1)
	movq	%arg2, %rsp

	ldmxcsr	(%rsp)
	fldcw	4(%rsp)
	movq	8(%rsp), %rbp
	movq	0x10(%rsp), %rbx
	movq	0x18(%rsp), %r12
	movq	0x20(%rsp), %r13
	movq	0x28(%rsp), %r14
	movq	0x30(%rsp), %r15

#ifdef WIN_CALL
	/* load %rdi. %rsi comes later */
	movq	0x38(%rsp), %rdi

	/* get TEB */
	movq	%gs:(0x30), %r10

	/* load stuff from TEB */
	movq	0x40(%rsp), %r11
	movq	%r11, STACK_BASE(%r10)
	movq	0x48(%rsp), %r11
	movq	%r11, STACK_LIMIT(%r10)
	movq	0x50(%rsp), %r11
	movq	%r11, FIBER_DATA(%r10)
	movq	0x58(%rsp), %r11
	movq	%r11, DEALLOC_STACK(%r10)
	
	/* load float regs */
	movdqu	0x60(%rsp), %xmm6
	movdqu	0x70(%rsp), %xmm7
	movdqu	0x80(%rsp), %xmm8
	movdqu	0x90(%rsp), %xmm9
	movdqu	0xa0(%rsp), %xmm10
	movdqu	0xb0(%rsp), %xmm11
	movdqu	0xc0(%rsp), %xmm12
	movdqu	0xd0(%rsp), %xmm13
	movdqu	0xe0(%rsp), %xmm14
	movdqu	0xf0(%rsp), %xmm15

	/* load %rsi */
	movq	0x100(%rsp), %rsi
#endif

	leaq	SP_DEC_AMT(%rsp), %rsp

	ret


