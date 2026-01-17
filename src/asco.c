// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

#include <asco/asco.h>

#ifdef __cplusplus
extern "C" {
#endif

#if (ASCO_ARCH_X86_64 && ASCO_OS_WINDOWS)

extern void ASCO_CALL asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg,
	void *sp, void *begin_stack) ASCO_ASM_NAME(asco_init_internal);
#else
// actually implemented in asm
extern void ASCO_CALL asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg,
	void *sp) ASCO_ASM_NAME(asco_init_internal);
#endif

// arch dependent
static inline void *set_stack_ptr(void *stack_start, size_t stack_sz);

#if ASCO_ARCH_AARCH64 || ASCO_ARCH_X86
static inline void *set_stack_ptr(void *stack_start, size_t stack_sz)
{
	uintptr_t st = (uintptr_t)stack_start;
	st += stack_sz;
	st &= ~(0xF);
	return (void *)st;
}
#elif ASCO_ARCH_ARMV5
static inline void *set_stack_ptr(void *stack_start, size_t stack_sz)
{
	uintptr_t st = (uintptr_t)stack_start;
	st += stack_sz;
	st &= ~(0x7);
	return (void *)st;
}
#elif ASCO_ARCH_X86_64
static inline void *set_stack_ptr(void *stack_start, size_t stack_sz)
{
	uintptr_t st = (uintptr_t)stack_start;
	st += stack_sz;
	st -= 0x40; // giving a bunch of extra space, msvc is being weird
	st &= ~(0xF);
	return (void *)st;
}
#else
#	error "Unsupported CPU architecture."
#endif


#if (ASCO_ARCH_X86_64 && ASCO_OS_WINDOWS)
void asco_init(asco_ctx *new_ctx, asco_fn fn, void *arg, void *stack,
	size_t stack_sz)
{
	asco_init_internal(new_ctx, fn, arg, set_stack_ptr(stack, stack_sz), stack);
}
#else
void asco_init(asco_ctx *new_ctx, asco_fn fn, void *arg, void *stack,
	size_t stack_sz)
{
	asco_init_internal(new_ctx, fn, arg, set_stack_ptr(stack, stack_sz));
}
#endif

#ifdef __cplusplus
}
#endif
