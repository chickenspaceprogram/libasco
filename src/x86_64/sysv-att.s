// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

.text

.global asco_init_internal

.global asco_save

.global asco_load

// void asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *sp);
asco_init_internal:
	// storing instruction ptr, stack ptr, setting frame ptr to null
	movq	%rsi, (%rdi)
	movq	$0, 8(%rdi)
	movq	%rcx, 16(%rdi)

	// the fake "%rbx" stores the first arg of the fn, as always
	movq	%rdx, 24(%rdi)

	// setting default mxcsr state
	movl	$0b1111110000000, 32(%rdi)
	// setting default x87cw state
	movw	$0x037F, 36(%rdi)

	// no need to save r12-r15
	ret

// int asco_save(asco_ctx *cur_ctx);
asco_save:
	// get pointer to cameback
	lea	Lasco_save_cameback(%rip), %rcx

	movq	%rcx, (%rdi)
	movq	%rbp, 8(%rdi)
	movq	%rsp, 16(%rdi)
	movq	%rbx, 24(%rdi)

	// saving fp state
	stmxcsr	32(%rdi)
	fstcw	36(%rdi)

	// moving r12-r15
	movq	%r12, 40(%rdi)
	movq	%r13, 48(%rdi)
	movq	%r14, 56(%rdi)
	movq	%r15, 64(%rdi)

	xor	%eax, %eax
	ret

Lasco_save_cameback:
	movl	$1, %eax
	ret

// void asco_load(const asco_ctx *new_ctx);
asco_load:
	movq	8(%rdi), %rbp
	movq	16(%rdi), %rsp
	movq	24(%rdi), %rbx

	// loading fp state
	ldmxcsr	32(%rdi)
	fclex
	fldcw	36(%rdi)

	movq	40(%rdi), %r12
	movq	48(%rdi), %r13
	movq	56(%rdi), %r14
	movq	64(%rdi), %r15

	// saving struct pointer so we can jmp to it later
	movq	%rdi, %rsi

	// move whatever's in "%rbx" to fst argument of fn
	movq	%rbx, %rdi

	// jmp to stored-rip
	jmp	*(%rsi)

