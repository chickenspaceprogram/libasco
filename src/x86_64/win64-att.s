.text
.global asco_init_routine
.global asco_swap
asco_init_routine:
 mov %rbx, %rcx
 call *%r12
 mov (%r13), %rsp
 movdqu (%rsp), %xmm6
 movdqu 1*0x10(%rsp), %xmm7
 movdqu 2*0x10(%rsp), %xmm8
 movdqu 3*0x10(%rsp), %xmm9
 movdqu 4*0x10(%rsp), %xmm10
 movdqu 5*0x10(%rsp), %xmm11
 movdqu 6*0x10(%rsp), %xmm12
 movdqu 7*0x10(%rsp), %xmm13
 movdqu 8*0x10(%rsp), %xmm14
 movdqu 9*0x10(%rsp), %xmm15
 addq $10*0x10, %rsp
 movq %gs:0x30, %r10
 pop 0x1478(%r10)
 pop 0x20(%r10)
 pop 0x10(%r10)
 pop 0x08(%r10)
 pop %rsi
 pop %rdi
 pop %r15
 pop %r14
 pop %r13
 pop %r12
 pop %rbx
 fldcw 4(%rsp)
 ldmxcsr (%rsp)
 pop %rbp
 pop %rbp
 ret
asco_swap:
 push %rbp
 push %rbp
 stmxcsr (%rsp)
 fstcw 4(%rsp)
 push %rbx
 push %r12
 push %r13
 push %r14
 push %r15
 push %rdi
 push %rsi
 movq %gs:0x30, %r10
 push 0x08(%r10)
 push 0x10(%r10)
 push 0x20(%r10)
 push 0x1478(%r10)
 subq $10*0x10, %rsp
 movdqu %xmm6, (%rsp)
 movdqu %xmm7, 1*0x10(%rsp)
 movdqu %xmm8, 2*0x10(%rsp)
 movdqu %xmm9, 3*0x10(%rsp)
 movdqu %xmm10, 4*0x10(%rsp)
 movdqu %xmm11, 5*0x10(%rsp)
 movdqu %xmm12, 6*0x10(%rsp)
 movdqu %xmm13, 7*0x10(%rsp)
 movdqu %xmm14, 8*0x10(%rsp)
 movdqu %xmm15, 9*0x10(%rsp)
 movq %rsp, (%rcx)
 movq %rdx, %rsp
 movdqu (%rsp), %xmm6
 movdqu 1*0x10(%rsp), %xmm7
 movdqu 2*0x10(%rsp), %xmm8
 movdqu 3*0x10(%rsp), %xmm9
 movdqu 4*0x10(%rsp), %xmm10
 movdqu 5*0x10(%rsp), %xmm11
 movdqu 6*0x10(%rsp), %xmm12
 movdqu 7*0x10(%rsp), %xmm13
 movdqu 8*0x10(%rsp), %xmm14
 movdqu 9*0x10(%rsp), %xmm15
 addq $10*0x10, %rsp
 movq %gs:0x30, %r10
 pop 0x1478(%r10)
 pop 0x20(%r10)
 pop 0x10(%r10)
 pop 0x08(%r10)
 pop %rsi
 pop %rdi
 pop %r15
 pop %r14
 pop %r13
 pop %r12
 pop %rbx
 fldcw 4(%rsp)
 ldmxcsr (%rsp)
 pop %rbp
 pop %rbp
 ret
