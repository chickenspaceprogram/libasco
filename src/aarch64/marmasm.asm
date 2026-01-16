// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


// i haven't written much aarch64, so expect inane comments




	AREA	asco_internals, CODE, READONLY
	EXPORT	asco_init_internal
	EXPORT	asco_save_internal
	EXPORT	asco_load_internal


// void asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *sp);
asco_init_internal
	stp	x1, xzr, [x0], #16
	stp	x3, x2, [x0]

	// after setup:
	// ctx.lr = fn
	// ctx.fp = 0
	// ctx.sp = new_sp
	// ctx.x19_or_x0 = arg
	
	ret

// int asco_save(asco_ctx *cur_ctx);
asco_save_internal
	// copying sp
	mov	x9, sp

	// return value on load
	mov	w10, #1

	// storing fp, lr, sp, x19
	stp	lr, fp, [x0], #16
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

// void asco_load(const asco_ctx *new_ctx);
asco_load_internal
	// loading lr, fp
	ldp	lr, fp, [x0]

	// loading x19-x28
	ldp	x19, x20, [x0, #0x20]
	ldp	x21, x22, [x0, #0x30]
	ldp	x23, x24, [x0, #0x40]
	ldp	x25, x26, [x0, #0x50]
	ldp	x27, x28, [x0, #0x60]

	// loading d8, d15
	ldp	d8, d9, [x0, #0x70]
	ldp	d10, d11, [x0, #0x80]
	ldp	d12, d13, [x0, #0x90]
	ldp	d14, d15, [x0, #0x100]

	ldp	x9, x0, [x0, #0x10]
	
	// copying into sp
	mov	sp, x9

	// basically br lr
	ret

	END
