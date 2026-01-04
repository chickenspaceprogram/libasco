// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


// i haven't written much aarch64, so expect inane comments




	AREA	asco_internals, CODE, READONLY
	EXPORT	asco_init_internal
	EXPORT	asco_save
	EXPORT	asco_load


// void asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *sp);
asco_init_internal
	stp	x1, xzr, [x0], #16
	stp	x3, x2, [x0], #16

	// after setup:
	// ctx.lr = fn
	// ctx.fp = 0
	// ctx.sp = new_sp
	// ctx.x19_or_x0 = arg
	
	ret

// int asco_save(asco_ctx *cur_ctx);
asco_save
	// copying sp
	mov	x9, sp

	// storing fp, lr, sp, x19
	stp	lr, fp, [x0], #16
	stp	x9, x19, [x0], #16

	// storing x19-x28
	stp	x20, x21, [x0], #16
	stp	x22, x23, [x0], #16
	stp	x24, x25, [x0], #16
	stp	x26, x27, [x0], #16
	str	x28, [x0], #8

	// storing d8-d15
	stp	d8, d9, [x0], #16
	stp	d10, d11, [x0], #16
	stp	d12, d13, [x0], #16
	stp	d14, d15, [x0]

	// returning 0
	mov	w0, #0
	ret

// void asco_load(const asco_ctx *new_ctx);
asco_load
	// loading lr, sp, fp, pc
	ldp	lr, fp, [x0], #16
	ldp	x9, x19, [x0], #16
	
	// copying into sp
	mov	sp, x9

	// loading x19-x28
	ldp	x20, x21, [x0], #16
	ldp	x22, x23, [x0], #16
	ldp	x24, x25, [x0], #16
	ldp	x26, x27, [x0], #16
	ldr	x28, [x0], #8

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

	// basically br lr
	ret

	END
