.text
.global asco_exit_routine
asco_exit_routine:
 movq %r12, %rcx
 movl $0, %edx
 call RtlRestoreContext
