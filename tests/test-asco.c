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
#include <stdbool.h>

#define dbgassert(ARG) do {\
	if (!(ARG)) {\
		fprintf(stderr, "%s:%d: %s: Assertion `%s' failed.\n",\
			__FILE__, __LINE__, __func__, #ARG);\
		fflush(stderr);\
		abort();\
	}\
} while (0)

#define NFLAGS 5
static int FLAGLIST[NFLAGS] = {};
static int CUR_FLAG = 0;


static void chk_revert(void)
{
	asco_ctx ctx;
	volatile int niter = 6969;
	FLAGLIST[0] = CUR_FLAG++;
	bool rv = asco_save(&ctx);
	if (rv) {
		FLAGLIST[2] = CUR_FLAG++;
	}
	else {
		FLAGLIST[1] = CUR_FLAG++;
		fputs("chk_revert(): asco_save() called\n", stderr);
		asco_load(&ctx);
		dbgassert(0 && "chk_revert(): asco_load() called, SHOULD NOT BE HERE!!!\n");
		niter = 1;
	}
	dbgassert(niter == 6969);
}

static void jumpback(void *arg)
{
	volatile int foo = 3;
	dbgassert(foo == 3);
	asco_ctx *main_ctx = arg;
	FLAGLIST[3] = CUR_FLAG++;
	asco_load(main_ctx);
	dbgassert(0 && "jumpback(): asco_load() called, SHOULD NOT BE HERE");
}

static void chk_switch_stacks()
{
	int val = 123;
	asco_ctx main_ctx;
	asco_ctx new_ctx;
	void *stack = malloc(0x1000);
	dbgassert(stack != NULL);
	asco_init(&new_ctx, jumpback, &main_ctx, stack, 0x1000);
	fputs("chk_switch_stacks(): asco_init() called\n", stderr);
	asco_swap(&main_ctx, &new_ctx);
	FLAGLIST[4] = CUR_FLAG++;
	fputs("chk_switch_stacks(): asco_swap() called\n", stderr);
	dbgassert(val == 123);
	free(stack);
}

int main(void)
{
	fputs("Calling chk_revert()\n", stderr);
	chk_revert();
	fputs("Calling chk_switch_stacks()\n", stderr);
	chk_switch_stacks();
	for (int i = 0; i < NFLAGS; ++i) {
		dbgassert(i == FLAGLIST[i]);
	}
	return 0;
}
