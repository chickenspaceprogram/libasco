// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


// asco.h
//
// This is a very thin wrapper around platform-specific assembly.
//
// It's primarily intended to implement stackful coroutines, not to
// serve as a better-setjmp.

#pragma once
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <assert.h>


// probably going to make a wrapper juuuuuust for win32, yay
#ifdef _WIN32
#	define ASCO_CALL __stdcall
#else
#	define ASCO_CALL
#endif


#if defined(_M_AMD64)
#	define ASCO_WIN_X86_64
#elif defined(__amd64__)
#	define ASCO_GNU_X86_64
#elif defined(_M_IX32)
#	define ASCO_WIN_X86
#elif defined(__i386__)
#	define ASCO_GNU_X86
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
#else
#	error "Unsupported CPU architecture."
#endif


typedef void (ASCO_CALL *asco_fn)(void *arg);

// Instantiates an `asco_ctx`.
//
// When loaded, the asco_ctx will execute `fn`, passing `arg` as its argument.
//
// Behavior is undefined if `fn` returns.
// Ensure that you `asco_swap` out before this happens.
//
// `arg` must be valid when `new_ctx` is passed to `asco_load`.
void asco_init(asco_ctx *new_ctx, asco_fn fn, void *arg, void *stack,
	size_t stack_sz);

// Saves the current ctx to `cur_ctx`.
//
// The ctx becomes invalid and behavior becomes undefined if the ctx is loaded
// after the current scope ends.
//
// Returns 1 if we've come from another coroutine, 0 if not.
extern int asco_save(asco_ctx *cur_ctx);

// Sets the current ctx to `new_ctx`.
extern void asco_load(const asco_ctx *new_ctx);

// Saves the current execution context, then jumps to the new context
//
// Coming back to the `cur_ctx` will make things continue on as expected
static inline void asco_swap(asco_ctx *cur_ctx, const asco_ctx *new_ctx)
{
	if (cur_ctx != NULL && asco_save(cur_ctx))
		return;
	asco_load(new_ctx);
}


