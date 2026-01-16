// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0


#include <asco/asco.h>

#ifdef __cplusplus
extern "C" {
#endif

// arch dependent
static inline void *set_stack_ptr(void *stack_start, size_t stack_sz);
extern void ASCO_CALL asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg,
       void *sp) ASCO_ASM_NAME(asco_init_internal);

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
	st -= 0x32; // giving a bunch of extra space, msvc is being weird
	st &= ~(0xF);
	return (void *)st;
}
#else
#	error "Unsupported CPU architecture."
#endif

extern int ASCO_CALL asco_save_internal(asco_ctx *cur_ctx)
	ASCO_ASM_NAME(asco_save);
extern void ASCO_CALL asco_load_internal(const asco_ctx *new_ctx) 
	ASCO_ASM_NAME(asco_load);

#if (ASCO_OS_WINDOWS)
#include "win-teb-support.h"

void asco_init(asco_ctx *new_ctx, asco_fn fn, void *arg, void *stack,
	size_t stack_sz)
{
	void *nsp = set_stack_ptr(stack, stack_sz);
	new_ctx->tib_stack_base = (uint64_t)nsp;
	new_ctx->tib_stack_limit = (uint64_t)arg;
	new_ctx->tib_dealloc_stack = (uint64_t)arg;
	new_ctx->tib_guaranteed_bytes = nsp - stack;
	set_teb(new_ctx);
	asco_init_internal(new_ctx, fn, arg, nsp);
}
int asco_save(asco_ctx *cur_ctx)
{
	get_teb(cur_ctx);
	return asco_save_internal(cur_ctx);
}
void asco_load(const asco_ctx *new_ctx)
{
	set_teb(ctx);
	return asco_load_internal(cur_ctx);
}

#else
void asco_init(asco_ctx *new_ctx, asco_fn fn, void *arg, void *stack,
	size_t stack_sz)
{
	asco_init_internal(new_ctx, fn, arg, set_stack_ptr(stack, stack_sz));
}
int asco_save(asco_ctx *cur_ctx)
{
	return asco_save_internal(cur_ctx);
}
void asco_load(const asco_ctx *new_ctx)
{
	return asco_load_internal(new_ctx);
}
#endif

#ifdef __cplusplus
}
#endif
