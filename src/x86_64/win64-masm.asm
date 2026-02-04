option dotname

public asco_init_routine
public asco_swap


.code

asco_init_routine PROC
        mov     rcx, rbx                                ; 0000 _ 48: 89. D9
        call    r12                                     ; 0003 _ 41: FF. D4
        mov     rsp, qword ptr [r13]                    ; 0006 _ 49: 8B. 65, 00
        ldmxcsr dword ptr [rsp]                         ; 000A _ 0F AE. 14 24
        fldcw   word ptr [rsp+4H]                       ; 000E _ D9. 6C 24, 04
        mov     rbp, qword ptr [rsp+8H]                 ; 0012 _ 48: 8B. 6C 24, 08
        mov     rbx, qword ptr [rsp+10H]                ; 0017 _ 48: 8B. 5C 24, 10
        mov     r12, qword ptr [rsp+18H]                ; 001C _ 4C: 8B. 64 24, 18
        mov     r13, qword ptr [rsp+20H]                ; 0021 _ 4C: 8B. 6C 24, 20
        mov     r14, qword ptr [rsp+28H]                ; 0026 _ 4C: 8B. 74 24, 28
        mov     r15, qword ptr [rsp+30H]                ; 002B _ 4C: 8B. 7C 24, 30
        mov     rdi, qword ptr [rsp+38H]                ; 0030 _ 48: 8B. 7C 24, 38
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword ptr gs:[30H]                 ; 0035 _ 65 4C: 8B. 14 25, 00000030
        mov     r11, qword ptr [rsp+40H]                ; 003E _ 4C: 8B. 5C 24, 40
        mov     qword ptr [r10+8H], r11                 ; 0043 _ 4D: 89. 5A, 08
        mov     r11, qword ptr [rsp+48H]                ; 0047 _ 4C: 8B. 5C 24, 48
        mov     qword ptr [r10+10H], r11                ; 004C _ 4D: 89. 5A, 10
        mov     r11, qword ptr [rsp+50H]                ; 0050 _ 4C: 8B. 5C 24, 50
        mov     qword ptr [r10+20H], r11                ; 0055 _ 4D: 89. 5A, 20
        mov     r11, qword ptr [rsp+58H]                ; 0059 _ 4C: 8B. 5C 24, 58
        mov     qword ptr [r10+1478H], r11              ; 005E _ 4D: 89. 9A, 00001478
        movdqu  xmm6, xmmword ptr [rsp+60H]             ; 0065 _ F3: 0F 6F. 74 24, 60
        movdqu  xmm7, xmmword ptr [rsp+70H]             ; 006B _ F3: 0F 6F. 7C 24, 70
        movdqu  xmm8, xmmword ptr [rsp+80H]             ; 0071 _ F3 44: 0F 6F. 84 24, 00000080
        movdqu  xmm9, xmmword ptr [rsp+90H]             ; 007B _ F3 44: 0F 6F. 8C 24, 00000090
        movdqu  xmm10, xmmword ptr [rsp+0A0H]           ; 0085 _ F3 44: 0F 6F. 94 24, 000000A0
        movdqu  xmm11, xmmword ptr [rsp+0B0H]           ; 008F _ F3 44: 0F 6F. 9C 24, 000000B0
        movdqu  xmm12, xmmword ptr [rsp+0C0H]           ; 0099 _ F3 44: 0F 6F. A4 24, 000000C0
        movdqu  xmm13, xmmword ptr [rsp+0D0H]           ; 00A3 _ F3 44: 0F 6F. AC 24, 000000D0
        movdqu  xmm14, xmmword ptr [rsp+0E0H]           ; 00AD _ F3 44: 0F 6F. B4 24, 000000E0
        movdqu  xmm15, xmmword ptr [rsp+0F0H]           ; 00B7 _ F3 44: 0F 6F. BC 24, 000000F0
        mov     rsi, qword ptr [rsp+100H]               ; 00C1 _ 48: 8B. B4 24, 00000100
        lea     rsp, [rsp+108H]                         ; 00C9 _ 48: 8D. A4 24, 00000108
        ret                                             ; 00D1 _ C3
