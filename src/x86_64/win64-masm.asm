option dotname

public asco_init_routine
public asco_swap


.code

asco_init_routine PROC
        mov     rcx, rbx                                ; 0000 _ 48: 89. D9
        call    r12                                     ; 0003 _ 41: FF. D4
        mov     rsp, qword ptr [r13]                    ; 0006 _ 49: 8B. 65, 00
        movdqu  xmm6, xmmword ptr [rsp]                 ; 000A _ F3: 0F 6F. 34 24
        movdqu  xmm7, xmmword ptr [rsp+10H]             ; 000F _ F3: 0F 6F. 7C 24, 10
        movdqu  xmm8, xmmword ptr [rsp+20H]             ; 0015 _ F3 44: 0F 6F. 44 24, 20
        movdqu  xmm9, xmmword ptr [rsp+30H]             ; 001C _ F3 44: 0F 6F. 4C 24, 30
        movdqu  xmm10, xmmword ptr [rsp+40H]            ; 0023 _ F3 44: 0F 6F. 54 24, 40
        movdqu  xmm11, xmmword ptr [rsp+50H]            ; 002A _ F3 44: 0F 6F. 5C 24, 50
        movdqu  xmm12, xmmword ptr [rsp+60H]            ; 0031 _ F3 44: 0F 6F. 64 24, 60
        movdqu  xmm13, xmmword ptr [rsp+70H]            ; 0038 _ F3 44: 0F 6F. 6C 24, 70
        movdqu  xmm14, xmmword ptr [rsp+80H]            ; 003F _ F3 44: 0F 6F. B4 24, 00000080
        movdqu  xmm15, xmmword ptr [rsp+90H]            ; 0049 _ F3 44: 0F 6F. BC 24, 00000090
        add     rsp, 160                                ; 0053 _ 48: 81. C4, 000000A0
        pop     rsi                                     ; 005A _ 5E
        pop     rdi                                     ; 005B _ 5F
        pop     r15                                     ; 005C _ 41: 5F
        pop     r14                                     ; 005E _ 41: 5E
        pop     r13                                     ; 0060 _ 41: 5D
        pop     r12                                     ; 0062 _ 41: 5C
        pop     rbx                                     ; 0064 _ 5B
        fldcw   word ptr [rsp+4H]                       ; 0065 _ D9. 6C 24, 04
        ldmxcsr dword ptr [rsp]                         ; 0069 _ 0F AE. 14 24
        pop     rbp                                     ; 006D _ 5D
        pop     rbp                                     ; 006E _ 5D
        ret                                             ; 006F _ C3
asco_init_routine ENDP

asco_swap PROC
        push    rbp                                     ; 0070 _ 55
        push    rbp                                     ; 0071 _ 55
        stmxcsr dword ptr [rsp]                         ; 0072 _ 0F AE. 1C 24
        fwait                                           ; 0076 _ 9B
        fnstcw  word ptr [rsp+4H]                       ; 0077 _ D9. 7C 24, 04
        push    rbx                                     ; 007B _ 53
        push    r12                                     ; 007C _ 41: 54
        push    r13                                     ; 007E _ 41: 55
        push    r14                                     ; 0080 _ 41: 56
        push    r15                                     ; 0082 _ 41: 57
        push    rdi                                     ; 0084 _ 57
        push    rsi                                     ; 0085 _ 56
        sub     rsp, 160                                ; 0086 _ 48: 81. EC, 000000A0
        movdqu  xmmword ptr [rsp], xmm6                 ; 008D _ F3: 0F 7F. 34 24
        movdqu  xmmword ptr [rsp+10H], xmm7             ; 0092 _ F3: 0F 7F. 7C 24, 10
        movdqu  xmmword ptr [rsp+20H], xmm8             ; 0098 _ F3 44: 0F 7F. 44 24, 20
        movdqu  xmmword ptr [rsp+30H], xmm9             ; 009F _ F3 44: 0F 7F. 4C 24, 30
        movdqu  xmmword ptr [rsp+40H], xmm10            ; 00A6 _ F3 44: 0F 7F. 54 24, 40
        movdqu  xmmword ptr [rsp+50H], xmm11            ; 00AD _ F3 44: 0F 7F. 5C 24, 50
        movdqu  xmmword ptr [rsp+60H], xmm12            ; 00B4 _ F3 44: 0F 7F. 64 24, 60
        movdqu  xmmword ptr [rsp+70H], xmm13            ; 00BB _ F3 44: 0F 7F. 6C 24, 70
        movdqu  xmmword ptr [rsp+80H], xmm14            ; 00C2 _ F3 44: 0F 7F. B4 24, 00000080
        movdqu  xmmword ptr [rsp+90H], xmm15            ; 00CC _ F3 44: 0F 7F. BC 24, 00000090
        mov     qword ptr [rcx], rsp                    ; 00D6 _ 48: 89. 21
        mov     rsp, rdx                                ; 00D9 _ 48: 89. D4
        movdqu  xmm6, xmmword ptr [rsp]                 ; 00DC _ F3: 0F 6F. 34 24
        movdqu  xmm7, xmmword ptr [rsp+10H]             ; 00E1 _ F3: 0F 6F. 7C 24, 10
        movdqu  xmm8, xmmword ptr [rsp+20H]             ; 00E7 _ F3 44: 0F 6F. 44 24, 20
        movdqu  xmm9, xmmword ptr [rsp+30H]             ; 00EE _ F3 44: 0F 6F. 4C 24, 30
        movdqu  xmm10, xmmword ptr [rsp+40H]            ; 00F5 _ F3 44: 0F 6F. 54 24, 40
        movdqu  xmm11, xmmword ptr [rsp+50H]            ; 00FC _ F3 44: 0F 6F. 5C 24, 50
        movdqu  xmm12, xmmword ptr [rsp+60H]            ; 0103 _ F3 44: 0F 6F. 64 24, 60
        movdqu  xmm13, xmmword ptr [rsp+70H]            ; 010A _ F3 44: 0F 6F. 6C 24, 70
        movdqu  xmm14, xmmword ptr [rsp+80H]            ; 0111 _ F3 44: 0F 6F. B4 24, 00000080
        movdqu  xmm15, xmmword ptr [rsp+90H]            ; 011B _ F3 44: 0F 6F. BC 24, 00000090
        add     rsp, 160                                ; 0125 _ 48: 81. C4, 000000A0
        pop     rsi                                     ; 012C _ 5E
        pop     rdi                                     ; 012D _ 5F
        pop     r15                                     ; 012E _ 41: 5F
        pop     r14                                     ; 0130 _ 41: 5E
        pop     r13                                     ; 0132 _ 41: 5D
        pop     r12                                     ; 0134 _ 41: 5C
        pop     rbx                                     ; 0136 _ 5B
        fldcw   word ptr [rsp+4H]                       ; 0137 _ D9. 6C 24, 04
        ldmxcsr dword ptr [rsp]                         ; 013B _ 0F AE. 14 24
        pop     rbp                                     ; 013F _ 5D
        pop     rbp                                     ; 0140 _ 5D
        ret                                             ; 0141 _ C3
asco_swap ENDP

END
