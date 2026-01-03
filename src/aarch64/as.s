// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


// i haven't written much aarch64, so expect inane comments


.global asco_init_internal
// void asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *sp);

.global asco_save
// int asco_save(asco_ctx *cur_ctx);

.global asco_load
// void asco_load(const asco_ctx *new_ctx);


asco_init_internal:
	// no previous frame, no previous link, so set those to 0
	stp	xzr, xzr, [x0], #16
	stp	x3, x1, [x0], #16

	// saving first argument to "x19 reg"
	str	x2, [x0]
	
	ret


asco_save:
	// copying sp and intended pc
	mov	x9, sp
	adr	x10, Lasco_save_cameback

	// storing fp, lr, sp, pc
	stp	fp, lr, [x0], #16
	stp	x9, x10, [x0], #16

	// storing x19-x28
	stp	x19, x20, [x0], #16
	stp	x21, x22, [x0], #16
	stp	x23, x24, [x0], #16
	stp	x25, x26, [x0], #16
	stp	x27, x28, [x0], #16

	// storing d8-d15
	stp	d8, d9, [x0], #16
	stp	d10, d11, [x0], #16
	stp	d12, d13, [x0], #16
	stp	d14, d15, [x0]

	// returning 0
	mov	w0, #0
	ret

Lasco_save_cameback:
	mov	w0, #1
	ret

asco_load:
	// loading lr, sp, fp, pc
	ldp	fp, lr, [x0], #16
	ldp	x9, x10, [x0], #16
	
	// copying into sp, can't jmp to pc yet
	mov	sp, x9

	// loading x19-x28
	ldp	x19, x20, [x0], #16
	ldp	x21, x22, [x0], #16
	ldp	x23, x24, [x0], #16
	ldp	x25, x26, [x0], #16
	ldp	x27, x28, [x0], #16

	// loading d8, d15
	ldp	d8, d9, [x0], #16
	ldp	d10, d11, [x0], #16
	ldp	d12, d13, [x0], #16
	ldp	d14, d15, [x0]

	// dirty trick
	// when starting a new ctx from a function, i've stored its `void *`
	// arg in the x19 slot. in that case x19 doesn't matter anyways.
	// when resuming a ctx, x0 is not preserved, so this doesnt cause
	// issues then either
	mov	x0, x19

	// branching to pc
	br	x10

