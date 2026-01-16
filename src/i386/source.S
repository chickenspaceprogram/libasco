/* This Source Code Form is subject to the terms of the Mozilla Public
   License, v. 2.0. If a copy of the MPL was not distributed with this
   file, You can obtain one at https://mozilla.org/MPL/2.0/.

   SPDX-License-Identifier: MPL-2.0

   "Source" asm file
   This gets compiled manually and then disassembled to spit out the various
   assembler-specific assemblies.

   Prodigious comments here, sorry. */

.section .note.GNU-stack,"",@progbits
.text

.global asco_init_internal

.global asco_save_internal

.global asco_load_internal

/* void 
asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *sp); */
asco_init_internal:
	/* load new_ctx -> eax */
	movl	4(%esp), %eax

	/* fn -> new_ctx.eip */
	movl	8(%esp), %edx
	movl	%edx, (%eax)

	/* 0 -> new_ctx.ebp */
	movl	$0, 4(%eax)

	/* loading sp to regs */
	movl	16(%esp), %edx

	/* putting return addr and fst arg on the new stack */
	sub	$8, %edx
	movl	$0, (%edx)
	movl	12(%esp), %ecx
	movl	%ecx, 4(%edx)

	/* saving sp */
	movl	%edx, 8(%eax)

	ret

/* int asco_save(asco_ctx *cur_ctx); */
asco_save_internal:
	/* getting cur_ctx */
	movl	4(%esp), %eax
	/* saving eip */
	popl	%edx

	movl	%edx, (%eax)


	movl	%ebp, 4(%eax)
	movl	%esp, 8(%eax)
	movl	%ebx, 12(%eax)
	movl	%edi, 16(%eax)
	movl	%esi, 20(%eax)

	movl	$0, %eax
	
	jmp	*%edx /* returning, we've already popped eip */

/* void asco_load(const asco_ctx *new_ctx); */
asco_load_internal:
	movl	4(%esp), %eax

	movl	(%eax), %edx

	movl	4(%eax), %ebp

	movl	8(%eax), %esp
	movl	12(%eax), %ebx
	movl	16(%eax), %edi
	movl	20(%eax), %esi

	/* jmping to eip */
	movl	$1, %eax
	jmp	*%edx
	

