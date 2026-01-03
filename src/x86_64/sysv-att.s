// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

.section text

.global asco_init_internal
// void asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *sp);

.global asco_save
// int asco_save(asco_ctx *cur_ctx);

.global asco_load
// void asco_load(const asco_ctx *new_ctx);


asco_init_internal:
asco_save:
	// get pointer to cameback
	lea	Lasco_save_cameback(%rip), %rcx

	movq	%rcx, (%rdi)
	movq	%rbp, 8(%rdi)
	movq	%rsp, 16(%rdi)
	movq	%rbx, 24(%rdi)

	// saving fp state
	stmxcsr	32(%rdi)
	fnstcw	36(%rdi)

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

asco_load:


