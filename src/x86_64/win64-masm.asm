; Disassembly of file: source.win.o
; Wed Jan 14 01:26:38 2026
; Type: ELF64
; Syntax: MASM/ML64
; Instruction set: SSE2, x64, 80x87
option dotname

public asco_init_internal
public asco_save
public asco_load


.code

asco_init_internal PROC
        mov     qword ptr [rcx], rdx                    ; 0000 _ 48: 89. 11
        mov     qword ptr [rcx+8H], 0                   ; 0003 _ 48: C7. 41, 08, 00000000
        mov     qword ptr [rcx+10H], r9                 ; 000B _ 4C: 89. 49, 10
        mov     dword ptr [rcx+18H], 8064               ; 000F _ C7. 41, 18, 00001F80
; Note: Length-changing prefix causes delay on old Intel processors
        mov     word ptr [rcx+1CH], 895                 ; 0016 _ 66: C7. 41, 1C, 037F
        mov     qword ptr [rcx+20H], r8                 ; 001C _ 4C: 89. 41, 20
        mov     r11, qword ptr [rsp+8H]                 ; 0020 _ 4C: 8B. 5C 24, 08
        mov     r10, 0                                  ; 0025 _ 49: C7. C2, 00000000
        mov     qword ptr [rcx+0F8H], r9                ; 002C _ 4C: 89. 89, 000000F8
        mov     qword ptr [rcx+100H], r11               ; 0033 _ 4C: 89. 99, 00000100
        mov     qword ptr [rcx+108H], r9                ; 003A _ 4C: 89. 89, 00000108
        sub     r9, r11                                 ; 0041 _ 4D: 29. D9
        mov     qword ptr [rcx+110H], r9                ; 0044 _ 4C: 89. 89, 00000110
        ret                                             ; 004B _ C3
asco_init_internal ENDP

asco_save PROC
        pop     r11                                     ; 004C _ 41: 5B
        mov     qword ptr [rcx], r11                    ; 004E _ 4C: 89. 19
        mov     qword ptr [rcx+10H], rsp                ; 0051 _ 48: 89. 61, 10
        push    r11                                     ; 0055 _ 41: 53
        mov     qword ptr [rcx+8H], rbp                 ; 0057 _ 48: 89. 69, 08
        stmxcsr dword ptr [rcx+18H]                     ; 005B _ 0F AE. 59, 18
        fwait                                           ; 005F _ 9B
        fnstcw  word ptr [rcx+1CH]                      ; 0060 _ D9. 79, 1C
        mov     qword ptr [rcx+20H], rbx                ; 0063 _ 48: 89. 59, 20
        mov     qword ptr [rcx+28H], r12                ; 0067 _ 4C: 89. 61, 28
        mov     qword ptr [rcx+30H], r13                ; 006B _ 4C: 89. 69, 30
        mov     qword ptr [rcx+38H], r14                ; 006F _ 4C: 89. 71, 38
        mov     qword ptr [rcx+40H], r15                ; 0073 _ 4C: 89. 79, 40
        mov     qword ptr [rcx+48H], rdi                ; 0077 _ 48: 89. 79, 48
        mov     qword ptr [rcx+50H], rsi                ; 007B _ 48: 89. 71, 50
        movdqu  xmmword ptr [rcx+58H], xmm6             ; 007F _ F3: 0F 7F. 71, 58
        movdqu  xmmword ptr [rcx+68H], xmm7             ; 0084 _ F3: 0F 7F. 79, 68
        movdqu  xmmword ptr [rcx+78H], xmm8             ; 0089 _ F3 44: 0F 7F. 41, 78
        movdqu  xmmword ptr [rcx+88H], xmm9             ; 008F _ F3 44: 0F 7F. 89, 00000088
        movdqu  xmmword ptr [rcx+98H], xmm10            ; 0098 _ F3 44: 0F 7F. 91, 00000098
        movdqu  xmmword ptr [rcx+0A8H], xmm11           ; 00A1 _ F3 44: 0F 7F. 99, 000000A8
        movdqu  xmmword ptr [rcx+0B8H], xmm12           ; 00AA _ F3 44: 0F 7F. A1, 000000B8
        movdqu  xmmword ptr [rcx+0C8H], xmm13           ; 00B3 _ F3 44: 0F 7F. A9, 000000C8
        movdqu  xmmword ptr [rcx+0D8H], xmm14           ; 00BC _ F3 44: 0F 7F. B1, 000000D8
        movdqu  xmmword ptr [rcx+0E8H], xmm15           ; 00C5 _ F3 44: 0F 7F. B9, 000000E8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword ptr gs:[8H]                  ; 00CE _ 65 4C: 8B. 1C 25, 00000008
        mov     qword ptr [rcx+0F8H], r11               ; 00D7 _ 4C: 89. 99, 000000F8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword ptr gs:[10H]                 ; 00DE _ 65 4C: 8B. 1C 25, 00000010
        mov     qword ptr [rcx+100H], r11               ; 00E7 _ 4C: 89. 99, 00000100
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword ptr gs:[1478H]               ; 00EE _ 65 4C: 8B. 1C 25, 00001478
        mov     qword ptr [rcx+108H], r11               ; 00F7 _ 4C: 89. 99, 00000108
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword ptr gs:[1748H]               ; 00FE _ 65 4C: 8B. 1C 25, 00001748
        mov     qword ptr [rcx+110H], r11               ; 0107 _ 4C: 89. 99, 00000110
        xor     eax, eax                                ; 010E _ 31. C0
        ret                                             ; 0110 _ C3
