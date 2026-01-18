option dotname

public asco_exit_routine

extern RtlRestoreContext: near


.code
asco_exit_routine PROC
        mov     rcx, r12                                ; 0000 _ 4C: 89. E1
        mov     edx, 0                                  ; 0003 _ BA, 00000000
; Note: Function does not end with ret or jmp
        call    RtlRestoreContext                       ; 0008 _ E8, 00000000(PLT r)
asco_exit_routine ENDP

END
