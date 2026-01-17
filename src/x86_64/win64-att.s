.text
.global asco_init_routine
.global asco_swap
asco_init_routine:
 mov %rbx, %rcx
 call *%r12
 mov (%r13), %rsp
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
 movq %rsp, (%rcx)
 movq %rdx, %rsp
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
