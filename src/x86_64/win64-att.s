.text
.global asco_init_routine
asco_init_routine:
 movq %rbp, %rsp
 movq %rbx, %rcx
 call *%r12
 movq (%r13), %rcx
 movl $0, %edx
 call RtlRestoreContext
