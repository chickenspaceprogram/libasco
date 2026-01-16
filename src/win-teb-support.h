#ifndef ASCO_WIN_TEB_SUPPORT
#define ASCO_WIN_TEB_SUPPORT 1

#include <Windows.h>
#include <WinNt.h>
#include <Winternl.h>
#include <asco/asco.h>
#include <string.h>

static void set_teb(asco_ctx *ctx)
{
	PTEB teb = NtCurrentTeb();
	teb->Reserved1[1] = (void *)ctx->tib_stack_base;
	teb->Reserved1[2] = (void *)ctx->tib_stack_limit;
	memcpy(teb->Reserved3 + 1944, &ctx->tib_dealloc_stack, 8);
	teb->Reserved5[24] = (void *)ctx->tib_guaranteed_bytes;
}

static void get_teb(asco_ctx *ctx)
{
	PTEB teb = NtCurrentTeb();
	ctx->tib_stack_base = (uint64_t)teb->Reserved1[1];
	ctx->tib_stack_limit = (uint64_t)teb->Reserved1[2];
	memcpy(&ctx->tib_dealloc_stack, teb->Reserved3 + 1944, 8);
	ctx->tib_guaranteed_bytes = (uint64_t)teb->Reserved5[24];
}


#endif
