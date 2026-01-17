// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

#include <asco/asco.h>
#include <string.h>

#ifdef __cplusplus
extern "C" {
#endif

// Sets up to call the coroutine function, calls it, then jumps to the return
// ctx once it finishes.
ASCO_LINKAGE extern void ASCO_CALL asco_init_routine(void)
	ASCO_ASM_NAME(asco_init_routine);

#if (ASCO_ARCH_AARCH64)

// aarch64 stack setup:
//
//
// before first fn call:
//
// lr: asco_init_routine
// fp: 0
// x20: void *init_arg;
// x19: void *init_fn
// x22: < unspecified > 
// x21: asco_ctx *return_ctx;
// other: unspecified
// 
// when coroutine is swapped away from:
//
// -- high --
// ... function calls ...
//
// void *link_reg;
// void *frame_ptr;
// uint64_t x19_x28[10];
// double d8_d15[8];
// -- low --
//
// otherwise: normal

#define SP_DEC_AMT (1 + 1 + 10 + 8)

ASCO_LINKAGE void ASCO_CALL asco_init(
	asco_ctx *new_ctx, const asco_ctx *ret_ctx,
	asco_fn fn, void *arg,
	void *stack_top, size_t stack_size)
{
	uintptr_t sp = (uintptr_t)stack_top + stack_size;
	sp &= ~(0xF);
	void **sp_as_ptr = (void **)sp;
	sp_as_ptr[-1] = asco_init_routine;
	sp_as_ptr[-2] = 0;
	sp_as_ptr[-3] = arg;
	sp_as_ptr[-4] = fn;
	sp_as_ptr[-6] = (void *)ret_ctx; // scary const cast
	sp_as_ptr -= SP_DEC_AMT;
	new_ctx->sp = (void *)sp_as_ptr;
}

#else
#	error libasco: unsupported architecture

#endif

#ifdef __cplusplus
}
#endif
