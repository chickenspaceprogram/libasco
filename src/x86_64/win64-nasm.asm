default rel

global asco_init_routine
global asco_swap


SECTION .text

asco_init_routine:; Function begin
        mov     rcx, rbx                                ; 0000 _ 48: 89. D9
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
        push    rdi                                     ; 0032 _ 57
        push    rsi                                     ; 0033 _ 56
        sub     rsp, 160                                ; 0034 _ 48: 81. EC, 000000A0
        movdqu  oword [rsp], xmm6                       ; 003B _ F3: 0F 7F. 34 24
        movdqu  oword [rsp+10H], xmm7                   ; 0040 _ F3: 0F 7F. 7C 24, 10
        movdqu  oword [rsp+20H], xmm8                   ; 0046 _ F3 44: 0F 7F. 44 24, 20
        movdqu  oword [rsp+30H], xmm9                   ; 004D _ F3 44: 0F 7F. 4C 24, 30
        movdqu  oword [rsp+40H], xmm10                  ; 0054 _ F3 44: 0F 7F. 54 24, 40
        movdqu  oword [rsp+50H], xmm11                  ; 005B _ F3 44: 0F 7F. 5C 24, 50
        movdqu  oword [rsp+60H], xmm12                  ; 0062 _ F3 44: 0F 7F. 64 24, 60
        movdqu  oword [rsp+70H], xmm13                  ; 0069 _ F3 44: 0F 7F. 6C 24, 70
        movdqu  oword [rsp+80H], xmm14                  ; 0070 _ F3 44: 0F 7F. B4 24, 00000080
        movdqu  oword [rsp+90H], xmm15                  ; 007A _ F3 44: 0F 7F. BC 24, 00000090
        mov     qword [rcx], rsp                        ; 0084 _ 48: 89. 21
        mov     rsp, rdx                                ; 0087 _ 48: 89. D4
        movdqu  xmm6, oword [rsp]                       ; 008A _ F3: 0F 6F. 34 24
        movdqu  xmm7, oword [rsp+10H]                   ; 008F _ F3: 0F 6F. 7C 24, 10
        movdqu  xmm8, oword [rsp+20H]                   ; 0095 _ F3 44: 0F 6F. 44 24, 20
        movdqu  xmm9, oword [rsp+30H]                   ; 009C _ F3 44: 0F 6F. 4C 24, 30
        movdqu  xmm10, oword [rsp+40H]                  ; 00A3 _ F3 44: 0F 6F. 54 24, 40
        movdqu  xmm11, oword [rsp+50H]                  ; 00AA _ F3 44: 0F 6F. 5C 24, 50
        movdqu  xmm12, oword [rsp+60H]                  ; 00B1 _ F3 44: 0F 6F. 64 24, 60
        movdqu  xmm13, oword [rsp+70H]                  ; 00B8 _ F3 44: 0F 6F. 6C 24, 70
        movdqu  xmm14, oword [rsp+80H]                  ; 00BF _ F3 44: 0F 6F. B4 24, 00000080
        movdqu  xmm15, oword [rsp+90H]                  ; 00C9 _ F3 44: 0F 6F. BC 24, 00000090
        add     rsp, 160                                ; 00D3 _ 48: 81. C4, 000000A0
        pop     rsi                                     ; 00DA _ 5E
        pop     rdi                                     ; 00DB _ 5F
        pop     r15                                     ; 00DC _ 41: 5F
        pop     r14                                     ; 00DE _ 41: 5E
        pop     r13                                     ; 00E0 _ 41: 5D
        pop     r12                                     ; 00E2 _ 41: 5C
        pop     rbx                                     ; 00E4 _ 5B
        fldcw   word [rsp+4H]                           ; 00E5 _ D9. 6C 24, 04
        ldmxcsr dword [rsp]                             ; 00E9 _ 0F AE. 14 24
        pop     rbp                                     ; 00ED _ 5D
        pop     rbp                                     ; 00EE _ 5D
        ret                                             ; 00EF _ C3
; asco_swap End of function
