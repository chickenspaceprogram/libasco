// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

#pragma once

// asco host thread state
typedef struct {
	char dummy;
} asco_thrd_ctx;

typedef struct {
	void *whatever;
} asco_ctx;

// Initializes a platform-specific `asco_thrd_ctx` with any necessary data.
// Realistically, this contains a void * that is gotten from ConvertThreadToFiber.

// Returns 0 on success, -1 on failure.

// It is invalid to do anything with this context on a host thread that is
// different from the thread which acquired it with `asco_thrd_ctx_init`.
int asco_thrd_ctx_init(asco_thrd_ctx *ctx);

// Destroys an asco_thrd_ctx
void asco_thrd_ctx_destroy(asco_thrd_ctx *ctx);

int asco_ctx_init();
void asco_ctx_destroy();

void asco_ctx_assign();
void asco_ctx_swap();


