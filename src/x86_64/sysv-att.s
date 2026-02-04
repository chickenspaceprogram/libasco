.text
.global asco_init_routine
.global asco_swap
asco_init_routine:
 mov %rbx, %rdi
 call *%r12
 mov (%r13), %rsp
 ldmxcsr (%rsp)
 fldcw 4(%rsp)
 movq 8(%rsp), %rbp
 movq 0x10(%rsp), %rbx
 movq 0x18(%rsp), %r12
 movq 0x20(%rsp), %r13
 movq 0x28(%rsp), %r14
 movq 0x30(%rsp), %r15
 leaq 0x38(%rsp), %rsp
 ret
asco_swap:
 leaq -0x38(%rsp), %rsp
 stmxcsr (%rsp)
 fstcw 4(%rsp)
 movq %rbp, 0x08(%rsp)
 movq %rbx, 0x10(%rsp)
 movq %r12, 0x18(%rsp)
 movq %r13, 0x20(%rsp)
 movq %r14, 0x28(%rsp)
 movq %r15, 0x30(%rsp)
 movq %rsp, (%rdi)
 movq %rsi, %rsp
 ldmxcsr (%rsp)
 fldcw 4(%rsp)
 movq 8(%rsp), %rbp
 movq 0x10(%rsp), %rbx
 movq 0x18(%rsp), %r12
 movq 0x20(%rsp), %r13
 movq 0x28(%rsp), %r14
 movq 0x30(%rsp), %r15
 leaq 0x38(%rsp), %rsp
 ret
