; Disassembly of file: source.win.o
; Sun Jan  4 01:27:51 2026
; Type: COFF64
; Syntax: MASM/ML64
; Instruction set: SSE2, x64, 80x87
option dotname

public asco_init_internal
public asco_save
public asco_load


_text   SEGMENT PARA 'CODE'                             ; section number 1

asco_init_internal PROC
        mov     qword ptr [rcx], rdx                    ; 0000 _ 48: 89. 11
        mov     qword ptr [rcx+8H], 0                   ; 0003 _ 48: C7. 41, 08, 00000000
        mov     qword ptr [rcx+10H], r9                 ; 000B _ 4C: 89. 49, 10
        mov     dword ptr [rcx+18H], 8064               ; 000F _ C7. 41, 18, 00001F80
; Note: Length-changing prefix causes delay on old Intel processors
        mov     word ptr [rcx+1CH], 895                 ; 0016 _ 66: C7. 41, 1C, 037F
        mov     qword ptr [rcx+20H], r8                 ; 001C _ 4C: 89. 41, 20
        ret                                             ; 0020 _ C3
asco_init_internal ENDP

asco_save PROC
        lea     r11, [?_001]                            ; 0021 _ 4C: 8D. 1D, 00000081(rel)
        mov     qword ptr [rcx], r11                    ; 0028 _ 4C: 89. 19
        mov     qword ptr [rcx+8H], rbp                 ; 002B _ 48: 89. 69, 08
        mov     qword ptr [rcx+10H], rsp                ; 002F _ 48: 89. 61, 10
        stmxcsr dword ptr [rcx+18H]                     ; 0033 _ 0F AE. 59, 18
        fwait                                           ; 0037 _ 9B
        fnstcw  word ptr [rcx+1CH]                      ; 0038 _ D9. 79, 1C
        mov     qword ptr [rcx+20H], rbx                ; 003B _ 48: 89. 59, 20
        mov     qword ptr [rcx+28H], r12                ; 003F _ 4C: 89. 61, 28
        mov     qword ptr [rcx+30H], r13                ; 0043 _ 4C: 89. 69, 30
        mov     qword ptr [rcx+38H], r14                ; 0047 _ 4C: 89. 71, 38
        mov     qword ptr [rcx+40H], r15                ; 004B _ 4C: 89. 79, 40
        mov     qword ptr [rcx+48H], rdi                ; 004F _ 48: 89. 79, 48
        mov     qword ptr [rcx+50H], rsi                ; 0053 _ 48: 89. 71, 50
        movdqu  xmmword ptr [rcx+58H], xmm6             ; 0057 _ F3: 0F 7F. 71, 58
        movdqu  xmmword ptr [rcx+68H], xmm7             ; 005C _ F3: 0F 7F. 79, 68
        movdqu  xmmword ptr [rcx+78H], xmm8             ; 0061 _ F3 44: 0F 7F. 41, 78
        movdqu  xmmword ptr [rcx+88H], xmm9             ; 0067 _ F3 44: 0F 7F. 89, 00000088
        movdqu  xmmword ptr [rcx+98H], xmm10            ; 0070 _ F3 44: 0F 7F. 91, 00000098
        movdqu  xmmword ptr [rcx+0A8H], xmm11           ; 0079 _ F3 44: 0F 7F. 99, 000000A8
        movdqu  xmmword ptr [rcx+0B8H], xmm12           ; 0082 _ F3 44: 0F 7F. A1, 000000B8
        movdqu  xmmword ptr [rcx+0C8H], xmm13           ; 008B _ F3 44: 0F 7F. A9, 000000C8
        movdqu  xmmword ptr [rcx+0D8H], xmm14           ; 0094 _ F3 44: 0F 7F. B1, 000000D8
        movdqu  xmmword ptr [rcx+0E8H], xmm15           ; 009D _ F3 44: 0F 7F. B9, 000000E8
        xor     eax, eax                                ; 00A6 _ 31. C0
        ret                                             ; 00A8 _ C3
asco_save ENDP

?_001   LABEL NEAR
        mov     eax, 1                                  ; 00A9 _ B8, 00000001
        ret                                             ; 00AE _ C3

asco_load PROC
        mov     rbp, qword ptr [rcx+8H]                 ; 00AF _ 48: 8B. 69, 08
        mov     rsp, qword ptr [rcx+10H]                ; 00B3 _ 48: 8B. 61, 10
        ldmxcsr dword ptr [rcx+18H]                     ; 00B7 _ 0F AE. 51, 18
        fwait                                           ; 00BB _ 9B
        fnclex                                          ; 00BC _ DB. E2
        fldcw   word ptr [rcx+1CH]                      ; 00BE _ D9. 69, 1C
        mov     rbx, qword ptr [rcx+20H]                ; 00C1 _ 48: 8B. 59, 20
        mov     r12, qword ptr [rcx+28H]                ; 00C5 _ 4C: 8B. 61, 28
        mov     r13, qword ptr [rcx+30H]                ; 00C9 _ 4C: 8B. 69, 30
        mov     r14, qword ptr [rcx+38H]                ; 00CD _ 4C: 8B. 71, 38
        mov     r15, qword ptr [rcx+40H]                ; 00D1 _ 4C: 8B. 79, 40
        mov     rdi, qword ptr [rcx+48H]                ; 00D5 _ 48: 8B. 79, 48
        mov     rsi, qword ptr [rcx+50H]                ; 00D9 _ 48: 8B. 71, 50
        movdqu  xmm6, xmmword ptr [rcx+58H]             ; 00DD _ F3: 0F 6F. 71, 58
        movdqu  xmm7, xmmword ptr [rcx+68H]             ; 00E2 _ F3: 0F 6F. 79, 68
        movdqu  xmm8, xmmword ptr [rcx+78H]             ; 00E7 _ F3 44: 0F 6F. 41, 78
        movdqu  xmm9, xmmword ptr [rcx+88H]             ; 00ED _ F3 44: 0F 6F. 89, 00000088
        movdqu  xmm10, xmmword ptr [rcx+98H]            ; 00F6 _ F3 44: 0F 6F. 91, 00000098
        movdqu  xmm11, xmmword ptr [rcx+0A8H]           ; 00FF _ F3 44: 0F 6F. 99, 000000A8
        movdqu  xmm12, xmmword ptr [rcx+0B8H]           ; 0108 _ F3 44: 0F 6F. A1, 000000B8
        movdqu  xmm13, xmmword ptr [rcx+0C8H]           ; 0111 _ F3 44: 0F 6F. A9, 000000C8
        movdqu  xmm14, xmmword ptr [rcx+0D8H]           ; 011A _ F3 44: 0F 6F. B1, 000000D8
        movdqu  xmm15, xmmword ptr [rcx+0E8H]           ; 0123 _ F3 44: 0F 6F. B9, 000000E8
        mov     r11, rcx                                ; 012C _ 49: 89. CB
        mov     rcx, rbx                                ; 012F _ 48: 89. D9
        jmp     qword ptr [r11]                         ; 0132 _ 41: FF. 23
asco_load ENDP

        nop                                             ; 0135 _ 90
        nop                                             ; 0136 _ 90
        nop                                             ; 0137 _ 90
        nop                                             ; 0138 _ 90
        nop                                             ; 0139 _ 90
        nop                                             ; 013A _ 90
        nop                                             ; 013B _ 90
        nop                                             ; 013C _ 90
        nop                                             ; 013D _ 90
        nop                                             ; 013E _ 90
        nop                                             ; 013F _ 90

_text   ENDS

_data   SEGMENT PARA 'DATA'                             ; section number 2

_data   ENDS

.bss    SEGMENT PARA 'BSS'                              ; section number 3

.bss    ENDS

END