// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

// these tests suck. but i'm not gonna bother writing platform-specific
// assembly for tests of all things
//
// so, uhhh, if you find bugs, report them lmao


#include <asco/asco.h>
#include <stdio.h>
#include <stdlib.h>

#define dbgassert(ARG) do {\
	if (!(ARG)) {\
		fprintf(stderr, "%s:%d: %s: Assertion `%s' failed.\n",\
			__FILE__, __LINE__, __func__, #ARG);\
		fflush(stderr);\
		abort();\
	}\
} while (0)


static void chk_revert(void)
{
	asco_ctx ctx;
	int val = 123;
	int niter = 6969;
	if (val++ == 123 && asco_save(&ctx)) {
		asco_load(&ctx);
		niter = 1;
	}
	dbgassert(niter == 6969);
}

static void jumpback(void *arg)
{
	volatile int foo = 3;
	dbgassert(foo == 3);
	asco_ctx *main_ctx = arg;
	asco_load(main_ctx);
}

static void chk_switch_stacks(void)
{
	int val = 123;
	asco_ctx main_ctx;
	asco_ctx new_ctx;
	void *stack = malloc(0x1000);
	asco_init(&new_ctx, jumpback, &main_ctx, stack, 0x1000);
	asco_swap(&main_ctx, &new_ctx);
	dbgassert(val == 123);
	free(stack);
}

int main(void)
{
	chk_revert();
	chk_switch_stacks();
}
