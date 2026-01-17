/*	This Source Code Form is subject to the terms of the Mozilla Public
	License, v. 2.0. If a copy of the MPL was not distributed with this
	file, You can obtain one at https://mozilla.org/MPL/2.0/.

	SPDX-License-Identifier: MPL-2.0
*/

/* patching over the difference between sysV and win64 with cpp */
#ifdef SYSV_CALL

#	define arg1 rdi
#	define arg2 rsi

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

	movq	%rsp, (%arg1)
	movq	%arg2, %rsp

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

