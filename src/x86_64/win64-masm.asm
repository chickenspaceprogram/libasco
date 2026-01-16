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
        mov     r11, qword ptr [rsp+8H]                 ; 0020 _ 4C: 8B. 5C 24, 08
        mov     qword ptr [rcx+0F8H], r9                ; 0025 _ 4C: 89. 89, 000000F8
        mov     qword ptr [rcx+100H], r11               ; 002C _ 4C: 89. 99, 00000100
        ret                                             ; 0033 _ C3
asco_init_internal ENDP

asco_save PROC
        pop     r11                                     ; 0034 _ 41: 5B
        mov     qword ptr [rcx], r11                    ; 0036 _ 4C: 89. 19
        mov     qword ptr [rcx+10H], rsp                ; 0039 _ 48: 89. 61, 10
        push    r11                                     ; 003D _ 41: 53
        mov     qword ptr [rcx+8H], rbp                 ; 003F _ 48: 89. 69, 08
        stmxcsr dword ptr [rcx+18H]                     ; 0043 _ 0F AE. 59, 18
        fwait                                           ; 0047 _ 9B
        fnstcw  word ptr [rcx+1CH]                      ; 0048 _ D9. 79, 1C
        mov     qword ptr [rcx+20H], rbx                ; 004B _ 48: 89. 59, 20
        mov     qword ptr [rcx+28H], r12                ; 004F _ 4C: 89. 61, 28
        mov     qword ptr [rcx+30H], r13                ; 0053 _ 4C: 89. 69, 30
        mov     qword ptr [rcx+38H], r14                ; 0057 _ 4C: 89. 71, 38
        mov     qword ptr [rcx+40H], r15                ; 005B _ 4C: 89. 79, 40
        mov     qword ptr [rcx+48H], rdi                ; 005F _ 48: 89. 79, 48
        mov     qword ptr [rcx+50H], rsi                ; 0063 _ 48: 89. 71, 50
        movdqu  xmmword ptr [rcx+58H], xmm6             ; 0067 _ F3: 0F 7F. 71, 58
        movdqu  xmmword ptr [rcx+68H], xmm7             ; 006C _ F3: 0F 7F. 79, 68
        movdqu  xmmword ptr [rcx+78H], xmm8             ; 0071 _ F3 44: 0F 7F. 41, 78
        movdqu  xmmword ptr [rcx+88H], xmm9             ; 0077 _ F3 44: 0F 7F. 89, 00000088
        movdqu  xmmword ptr [rcx+98H], xmm10            ; 0080 _ F3 44: 0F 7F. 91, 00000098
        movdqu  xmmword ptr [rcx+0A8H], xmm11           ; 0089 _ F3 44: 0F 7F. 99, 000000A8
        movdqu  xmmword ptr [rcx+0B8H], xmm12           ; 0092 _ F3 44: 0F 7F. A1, 000000B8
        movdqu  xmmword ptr [rcx+0C8H], xmm13           ; 009B _ F3 44: 0F 7F. A9, 000000C8
        movdqu  xmmword ptr [rcx+0D8H], xmm14           ; 00A4 _ F3 44: 0F 7F. B1, 000000D8
        movdqu  xmmword ptr [rcx+0E8H], xmm15           ; 00AD _ F3 44: 0F 7F. B9, 000000E8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword ptr gs:[8H]                  ; 00B6 _ 65 4C: 8B. 1C 25, 00000008
        mov     qword ptr [rcx+0F8H], r11               ; 00BF _ 4C: 89. 99, 000000F8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword ptr gs:[10H]                 ; 00C6 _ 65 4C: 8B. 1C 25, 00000010
        mov     qword ptr [rcx+100H], r11               ; 00CF _ 4C: 89. 99, 00000100
        xor     eax, eax                                ; 00D6 _ 31. C0
        ret                                             ; 00D8 _ C3
asco_save ENDP

asco_load PROC
        mov     r11, qword ptr [rcx]                    ; 00D9 _ 4C: 8B. 19
        mov     rbp, qword ptr [rcx+8H]                 ; 00DC _ 48: 8B. 69, 08
        mov     rsp, qword ptr [rcx+10H]                ; 00E0 _ 48: 8B. 61, 10
        ldmxcsr dword ptr [rcx+18H]                     ; 00E4 _ 0F AE. 51, 18
        fwait                                           ; 00E8 _ 9B
        fnclex                                          ; 00E9 _ DB. E2
        fldcw   word ptr [rcx+1CH]                      ; 00EB _ D9. 69, 1C
        mov     rbx, qword ptr [rcx+20H]                ; 00EE _ 48: 8B. 59, 20
        mov     r12, qword ptr [rcx+28H]                ; 00F2 _ 4C: 8B. 61, 28
        mov     r13, qword ptr [rcx+30H]                ; 00F6 _ 4C: 8B. 69, 30
        mov     r14, qword ptr [rcx+38H]                ; 00FA _ 4C: 8B. 71, 38
        mov     r15, qword ptr [rcx+40H]                ; 00FE _ 4C: 8B. 79, 40
        mov     rdi, qword ptr [rcx+48H]                ; 0102 _ 48: 8B. 79, 48
        mov     rsi, qword ptr [rcx+50H]                ; 0106 _ 48: 8B. 71, 50
        movdqu  xmm6, xmmword ptr [rcx+58H]             ; 010A _ F3: 0F 6F. 71, 58
        movdqu  xmm7, xmmword ptr [rcx+68H]             ; 010F _ F3: 0F 6F. 79, 68
        movdqu  xmm8, xmmword ptr [rcx+78H]             ; 0114 _ F3 44: 0F 6F. 41, 78
        movdqu  xmm9, xmmword ptr [rcx+88H]             ; 011A _ F3 44: 0F 6F. 89, 00000088
        movdqu  xmm10, xmmword ptr [rcx+98H]            ; 0123 _ F3 44: 0F 6F. 91, 00000098
        movdqu  xmm11, xmmword ptr [rcx+0A8H]           ; 012C _ F3 44: 0F 6F. 99, 000000A8
        movdqu  xmm12, xmmword ptr [rcx+0B8H]           ; 0135 _ F3 44: 0F 6F. A1, 000000B8
        movdqu  xmm13, xmmword ptr [rcx+0C8H]           ; 013E _ F3 44: 0F 6F. A9, 000000C8
        movdqu  xmm14, xmmword ptr [rcx+0D8H]           ; 0147 _ F3 44: 0F 6F. B1, 000000D8
        movdqu  xmm15, xmmword ptr [rcx+0E8H]           ; 0150 _ F3 44: 0F 6F. B9, 000000E8
        mov     r10, qword ptr [rcx+0F8H]               ; 0159 _ 4C: 8B. 91, 000000F8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword ptr gs:[8H], r10                  ; 0160 _ 65 4C: 89. 14 25, 00000008
        mov     r10, qword ptr [rcx+100H]               ; 0169 _ 4C: 8B. 91, 00000100
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword ptr gs:[10H], r10                 ; 0170 _ 65 4C: 89. 14 25, 00000010
        mov     rcx, rbx                                ; 0179 _ 48: 89. D9
        mov     eax, 1                                  ; 017C _ B8, 00000001
        jmp     r11                                     ; 0181 _ 41: FF. E3
asco_load ENDP

END
