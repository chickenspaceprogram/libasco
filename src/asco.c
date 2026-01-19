// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

#include <asco/asco.h>

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

#elif (ASCO_ARCH_X86_64)

// mxcsr default value: 0b1111110000000 = 0x00001f80
// x87cw default value: 0x037f
//
// full 64-bit state-reg section init vals:
// 0x 0000 037f 00001f80
//
// as stored in mem:
//
// 0x 80 1f 00 00 7f 03 00 00
//
// yep looks right

#define STATE_REG_MAGIC ((uint64_t)0x0000037f00001f80u)


// sysv-x86_64 stack setup:
//
// before first fn call:
//
// ret_addr: asco_init_routine
// frame_ptr: 0
// mxcsr, x87cw, padding = STATE_REG_MAGIC
// rbx: init_arg
// r12: init_fn
// r13: return_ctx
// other: unspecified
// 
// when coroutine is swapped away from:
//
// -- high --
// ... function calls ...
//
// void *ret_addr;
// void *frame_ptr;
// uint32_t mxcsr;
// uint16_t x87cw;
// uint16_t padding;
// uint64_t rbx;
// uint64_t r12_r15[4];
// -- low --
//
// otherwise: normal
//
//
// extra stack members on win64 (after all the other members):
// uint64_t rdi
// uint64_t rsi
// uint64_t tib_stack_base
// uint64_t tib_stack_limit
// uint64_t tib_dealloc_stack
// uint64_t xmm6_15[10 * 2]

#if ASCO_OS_WINDOWS
#	define SP_DEC_AMT (1 + 1 + 1 + 1 + 4 + 5 + 10 * 2)
#	define TIB_STACK_BASE -11
#	define TIB_STACK_LIMIT -12
#	define TIB_DEALLOC_STACK -13
#else
#	define SP_DEC_AMT (1 + 1 + 1 + 1 + 4)
#endif

ASCO_LINKAGE void ASCO_CALL asco_init(
	asco_ctx *new_ctx, const asco_ctx *ret_ctx,
	asco_fn fn, void *arg,
	void *stack_top, size_t stack_size)
{
	uintptr_t sp = (uintptr_t)stack_top + stack_size - 0x40;
	sp &= ~(0xF);
	void **sp_as_ptr = (void **)sp;
	sp_as_ptr[-1] = asco_init_routine;
	sp_as_ptr[-2] = 0;
	sp_as_ptr[-3] = (void *)STATE_REG_MAGIC;
	sp_as_ptr[-4] = arg;
	sp_as_ptr[-5] = fn;
	sp_as_ptr[-6] = (void *)ret_ctx; // scary const cast
#if ASCO_OS_WINDOWS
	sp_as_ptr[TIB_STACK_BASE] = (void *)sp_as_ptr;
	sp_as_ptr[TIB_STACK_LIMIT] = stack_top;
	sp_as_ptr[TIB_DEALLOC_STACK] = stack_top;
#endif
	sp_as_ptr -= SP_DEC_AMT;
	new_ctx->sp = (void *)sp_as_ptr;
}

#else
#	error libasco: unsupported architecture

#endif

#ifdef __cplusplus
}
#endif
