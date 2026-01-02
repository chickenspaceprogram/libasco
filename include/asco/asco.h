// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


// asco.h
//
// This library is a very thin wrapper around platform-specific assembly.
// It's not intended to be an actual, nice-to-use coroutine library.
// There is no runtime or anything like that, no channels or other such useful
// synchronization primitives. Implement those yourself.
//
// This library also entirely avoids allocation. You must provide memory
// yourself. This is a less-annoying alternative to custom allocators.
// Those are great for large libraries, but this is a little tiny thing you
// really should just statically link into your own library.
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
// signals like the plague, personally.

#pragma once
#include <stddef.h>
#include <stdint.h>
#include <assert.h>


// probably going to make a wrapper juuuuuust for win32, yay
#ifdef _WIN32
#	define ASCO_CALL __stdcall
#else
#	define ASCO_CALL
#endif


#if defined(_M_AMD64)
#	define ASCO_WIN_X86_64
#	error "Sorry, not supported yet."
#elif defined(__amd64__)
#	define ASCO_GNU_X86_64
#	error "Sorry, not supported yet."
#elif defined(_M_IX32)
#	define ASCO_WIN_X86
#	error "Sorry, not supported yet."
#elif defined(__i386__)
#	define ASCO_GNU_X86
#	error "Sorry, not supported yet."
#elif defined(__aarch64__) || defined(_M_ARM64)
#	define ASCO_AARCH64

typedef struct {
	uint64_t fp;
	uint64_t lr;
	uint64_t sp;
	uint64_t pc;

	// i'm using the x19 slot to serve a dual purpose
	// it's x19 when resuming a ctx, and x0 when starting a new ctx
	uint64_t x19_or_x0;

	uint64_t x20_x28[9];
	double d8_d15[8];
} asco_ctx;

#elif defined(__arm__) || defined(_M_ARM32)
#	define ASCO_ARM32
#	error "Sorry, not supported yet."
#else
#	error "Unsupported CPU architecture."
#endif


// The function whose pointer has this type looks as follows:
//
// void ASCO_CALL whatever_function_name(void *arg)
// {
// 	// ...
// }
typedef void (ASCO_CALL *asco_fn)(void *arg);

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
extern int asco_save(asco_ctx *cur_ctx);

// Sets the current ctx to `new_ctx`.
//
// This will effectively replace the current stack pointer with a new stack
// pointer.
//
// This function never returns.
extern void asco_load(const asco_ctx *new_ctx);

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