asco_init_routine ENDP

asco_swap PROC
        lea     rsp, [rsp-108H]                         ; 00D2 _ 48: 8D. A4 24, FFFFFEF8
        stmxcsr dword ptr [rsp]                         ; 00DA _ 0F AE. 1C 24
        fwait                                           ; 00DE _ 9B
        fnstcw  word ptr [rsp+4H]                       ; 00DF _ D9. 7C 24, 04
        mov     qword ptr [rsp+8H], rbp                 ; 00E3 _ 48: 89. 6C 24, 08
        mov     qword ptr [rsp+10H], rbx                ; 00E8 _ 48: 89. 5C 24, 10
        mov     qword ptr [rsp+18H], r12                ; 00ED _ 4C: 89. 64 24, 18
        mov     qword ptr [rsp+20H], r13                ; 00F2 _ 4C: 89. 6C 24, 20
        mov     qword ptr [rsp+28H], r14                ; 00F7 _ 4C: 89. 74 24, 28
        mov     qword ptr [rsp+30H], r15                ; 00FC _ 4C: 89. 7C 24, 30
        mov     qword ptr [rsp+38H], rdi                ; 0101 _ 48: 89. 7C 24, 38
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword ptr gs:[30H]                 ; 0106 _ 65 4C: 8B. 14 25, 00000030
        mov     r11, qword ptr [r10+8H]                 ; 010F _ 4D: 8B. 5A, 08
        mov     qword ptr [rsp+40H], r11                ; 0113 _ 4C: 89. 5C 24, 40
        mov     r11, qword ptr [r10+10H]                ; 0118 _ 4D: 8B. 5A, 10
        mov     qword ptr [rsp+48H], r11                ; 011C _ 4C: 89. 5C 24, 48
        mov     r11, qword ptr [r10+20H]                ; 0121 _ 4D: 8B. 5A, 20
        mov     qword ptr [rsp+50H], r11                ; 0125 _ 4C: 89. 5C 24, 50
        mov     r11, qword ptr [r10+1478H]              ; 012A _ 4D: 8B. 9A, 00001478
        mov     qword ptr [rsp+58H], r11                ; 0131 _ 4C: 89. 5C 24, 58
        movdqu  xmmword ptr [rsp+60H], xmm6             ; 0136 _ F3: 0F 7F. 74 24, 60
        movdqu  xmmword ptr [rsp+70H], xmm7             ; 013C _ F3: 0F 7F. 7C 24, 70
        movdqu  xmmword ptr [rsp+80H], xmm8             ; 0142 _ F3 44: 0F 7F. 84 24, 00000080
        movdqu  xmmword ptr [rsp+90H], xmm9             ; 014C _ F3 44: 0F 7F. 8C 24, 00000090
        movdqu  xmmword ptr [rsp+0A0H], xmm10           ; 0156 _ F3 44: 0F 7F. 94 24, 000000A0
        movdqu  xmmword ptr [rsp+0B0H], xmm11           ; 0160 _ F3 44: 0F 7F. 9C 24, 000000B0
        movdqu  xmmword ptr [rsp+0C0H], xmm12           ; 016A _ F3 44: 0F 7F. A4 24, 000000C0
        movdqu  xmmword ptr [rsp+0D0H], xmm13           ; 0174 _ F3 44: 0F 7F. AC 24, 000000D0
        movdqu  xmmword ptr [rsp+0E0H], xmm14           ; 017E _ F3 44: 0F 7F. B4 24, 000000E0
        movdqu  xmmword ptr [rsp+0F0H], xmm15           ; 0188 _ F3 44: 0F 7F. BC 24, 000000F0
        mov     qword ptr [rsp+100H], rsi               ; 0192 _ 48: 89. B4 24, 00000100
        mov     qword ptr [rcx], rsp                    ; 019A _ 48: 89. 21
        mov     rsp, rdx                                ; 019D _ 48: 89. D4
        ldmxcsr dword ptr [rsp]                         ; 01A0 _ 0F AE. 14 24
        fldcw   word ptr [rsp+4H]                       ; 01A4 _ D9. 6C 24, 04
        mov     rbp, qword ptr [rsp+8H]                 ; 01A8 _ 48: 8B. 6C 24, 08
        mov     rbx, qword ptr [rsp+10H]                ; 01AD _ 48: 8B. 5C 24, 10
        mov     r12, qword ptr [rsp+18H]                ; 01B2 _ 4C: 8B. 64 24, 18
        mov     r13, qword ptr [rsp+20H]                ; 01B7 _ 4C: 8B. 6C 24, 20
        mov     r14, qword ptr [rsp+28H]                ; 01BC _ 4C: 8B. 74 24, 28
        mov     r15, qword ptr [rsp+30H]                ; 01C1 _ 4C: 8B. 7C 24, 30
        mov     rdi, qword ptr [rsp+38H]                ; 01C6 _ 48: 8B. 7C 24, 38
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword ptr gs:[30H]                 ; 01CB _ 65 4C: 8B. 14 25, 00000030
        mov     r11, qword ptr [rsp+40H]                ; 01D4 _ 4C: 8B. 5C 24, 40
        mov     qword ptr [r10+8H], r11                 ; 01D9 _ 4D: 89. 5A, 08
        mov     r11, qword ptr [rsp+48H]                ; 01DD _ 4C: 8B. 5C 24, 48
        mov     qword ptr [r10+10H], r11                ; 01E2 _ 4D: 89. 5A, 10
        mov     r11, qword ptr [rsp+50H]                ; 01E6 _ 4C: 8B. 5C 24, 50
        mov     qword ptr [r10+20H], r11                ; 01EB _ 4D: 89. 5A, 20
        mov     r11, qword ptr [rsp+58H]                ; 01EF _ 4C: 8B. 5C 24, 58
        mov     qword ptr [r10+1478H], r11              ; 01F4 _ 4D: 89. 9A, 00001478
        movdqu  xmm6, xmmword ptr [rsp+60H]             ; 01FB _ F3: 0F 6F. 74 24, 60
        movdqu  xmm7, xmmword ptr [rsp+70H]             ; 0201 _ F3: 0F 6F. 7C 24, 70
        movdqu  xmm8, xmmword ptr [rsp+80H]             ; 0207 _ F3 44: 0F 6F. 84 24, 00000080
        movdqu  xmm9, xmmword ptr [rsp+90H]             ; 0211 _ F3 44: 0F 6F. 8C 24, 00000090
        movdqu  xmm10, xmmword ptr [rsp+0A0H]           ; 021B _ F3 44: 0F 6F. 94 24, 000000A0
        movdqu  xmm11, xmmword ptr [rsp+0B0H]           ; 0225 _ F3 44: 0F 6F. 9C 24, 000000B0
        movdqu  xmm12, xmmword ptr [rsp+0C0H]           ; 022F _ F3 44: 0F 6F. A4 24, 000000C0
        movdqu  xmm13, xmmword ptr [rsp+0D0H]           ; 0239 _ F3 44: 0F 6F. AC 24, 000000D0
        movdqu  xmm14, xmmword ptr [rsp+0E0H]           ; 0243 _ F3 44: 0F 6F. B4 24, 000000E0
        movdqu  xmm15, xmmword ptr [rsp+0F0H]           ; 024D _ F3 44: 0F 6F. BC 24, 000000F0
        mov     rsi, qword ptr [rsp+100H]               ; 0257 _ 48: 8B. B4 24, 00000100
        lea     rsp, [rsp+108H]                         ; 025F _ 48: 8D. A4 24, 00000108
        ret                                             ; 0267 _ C3
asco_swap ENDP

END
