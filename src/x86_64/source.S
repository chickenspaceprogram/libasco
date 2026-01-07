/* This Source Code Form is subject to the terms of the Mozilla Public
   License, v. 2.0. If a copy of the MPL was not distributed with this
   file, You can obtain one at https://mozilla.org/MPL/2.0/.

   SPDX-License-Identifier: MPL-2.0

   "Source" asm file
   This gets compiled manually and then disassembled to spit out the various
   assembler-specific assemblies.

   Prodigious comments here, I am new to amd64 asm. */

/* patching over the difference between sysV and win64 with cpp */
#ifdef SYSV_CALL

#	define arg1 rdi
#	define arg2 rsi
#	define arg3 rdx
#	define arg4 rcx

#	define tmp1 r11
#	define tmp2 r9

#	define ret32 eax

#elif defined(WIN_CALL)

#	define arg1 rcx
#	define arg2 rdx
#	define arg3 r8
#	define arg4 r9

#	define tmp1 r11
#	define tmp2 r10

#	define ret32 eax

#else
#error no calling convention defined
#endif


.text

.global asco_init_internal

.global asco_save

.global asco_load

/* void 
asco_init_internal(asco_ctx *new_ctx, asco_fn fn, void *arg, void *sp); */
asco_init_internal:
	/* storing instruction ptr, stack ptr, setting frame ptr to null */
	movq	%arg2, (%arg1)
	movq	$0, 0x8(%arg1)
	movq	%arg4, 0x10(%arg1)

	/* setting default mxcsr state */
	movl	$0b1111110000000, 0x18(%arg1)
	/* setting default x87cw state */
	movw	$0x037F, 0x1c(%arg1)

	/* using first calling-convention-specific slot to store the first arg
	   of the fn */
	movq	%arg3, 0x20(%arg1)

	/* no need to save caller-saved regs, we have no caller */
	ret

/* int asco_save(asco_ctx *cur_ctx); */
asco_save:
	pop	%tmp1

	/* saving desired %rip */
	movq	%tmp1, (%arg1)

	/* need to save %rsp as it will be when this returns; asco_load just
	   blindly jmps */
	movq	%rsp, 0x10(%arg1)

	push	%tmp1


	/* saving other regs */
	movq	%rbp, 0x8(%arg1)

	/* saving fp state */
	stmxcsr	0x18(%arg1)
	fstcw	0x1c(%arg1)

	/* in both sysV and win64 */
	movq	%rbx, 0x20(%arg1)
	movq	%r12, 0x28(%arg1)
	movq	%r13, 0x30(%arg1)
	movq	%r14, 0x38(%arg1)
	movq	%r15, 0x40(%arg1)

#ifdef WIN_CALL
	/* only in win64 */
	movq	%rdi, 0x48(%arg1)
	movq	%rsi, 0x50(%arg1)

	movdqu	%xmm6, 0x58(%arg1)
	movdqu	%xmm7, 0x68(%arg1)
	movdqu	%xmm8, 0x78(%arg1)
	movdqu	%xmm9, 0x88(%arg1)
	movdqu	%xmm10, 0x98(%arg1)
	movdqu	%xmm11, 0xa8(%arg1)
	movdqu	%xmm12, 0xb8(%arg1)
	movdqu	%xmm13, 0xc8(%arg1)
	movdqu	%xmm14, 0xd8(%arg1)
	movdqu	%xmm15, 0xe8(%arg1)
#endif

	xor	%ret32, %ret32
	ret

Lasco_save_cameback:
	movl	$1, %ret32
	ret

/* void asco_load(const asco_ctx *new_ctx); */
asco_load:
	/* save intended %rip for later */
	movq	(%arg1), %tmp1

	movq	0x8(%arg1), %rbp
	movq	0x10(%arg1), %rsp

	/* loading fp state */
	ldmxcsr	0x18(%arg1)
	fclex
	fldcw	0x1c(%arg1)

	/* in both win64 and sysV */
	movq	0x20(%arg1), %rbx
	movq	0x28(%arg1), %r12
	movq	0x30(%arg1), %r13
	movq	0x38(%arg1), %r14
	movq	0x40(%arg1), %r15

#ifdef WIN_CALL
	/* only in win64 */
	movq	0x48(%arg1), %rdi
	movq	0x50(%arg1), %rsi

	movdqu	0x58(%arg1), %xmm6
	movdqu	0x68(%arg1), %xmm7
	movdqu	0x78(%arg1), %xmm8
	movdqu	0x88(%arg1), %xmm9
	movdqu	0x98(%arg1), %xmm10
	movdqu	0xa8(%arg1), %xmm11
	movdqu	0xb8(%arg1), %xmm12
	movdqu	0xc8(%arg1), %xmm13
	movdqu	0xd8(%arg1), %xmm14
	movdqu	0xe8(%arg1), %xmm15
#endif

	/* move whatever is in fake %rbx to fst argument of fn */
	movq	%rbx, %arg1

	/* returning 1 */
	movl	$1, %ret32

	/* jmp to stored-rip */
	jmp	*%tmp1

