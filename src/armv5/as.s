// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


.global asco_init_internal

.global asco_save

.global asco_load

// void asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *new_sp);
asco_init_internal:
	// new_ctx.a1 = arg
	str	a3, [a1], #32
	mov	a3, #0
	stmia	a1!, { a3, a4 }
	str	a2, [a1]
	bx	lr

// int asco_save(asco_ctx *cur_ctx);
asco_save:
	mov	a2, #1
	stmia	a1!, { a2, r4, r5, r6, r7, r8, r9, r10, fp, sp, lr }
	mov	a1, #0
	bx	lr

// void asco_load(const asco_ctx *new_ctx);
asco_load:
	ldmia	a1!, { a2, r4, r5, r6, r7, r8, r9, r10, fp, sp, lr }
	mov	a1, a2
	bx	lr