asco_save ENDP

asco_load PROC
        mov     r11, qword ptr [rcx]                    ; 0111 _ 4C: 8B. 19
        mov     rbp, qword ptr [rcx+8H]                 ; 0114 _ 48: 8B. 69, 08
        mov     rsp, qword ptr [rcx+10H]                ; 0118 _ 48: 8B. 61, 10
        ldmxcsr dword ptr [rcx+18H]                     ; 011C _ 0F AE. 51, 18
        fwait                                           ; 0120 _ 9B
        fnclex                                          ; 0121 _ DB. E2
        fldcw   word ptr [rcx+1CH]                      ; 0123 _ D9. 69, 1C
        mov     rbx, qword ptr [rcx+20H]                ; 0126 _ 48: 8B. 59, 20
        mov     r12, qword ptr [rcx+28H]                ; 012A _ 4C: 8B. 61, 28
        mov     r13, qword ptr [rcx+30H]                ; 012E _ 4C: 8B. 69, 30
        mov     r14, qword ptr [rcx+38H]                ; 0132 _ 4C: 8B. 71, 38
        mov     r15, qword ptr [rcx+40H]                ; 0136 _ 4C: 8B. 79, 40
        mov     rdi, qword ptr [rcx+48H]                ; 013A _ 48: 8B. 79, 48
        mov     rsi, qword ptr [rcx+50H]                ; 013E _ 48: 8B. 71, 50
        movdqu  xmm6, xmmword ptr [rcx+58H]             ; 0142 _ F3: 0F 6F. 71, 58
        movdqu  xmm7, xmmword ptr [rcx+68H]             ; 0147 _ F3: 0F 6F. 79, 68
        movdqu  xmm8, xmmword ptr [rcx+78H]             ; 014C _ F3 44: 0F 6F. 41, 78
        movdqu  xmm9, xmmword ptr [rcx+88H]             ; 0152 _ F3 44: 0F 6F. 89, 00000088
        movdqu  xmm10, xmmword ptr [rcx+98H]            ; 015B _ F3 44: 0F 6F. 91, 00000098
        movdqu  xmm11, xmmword ptr [rcx+0A8H]           ; 0164 _ F3 44: 0F 6F. 99, 000000A8
        movdqu  xmm12, xmmword ptr [rcx+0B8H]           ; 016D _ F3 44: 0F 6F. A1, 000000B8
        movdqu  xmm13, xmmword ptr [rcx+0C8H]           ; 0176 _ F3 44: 0F 6F. A9, 000000C8
        movdqu  xmm14, xmmword ptr [rcx+0D8H]           ; 017F _ F3 44: 0F 6F. B1, 000000D8
        movdqu  xmm15, xmmword ptr [rcx+0E8H]           ; 0188 _ F3 44: 0F 6F. B9, 000000E8
        mov     r10, qword ptr [rcx+0F8H]               ; 0191 _ 4C: 8B. 91, 000000F8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword ptr gs:[8H], r10                  ; 0198 _ 65 4C: 89. 14 25, 00000008
        mov     r10, qword ptr [rcx+100H]               ; 01A1 _ 4C: 8B. 91, 00000100
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword ptr gs:[10H], r10                 ; 01A8 _ 65 4C: 89. 14 25, 00000010
        mov     r10, qword ptr [rcx+108H]               ; 01B1 _ 4C: 8B. 91, 00000108
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword ptr gs:[1478H], r10               ; 01B8 _ 65 4C: 89. 14 25, 00001478
        mov     r10, qword ptr [rcx+110H]               ; 01C1 _ 4C: 8B. 91, 00000110
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword ptr gs:[1748H], r10               ; 01C8 _ 65 4C: 89. 14 25, 00001748
        mov     rcx, rbx                                ; 01D1 _ 48: 89. D9
        mov     eax, 1                                  ; 01D4 _ B8, 00000001
        jmp     r11                                     ; 01D9 _ 41: FF. E3
asco_load ENDP

END
