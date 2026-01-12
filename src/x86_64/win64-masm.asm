; Disassembly of file: source.win.o
; Sun Jan 11 17:24:46 2026
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
; Note: Length-changing prefix causes delay on Intel processors
        mov     word ptr [rcx+1CH], 895                 ; 0016 _ 66: C7. 41, 1C, 037F
        mov     qword ptr [rcx+20H], r8                 ; 001C _ 4C: 89. 41, 20
        ret                                             ; 0020 _ C3
asco_init_internal ENDP

asco_save PROC
        pop     r11                                     ; 0021 _ 41: 5B
        mov     qword ptr [rcx], r11                    ; 0023 _ 4C: 89. 19
        mov     qword ptr [rcx+10H], rsp                ; 0026 _ 48: 89. 61, 10
        push    r11                                     ; 002A _ 41: 53
        mov     qword ptr [rcx+8H], rbp                 ; 002C _ 48: 89. 69, 08
        stmxcsr dword ptr [rcx+18H]                     ; 0030 _ 0F AE. 59, 18
        fwait                                           ; 0034 _ 9B
        fnstcw  word ptr [rcx+1CH]                      ; 0035 _ D9. 79, 1C
        mov     qword ptr [rcx+20H], rbx                ; 0038 _ 48: 89. 59, 20
        mov     qword ptr [rcx+28H], r12                ; 003C _ 4C: 89. 61, 28
        mov     qword ptr [rcx+30H], r13                ; 0040 _ 4C: 89. 69, 30
        mov     qword ptr [rcx+38H], r14                ; 0044 _ 4C: 89. 71, 38
        mov     qword ptr [rcx+40H], r15                ; 0048 _ 4C: 89. 79, 40
        mov     qword ptr [rcx+48H], rdi                ; 004C _ 48: 89. 79, 48
        mov     qword ptr [rcx+50H], rsi                ; 0050 _ 48: 89. 71, 50
        movdqu  xmmword ptr [rcx+58H], xmm6             ; 0054 _ F3: 0F 7F. 71, 58
        movdqu  xmmword ptr [rcx+68H], xmm7             ; 0059 _ F3: 0F 7F. 79, 68
        movdqu  xmmword ptr [rcx+78H], xmm8             ; 005E _ F3 44: 0F 7F. 41, 78
        movdqu  xmmword ptr [rcx+88H], xmm9             ; 0064 _ F3 44: 0F 7F. 89, 00000088
        movdqu  xmmword ptr [rcx+98H], xmm10            ; 006D _ F3 44: 0F 7F. 91, 00000098
        movdqu  xmmword ptr [rcx+0A8H], xmm11           ; 0076 _ F3 44: 0F 7F. 99, 000000A8
        movdqu  xmmword ptr [rcx+0B8H], xmm12           ; 007F _ F3 44: 0F 7F. A1, 000000B8
        movdqu  xmmword ptr [rcx+0C8H], xmm13           ; 0088 _ F3 44: 0F 7F. A9, 000000C8
        movdqu  xmmword ptr [rcx+0D8H], xmm14           ; 0091 _ F3 44: 0F 7F. B1, 000000D8
        movdqu  xmmword ptr [rcx+0E8H], xmm15           ; 009A _ F3 44: 0F 7F. B9, 000000E8
        xor     eax, eax                                ; 00A3 _ 31. C0
        ret                                             ; 00A5 _ C3
asco_save ENDP

asco_load PROC
        mov     r11, qword ptr [rcx]                    ; 00A6 _ 4C: 8B. 19
        mov     rbp, qword ptr [rcx+8H]                 ; 00A9 _ 48: 8B. 69, 08
        mov     rsp, qword ptr [rcx+10H]                ; 00AD _ 48: 8B. 61, 10
        ldmxcsr dword ptr [rcx+18H]                     ; 00B1 _ 0F AE. 51, 18
        fwait                                           ; 00B5 _ 9B
        fnclex                                          ; 00B6 _ DB. E2
        fldcw   word ptr [rcx+1CH]                      ; 00B8 _ D9. 69, 1C
        mov     rbx, qword ptr [rcx+20H]                ; 00BB _ 48: 8B. 59, 20
        mov     r12, qword ptr [rcx+28H]                ; 00BF _ 4C: 8B. 61, 28
        mov     r13, qword ptr [rcx+30H]                ; 00C3 _ 4C: 8B. 69, 30
        mov     r14, qword ptr [rcx+38H]                ; 00C7 _ 4C: 8B. 71, 38
        mov     r15, qword ptr [rcx+40H]                ; 00CB _ 4C: 8B. 79, 40
        mov     rdi, qword ptr [rcx+48H]                ; 00CF _ 48: 8B. 79, 48
        mov     rsi, qword ptr [rcx+50H]                ; 00D3 _ 48: 8B. 71, 50
        movdqu  xmm6, xmmword ptr [rcx+58H]             ; 00D7 _ F3: 0F 6F. 71, 58
        movdqu  xmm7, xmmword ptr [rcx+68H]             ; 00DC _ F3: 0F 6F. 79, 68
        movdqu  xmm8, xmmword ptr [rcx+78H]             ; 00E1 _ F3 44: 0F 6F. 41, 78
        movdqu  xmm9, xmmword ptr [rcx+88H]             ; 00E7 _ F3 44: 0F 6F. 89, 00000088
        movdqu  xmm10, xmmword ptr [rcx+98H]            ; 00F0 _ F3 44: 0F 6F. 91, 00000098
        movdqu  xmm11, xmmword ptr [rcx+0A8H]           ; 00F9 _ F3 44: 0F 6F. 99, 000000A8
        movdqu  xmm12, xmmword ptr [rcx+0B8H]           ; 0102 _ F3 44: 0F 6F. A1, 000000B8
        movdqu  xmm13, xmmword ptr [rcx+0C8H]           ; 010B _ F3 44: 0F 6F. A9, 000000C8
        movdqu  xmm14, xmmword ptr [rcx+0D8H]           ; 0114 _ F3 44: 0F 6F. B1, 000000D8
        movdqu  xmm15, xmmword ptr [rcx+0E8H]           ; 011D _ F3 44: 0F 6F. B9, 000000E8
        mov     rcx, rbx                                ; 0126 _ 48: 89. D9
        mov     eax, 1                                  ; 0129 _ B8, 00000001
        jmp     r11                                     ; 012E _ 41: FF. E3
asco_load ENDP

_text   ENDS

END
