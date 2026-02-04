/*	This Source Code Form is subject to the terms of the Mozilla Public
	License, v. 2.0. If a copy of the MPL was not distributed with this
	file, You can obtain one at https://mozilla.org/MPL/2.0/.

	SPDX-License-Identifier: MPL-2.0
*/

/* patching over the difference between sysV and win64 with cpp */
#ifdef SYSV_CALL

#	define arg1 rdi
#	define arg2 rsi
#	define SP_DEC_AMT	8*

#elif defined(WIN_CALL)

#	define arg1 rcx
#	define arg2 rdx


#	define STACK_BASE 	%gs:0x08
#	define STACK_LIMIT 	%gs:0x10
#	define DEALLOC_STACK 	%gs:0x1478
#	define GUARANTEED_SB 	%gs:0x1748

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

#ifdef WIN_CALL
	movdqu	(%rsp), %xmm6
	movdqu	1*0x10(%rsp), %xmm7
	movdqu	2*0x10(%rsp), %xmm8
	movdqu	3*0x10(%rsp), %xmm9
	movdqu	4*0x10(%rsp), %xmm10
	movdqu	5*0x10(%rsp), %xmm11
	movdqu	6*0x10(%rsp), %xmm12
	movdqu	7*0x10(%rsp), %xmm13
	movdqu	8*0x10(%rsp), %xmm14
	movdqu	9*0x10(%rsp), %xmm15
	addq	$10*0x10, %rsp

	movq	%gs:0x30, %r10

	pop	0x1478(%r10)
	pop	0x10(%r10)
	pop	0x08(%r10)

	pop	%rsi
	pop	%rdi
#endif

	pop	%r15
	pop	%r14
	pop	%r13
	pop	%r12
	pop	%rbx
	fldcw	4(%rsp)
	ldmxcsr	(%rsp)
	pop	%rbp
	pop	%rbp

	ret

/* void asco_swap(asco_ctx *cur_ctx, asco_ctx new_ctx) */

asco_swap:
	/* ret addr already pushed, thanks x86_64 */
	push	%rbp
	push	%rbp /* extra space for mxcsr/x87cw */
	stmxcsr	(%rsp)
	fstcw	4(%rsp)
	push	%rbx
	push	%r12
	push	%r13
	push	%r14
	push	%r15

#ifdef WIN_CALL
	push	%rdi
	push	%rsi
	movq	%gs:0x30, %r10
	push	0x08(%r10) /* stack base */
	push	0x10(%r10) /* stack limit */
	push	0x20(%r10) /* fiber local storage */
	push	0x1478(%r10) /* dealloc stack */

	subq	$10*0x10, %rsp
	movdqu	%xmm6, (%rsp)
	movdqu	%xmm7, 1*0x10(%rsp)
	movdqu	%xmm8, 2*0x10(%rsp)
	movdqu	%xmm9, 3*0x10(%rsp)
	movdqu	%xmm10, 4*0x10(%rsp)
	movdqu	%xmm11, 5*0x10(%rsp)
	movdqu	%xmm12, 6*0x10(%rsp)
	movdqu	%xmm13, 7*0x10(%rsp)
	movdqu	%xmm14, 8*0x10(%rsp)
	movdqu	%xmm15, 9*0x10(%rsp)

#endif

	movq	%rsp, (%arg1)
	movq	%arg2, %rsp

#ifdef WIN_CALL

	movdqu	(%rsp), %xmm6
	movdqu	1*0x10(%rsp), %xmm7
	movdqu	2*0x10(%rsp), %xmm8
	movdqu	3*0x10(%rsp), %xmm9
	movdqu	4*0x10(%rsp), %xmm10
	movdqu	5*0x10(%rsp), %xmm11
	movdqu	6*0x10(%rsp), %xmm12
	movdqu	7*0x10(%rsp), %xmm13
	movdqu	8*0x10(%rsp), %xmm14
	movdqu	9*0x10(%rsp), %xmm15
	addq	$10*0x10, %rsp

	movq	%gs:0x30, %r10

	pop	0x1478(%r10)
	pop	0x20(%r10)
	pop	0x10(%r10)
	pop	0x08(%r10)

	pop	%rsi
	pop	%rdi
#endif

	pop	%r15
	pop	%r14
	pop	%r13
	pop	%r12
	pop	%rbx
	fldcw	4(%rsp)
	ldmxcsr	(%rsp)
	pop	%rbp
	pop	%rbp

	ret

