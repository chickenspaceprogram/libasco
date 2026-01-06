// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


// asco.h
//
// This library is a thin wrapper around platform-specific assembly.
// It's not intended to be an actual, nice-to-use coroutine library.
// There is no runtime or anything like that. You get the ability to create new
// call stacks and switch between them, more complex logic is left to the user.
//
// This library also entirely avoids allocation. You must provide memory
// yourself. This allows you to avoid linking against libc if you wish.
// There aren't convenient provisions for that in the buildsystem (the tests
// still need libc, for example) but there's nothing in theory stopping you
// from doing that.
//
// Also, this library is primarily intended to implement stackful coroutines,
// not to serve as a better setjmp/longjmp. It can serve that purpose, but,
// frankly, just use setjmp/longjmp. This is just setjmp/longjmp with the
// overhead of dealing with stack stuff, probably implemented less efficiently,
// and with the fun side effect of segfaulting when a coroutine exits.
//
// This library also doesn't play nice with POSIX signals. When `asco_load`-ing
// something the signal mask is unchanged. If you care about that, use
// ucontext, or save/restore the signal mask yourself. I'd just avoid POSIX
// signals like the plague, personally, but I'd do that anyways.

#pragma once
#include <stddef.h>
#include <stdint.h>

#include <asco/arch-detection.h>

#define ASCO_ASM_NAME(NAME)

#if (ASCO_ARCH_X86_64 && ASCO_OS_WINDOWS) // win64

// RDI, RSI, and XMM6-XMM15 
typedef struct {
	// preserved in any sane call conv
	uint64_t rip;
	uint64_t rbp;
	uint64_t rsp;
	uint32_t mxcsr;
	uint16_t x87cw;
	uint16_t padding;

	// in both sysV and win64
	uint64_t rbx;
	uint64_t r12_r15[4];

	// win32 specific
	uint64_t rdi;
	uint64_t rsi;
	uint64_t xmm6_15[2 * 10];
} asco_ctx;

#elif (ASCO_ARCH_X86_64) // sysV

// if this breaks, special-case it and define it to expand to nothing
#undef ASCO_ASM_NAME
#define ASCO_ASM_NAME(NAME) asm(#NAME)

typedef struct {
	// preserved in any sane call conv
	uint64_t rip;
	uint64_t rbp;
	uint64_t rsp;
	uint32_t mxcsr;
	uint16_t x87cw;
	uint16_t padding;

	// in both sysV and win64
	uint64_t rbx;
	uint64_t r12_r15[4];
} asco_ctx;


#elif ASCO_ARCH_AARCH64

#ifndef ASCO_OS_WINDOWS
// if this breaks, special-case it and define it to expand to nothing
#undef ASCO_ASM_NAME
#define ASCO_ASM_NAME(NAME) asm(#NAME)
#endif
typedef struct {
	uint64_t lr;
	uint64_t fp;
	uint64_t sp;

	// either return value or fst arg
	uint64_t x0;

	uint64_t x19_x28[10];
	double d8_d15[8];
} asco_ctx;

#elif ASCO_ARCH_ARMV5

typedef struct {
	// either retval or fst arg
	uint32_t a1;


	// callee-preserved regs
	uint32_t r4_r10[7];

	uint32_t fp;
	uint32_t sp;
	uint32_t lr;
// couldn't figure out how the HFP unit worked
#	warning Building for ARM 32-bit, assuming soft floating point ABI.\
		If you have a HFP unit, add the `-mfloat-abi=softfp` flag to\
		gcc.
} asco_ctx;

#else
#	error "Unsupported CPU architecture."
#endif


// The function whose pointer has this type looks as follows:
//
// void whatever_function_name(void *arg)
// {
// 	// ...
// }
typedef void (*asco_fn)(void *arg);

// Instantiates an `asco_ctx`.
//
// When loaded, the asco_ctx will call `fn`, passing `arg` as its argument.
//
// `stack` will be used as the new stack pointer, and the stack size will be
// assumed to be `stack_sz`.
//
// The stack can, of course, overflow; ensure you allocate more than enough
// space. Particularly for small stack sizes, recursion is an awful idea.
//
// Behavior is undefined if `fn` returns, so ensure that you `asco_load` a
// valid `asco_ctx` before this happens.
//
// `arg` must be valid when `new_ctx` is passed to `asco_load`.
void asco_init(asco_ctx *new_ctx, asco_fn fn, void *arg, void *stack,
	size_t stack_sz);

// Saves the current execution context to `cur_ctx`.
//
// If the current thread's stack is allocated by the system (as in, you're
// calling this from main() or from an OS-level thread), ensure you don't call
// asco_load on `cur_ctx` from another coroutine whose thread's stack is
// allocated by the system.
//
// Basically, keep thread-coroutines separate from truly-malloced-coroutines.
// You'll have to free the malloced ones anyways.
//
// The ctx becomes invalid and behavior becomes undefined if the ctx is loaded
// after the current scope ends.
//
// Returns 1 if we've come from another coroutine, 0 if not.
extern int asco_save(asco_ctx *cur_ctx) ASCO_ASM_NAME(asco_save);

// Sets the current ctx to `new_ctx`.
//
// This will effectively replace the current stack pointer with a new stack
// pointer.
//
// This function never returns.
extern void asco_load(const asco_ctx *new_ctx) ASCO_ASM_NAME(asco_load);

// Saves the current execution context, then jumps to the new context.
//
// `asco_load`-ing `cur_ctx` sometime in future will make things continue on
// from this function as expected.
static inline void asco_swap(asco_ctx *cur_ctx, const asco_ctx *new_ctx)
{
	if (cur_ctx != NULL && asco_save(cur_ctx))
		return;
	asco_load(new_ctx);
}


