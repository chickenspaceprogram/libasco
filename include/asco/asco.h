// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


// asco.h
//
// This is a thin wrapper around some platform-specific assembly.
// There is no runtime or anything like that. You get the ability to create new
// call stacks and switch between them, more complex logic is left to the user.
//
// This library also doesn't play nice with POSIX signals. Swapping contexts
// does not alter the signal mask. If that is a problem for you, use the
// `ucontext` functions.
//
// In lieu of normal documentation generators, this file has been heavily
// commented.

#ifndef ASCO_ASCO_H
#define ASCO_ASCO_H 1

#include <stddef.h>
#include <stdint.h>

#include <asco/arch-detection.h>

#ifdef __cplusplus
#define ASCO_LINKAGE extern "C"
extern "C" {
#else
#define ASCO_LINKAGE
#endif


#if ASCO_OS_WINDOWS
#	define ASCO_ASM_NAME(NAME)
#else
#	define ASCO_ASM_NAME1(NAME) asm(#NAME)
#	define ASCO_ASM_NAME(NAME) ASCO_ASM_NAME1(NAME)
#endif


#if (ASCO_OS_WINDOWS && ASCO_ARCH_X86)
#	define ASCO_CALL __cdecl
#else
#	define ASCO_CALL
#endif


// Contains the execution context of a function.
//
// This is always going to be relatively small and can reasonably be passed
// by value. The registers, instruction pointer, etc. are all stored on the
// stack of the function that's been swapped away from.
typedef struct {
	void *sp;
} asco_ctx;

// The function whose pointer has this type looks as follows:
//
// ASCO_LINKAGE void ASCO_CALL whatever_function_name(void *arg)
// {
// 	// ...
// }
ASCO_LINKAGE typedef void (ASCO_CALL *asco_fn)(void *arg);

// Instantiates an `asco_ctx` executing a function.
//
// This function does not jump to the newly-created context right away.
// Rather, the newly-created context can now be `asco_swap`ped to at the user's
// discretion.
//
// When swapped to, `new_ctx` will call `fn` with argument `arg`, on the stack
// `stack` which has a total valid size of `stack_size`.
// When `fn` completes, control will be swapped to `ret_ctx`.
//
// `ret_ctx` can be modified later at the user's discretion (by jumping to it
// or saving context to it). It must not be invalidated when the newly-created
// context exits, however.
ASCO_LINKAGE void ASCO_CALL asco_init(
	asco_ctx *new_ctx, const asco_ctx *ret_ctx,
	asco_fn fn, void *arg,
	void *stack, size_t stack_size);

// Saves the current execution context to `cur_ctx`, then loads the context
// from `new_ctx` and continues execution from there.
//
// If `cur_ctx` is swapped to, this function will return and continue
// execution.
//
// If `new_ctx` is swapped to before it has been swapped away from, behavior is
// undefined.
ASCO_LINKAGE void ASCO_CALL asco_swap(
	asco_ctx *cur_ctx, asco_ctx new_ctx) ASCO_ASM_NAME(asco_swap);

#ifdef __cplusplus
}
#endif

#endif
