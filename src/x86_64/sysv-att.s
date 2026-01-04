













.text

.global asco_init_internal

.global asco_save

.global asco_load


                                                                          
asco_init_internal:
	
	movq	%rsi, (%rdi)
	movq	$0, 0x8(%rdi)
	movq	%rcx, 0x10(%rdi)

	
	movl	$0b1111110000000, 0x18(%rdi)
	
	movw	$0x037F, 0x1c(%rdi)

	
                
	movq	%rdx, 0x20(%rdi)

	
	ret


asco_save:
	pop	%r11

	
	movq	%r11, (%rdi)

	
                   
	movq	%rsp, 0x10(%rdi)

	push	%r11


	
	movq	%rbp, 0x8(%rdi)

	
	stmxcsr	0x18(%rdi)
	fstcw	0x1c(%rdi)

	
	movq	%rbx, 0x20(%rdi)
	movq	%r12, 0x28(%rdi)
	movq	%r13, 0x30(%rdi)
	movq	%r14, 0x38(%rdi)
	movq	%r15, 0x40(%rdi)



	xor	%eax, %eax
	ret

Lasco_save_cameback:
	movl	$1, %eax
	ret


asco_load:
	movq	0x8(%rdi), %rbp
	movq	0x10(%rdi), %rsp

	
	ldmxcsr	0x18(%rdi)
	fclex
	fldcw	0x1c(%rdi)

	
	movq	0x20(%rdi), %rbx
	movq	0x28(%rdi), %r12
	movq	0x30(%rdi), %r13
	movq	0x38(%rdi), %r14
	movq	0x40(%rdi), %r15



	
	movq	%rbx, %rdi

	
	movl	$1, eax

	
	jmp	*(%rdi)


