default rel

global asco_init_routine

extern RtlRestoreContext                                ; near


SECTION .text

asco_init_routine:; Function begin
        mov     rsp, rbp                                ; 0000 _ 48: 89. EC
        mov     rcx, rbx                                ; 0003 _ 48: 89. D9
        call    r12                                     ; 0006 _ 41: FF. D4
        mov     rcx, qword [r13]                        ; 0009 _ 49: 8B. 4D, 00
        mov     edx, 0                                  ; 000D _ BA, 00000000
; Note: Function does not end with ret or jmp
        call    RtlRestoreContext                       ; 0012 _ E8, 00000000(PLT r)
; asco_init_routine End of function
