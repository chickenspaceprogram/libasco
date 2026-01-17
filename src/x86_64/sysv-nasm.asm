default rel

global asco_init_routine
global asco_swap


SECTION .text

asco_init_routine:; Function begin
        mov     rdi, rbx                                ; 0000 _ 48: 89. DF
        call    r12                                     ; 0003 _ 41: FF. D4
        mov     rsp, qword [r13]                        ; 0006 _ 49: 8B. 65, 00
        pop     r15                                     ; 000A _ 41: 5F
        pop     r14                                     ; 000C _ 41: 5E
        pop     r13                                     ; 000E _ 41: 5D
        pop     r12                                     ; 0010 _ 41: 5C
        pop     rbx                                     ; 0012 _ 5B
        fldcw   word [rsp+4H]                           ; 0013 _ D9. 6C 24, 04
        ldmxcsr dword [rsp]                             ; 0017 _ 0F AE. 14 24
        pop     rbp                                     ; 001B _ 5D
        pop     rbp                                     ; 001C _ 5D
        ret                                             ; 001D _ C3
; asco_init_routine End of function

asco_swap:; Function begin
        push    rbp                                     ; 001E _ 55
        push    rbp                                     ; 001F _ 55
        stmxcsr dword [rsp]                             ; 0020 _ 0F AE. 1C 24
        fwait                                           ; 0024 _ 9B
        fnstcw  word [rsp+4H]                           ; 0025 _ D9. 7C 24, 04
        push    rbx                                     ; 0029 _ 53
        push    r12                                     ; 002A _ 41: 54
        push    r13                                     ; 002C _ 41: 55
        push    r14                                     ; 002E _ 41: 56
        push    r15                                     ; 0030 _ 41: 57
        mov     qword [rdi], rsp                        ; 0032 _ 48: 89. 27
        mov     rsp, rsi                                ; 0035 _ 48: 89. F4
        pop     r15                                     ; 0038 _ 41: 5F
        pop     r14                                     ; 003A _ 41: 5E
        pop     r13                                     ; 003C _ 41: 5D
        pop     r12                                     ; 003E _ 41: 5C
        pop     rbx                                     ; 0040 _ 5B
        fldcw   word [rsp+4H]                           ; 0041 _ D9. 6C 24, 04
        ldmxcsr dword [rsp]                             ; 0045 _ 0F AE. 14 24
        pop     rbp                                     ; 0049 _ 5D
        pop     rbp                                     ; 004A _ 5D
        ret                                             ; 004B _ C3
; asco_swap End of function
