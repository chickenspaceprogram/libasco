// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

.section text

.global asco_init_internal
// void asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *sp);

.global asco_save
// int asco_save(asco_ctx *cur_ctx);

.global asco_load
// void asco_load(const asco_ctx *new_ctx);


asco_init_internal:
asco_save:
asco_load:


