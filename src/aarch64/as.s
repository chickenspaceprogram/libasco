// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

.global asco_swap
.global asco_init_routine

asco_init_routine:
	// call coroutine fn
	mov	x0, x20
	blr	x19

	// load return ctx
	ldr	x9, [x21]
	mov	sp, x9

	ldp	d14, d15, [sp], #0x10
	ldp	d12, d13, [sp], #0x10
	ldp	d10, d11, [sp], #0x10
	ldp	d8, d9, [sp], #0x10
	ldp	x27, x28, [sp], #0x10
	ldp	x25, x26, [sp], #0x10
	ldp	x23, x24, [sp], #0x10
	ldp	x21, x22, [sp], #0x10
	ldp	x19, x20, [sp], #0x10
	ldp	fp, lr, [sp], #0x10

	ret

// void asco_swap(asco_ctx *cur_ctx, asco_ctx new_ctx);
asco_swap:
	// saving regs
	stp	fp, lr, [sp, #-0x10]!
	stp	x19, x20, [sp, #-0x10]!
	stp	x21, x22, [sp, #-0x10]!
	stp	x23, x24, [sp, #-0x10]!
	stp	x25, x26, [sp, #-0x10]!
	stp	x27, x28, [sp, #-0x10]!
	stp	d8, d9, [sp, #-0x10]!
	stp	d10, d11, [sp, #-0x10]!
	stp	d12, d13, [sp, #-0x10]!
	stp	d14, d15, [sp, #-0x10]!

	// swap stacks
	mov	x9, sp
	str	x9, [x0]
	mov	sp, x1

	ldp	d14, d15, [sp], #0x10
	ldp	d12, d13, [sp], #0x10
	ldp	d10, d11, [sp], #0x10
	ldp	d8, d9, [sp], #0x10
	ldp	x27, x28, [sp], #0x10
	ldp	x25, x26, [sp], #0x10
	ldp	x23, x24, [sp], #0x10
	ldp	x21, x22, [sp], #0x10
	ldp	x19, x20, [sp], #0x10
	ldp	fp, lr, [sp], #0x10

	ret
