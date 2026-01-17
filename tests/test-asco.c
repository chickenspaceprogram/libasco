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

#define eprintf(...) do {\
	fprintf(stderr, __VA_ARGS__);\
	fflush(stderr);\
} while (0)

#define NFLAGS 5
static int FLAGLIST[NFLAGS] = {};
static int CUR_FLAG = 0;

typedef struct {
	asco_ctx main_ctx;
	asco_ctx jb_ctx;
} contexts;


static void jumpback(void *arg)
{
	eprintf("in jumpback()\n");
	volatile int foo = 3;
	dbgassert(foo == 3);
	contexts *ctxs = arg;
	FLAGLIST[1] = CUR_FLAG++;
	asco_swap(&ctxs->jb_ctx, ctxs->main_ctx);
	FLAGLIST[3] = CUR_FLAG++;
	dbgassert(foo == 3);
	eprintf("came back to jumpback again\n");
}

static void chk_switch_stacks(void)
{
	int val = 123;
	contexts ctxs;
	void *stack = malloc(0x1000);
	dbgassert(stack != NULL);
	asco_init(&ctxs.jb_ctx, &ctxs.main_ctx,
		jumpback, &ctxs,
		stack, 0x1000);
	eprintf("chk_switch_stacks(): asco_init() called\n");
	FLAGLIST[0] = CUR_FLAG++;
	asco_swap(&ctxs.main_ctx, ctxs.jb_ctx);
	FLAGLIST[2] = CUR_FLAG++;
	eprintf("chk_switch_stacks: back from jumpback\n");
	dbgassert(val == 123);
	asco_swap(&ctxs.main_ctx, ctxs.jb_ctx);
	FLAGLIST[4] = CUR_FLAG++;
	dbgassert(val == 123);
	eprintf("chk_switch_stacks: jumpback finished\n");

	free(stack);
	eprintf("freed memory\n");
}

int main(void)
{
	eprintf("Calling chk_switch_stacks()\n");
	chk_switch_stacks();
	for (int i = 0; i < NFLAGS; ++i) {
		dbgassert(i == FLAGLIST[i]);
	}
	return 0;
}
