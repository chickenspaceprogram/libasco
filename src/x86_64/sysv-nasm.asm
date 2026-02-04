default rel

global asco_init_routine
global asco_swap


SECTION .text

asco_init_routine:; Function begin
        mov     rdi, rbx                                ; 0000 _ 48: 89. DF
        call    r12                                     ; 0003 _ 41: FF. D4
        mov     rsp, qword [r13]                        ; 0006 _ 49: 8B. 65, 00
        ldmxcsr dword [rsp]                             ; 000A _ 0F AE. 14 24
        fldcw   word [rsp+4H]                           ; 000E _ D9. 6C 24, 04
        mov     rbp, qword [rsp+8H]                     ; 0012 _ 48: 8B. 6C 24, 08
        mov     rbx, qword [rsp+10H]                    ; 0017 _ 48: 8B. 5C 24, 10
        mov     r12, qword [rsp+18H]                    ; 001C _ 4C: 8B. 64 24, 18
        mov     r13, qword [rsp+20H]                    ; 0021 _ 4C: 8B. 6C 24, 20
        mov     r14, qword [rsp+28H]                    ; 0026 _ 4C: 8B. 74 24, 28
        mov     r15, qword [rsp+30H]                    ; 002B _ 4C: 8B. 7C 24, 30
        lea     rsp, [rsp+38H]                          ; 0030 _ 48: 8D. 64 24, 38
        ret                                             ; 0035 _ C3
; asco_init_routine End of function

asco_swap:; Function begin
        lea     rsp, [rsp-38H]                          ; 0036 _ 48: 8D. 64 24, C8
        stmxcsr dword [rsp]                             ; 003B _ 0F AE. 1C 24
        fwait                                           ; 003F _ 9B
        fnstcw  word [rsp+4H]                           ; 0040 _ D9. 7C 24, 04
        mov     qword [rsp+8H], rbp                     ; 0044 _ 48: 89. 6C 24, 08
        mov     qword [rsp+10H], rbx                    ; 0049 _ 48: 89. 5C 24, 10
        mov     qword [rsp+18H], r12                    ; 004E _ 4C: 89. 64 24, 18
        mov     qword [rsp+20H], r13                    ; 0053 _ 4C: 89. 6C 24, 20
        mov     qword [rsp+28H], r14                    ; 0058 _ 4C: 89. 74 24, 28
        mov     qword [rsp+30H], r15                    ; 005D _ 4C: 89. 7C 24, 30
        mov     qword [rdi], rsp                        ; 0062 _ 48: 89. 27
        mov     rsp, rsi                                ; 0065 _ 48: 89. F4
        ldmxcsr dword [rsp]                             ; 0068 _ 0F AE. 14 24
        fldcw   word [rsp+4H]                           ; 006C _ D9. 6C 24, 04
        mov     rbp, qword [rsp+8H]                     ; 0070 _ 48: 8B. 6C 24, 08
        mov     rbx, qword [rsp+10H]                    ; 0075 _ 48: 8B. 5C 24, 10
        mov     r12, qword [rsp+18H]                    ; 007A _ 4C: 8B. 64 24, 18
        mov     r13, qword [rsp+20H]                    ; 007F _ 4C: 8B. 6C 24, 20
        mov     r14, qword [rsp+28H]                    ; 0084 _ 4C: 8B. 74 24, 28
        mov     r15, qword [rsp+30H]                    ; 0089 _ 4C: 8B. 7C 24, 30
        lea     rsp, [rsp+38H]                          ; 008E _ 48: 8D. 64 24, 38
        ret                                             ; 0093 _ C3
; asco_swap End of function
