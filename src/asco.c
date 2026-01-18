// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

#include <asco/asco.h>

#ifdef __cplusplus
extern "C" {
#endif

#if (ASCO_OS_WINDOWS)
ASCO_LINKAGE extern void ASCO_CALL asco_exit_routine(void)
	ASCO_ASM_NAME(asco_exit_routine);
#else
// Sets up to call the coroutine function, calls it, then jumps to the return
// ctx once it finishes.
ASCO_LINKAGE extern void ASCO_CALL asco_init_routine(void)
	ASCO_ASM_NAME(asco_init_routine);
#endif

#if (ASCO_OS_WINDOWS)

#include <Windows.h>
#include <Winnt.h>
#include <assert.h> // might as well use them now that we need libc


#if (ASCO_ARCH_AARCH64)
typedef ARM64_NT_CONTEXT win_ctx;
typedef PARM64_NT_CONTEXT pwin_ctx;
#else
typedef CONTEXT win_ctx;
typedef PCONTEXT pwin_ctx;
#endif


#if (ASCO_ARCH_AARCH64)
#	define PC_ELEM Pc
#else
#	define PC_ELEM Rip
#endif
static inline void unwind_frame(pwin_ctx ctx)
{
	DWORD64 img_base = 0;
	UNWIND_HISTORY_TABLE unwind_hist = {0};

	PRUNTIME_FUNCTION fn = RtlLookupFunctionEntry(ctx->PC_ELEM, &img_base, &unwind_hist);
	assert(fn != NULL && "Couldn't find function in symbol table!");
	PVOID handler_data;
	DWORD64 estab_frame;
	RtlVirtualUnwind(0, img_base, ctx->PC_ELEM, fn, ctx, &handler_data,
		&estab_frame, NULL);
}

#if (ASCO_ARCH_AARCH64)
#error not implemented yet
#elif (ASCO_ARCH_X86_64)

ASCO_LINKAGE void ASCO_CALL asco_init(
	asco_ctx *new_ctx, const asco_ctx *ret_ctx,
	asco_fn fn, void *arg,
	void *stack_top, size_t stack_size)
{
	uintptr_t stack_base = (uintptr_t)stack_top + stack_size;
	stack_base -= sizeof(win_ctx);
	stack_base &= ~(0x7);
	pwin_ctx new_win_ctx = (pwin_ctx)stack_base;
	stack_base &= ~(0xF);
	// just be generous with stack sizes and this is not an issue
	assert((void *)stack_base < stack_top && "Stack size was too small");
	uintptr_t *sp = (uintptr_t *)stack_base;
	*(--sp) = (uintptr_t)asco_exit_routine;

	// Cygwin does this, and then just swaps out the stack and instruction
	// ptrs. So I think I'm good to do that? Maybe extensive testing could
	// determine whether this is necessary.
	//
	// "waaa it's inefficient" the two people running a windows server
	// can cry about it
	RtlCaptureContext(new_win_ctx);

	new_win_ctx->Rsp = (DWORD64)sp;
	new_win_ctx->Rcx = (DWORD64)arg;
	new_win_ctx->Rip = (DWORD64)fn;
	new_win_ctx->R12 = (DWORD64)ret_ctx;

}
#else
#	error architecture not supported
#endif

// separated out to ensure that even after we unwind `cur_ctx` it is still
// valid
static void asco_swap_internal(
	pwin_ctx cur_ctx, pwin_ctx new_ctx) ASCO_ASM_NAME(asco_swap)
{
	RtlCaptureContext(cur_ctx);
	unwind_frame(cur_ctx);
	RtlRestoreContext(new_ctx, NULL);
	assert(0 && "Shouldn't be here!");
}

ASCO_LINKAGE void ASCO_CALL asco_swap(
	asco_ctx *cur_ctx, asco_ctx new_ctx) ASCO_ASM_NAME(asco_swap)
{
	win_ctx ctx;
	cur_ctx->sp = (void *)&ctx;
	asco_swap_internal((pwin_ctx)cur_ctx->sp, (pwin_ctx)new_ctx.sp);
}

#elif (ASCO_ARCH_AARCH64)

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

#define SP_DEC_AMT (1 + 1 + 1 + 1 + 4)

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
	sp_as_ptr -= SP_DEC_AMT;
	new_ctx->sp = (void *)sp_as_ptr;
}

#else
#	error libasco: unsupported architecture

#endif

#ifdef __cplusplus
}
#endif
