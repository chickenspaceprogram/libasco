default rel

global asco_init_internal
global asco_save
global asco_load


SECTION .text

asco_init_internal:; Function begin
        mov     qword [rcx], rdx                        ; 0000 _ 48: 89. 11
        mov     qword [rcx+8H], 0                       ; 0003 _ 48: C7. 41, 08, 00000000
        mov     qword [rcx+10H], r9                     ; 000B _ 4C: 89. 49, 10
        mov     dword [rcx+18H], 8064                   ; 000F _ C7. 41, 18, 00001F80
; Note: Length-changing prefix causes delay on old Intel processors
        mov     word [rcx+1CH], 895                     ; 0016 _ 66: C7. 41, 1C, 037F
        mov     qword [rcx+20H], r8                     ; 001C _ 4C: 89. 41, 20
        mov     r11, qword [rsp+8H]                     ; 0020 _ 4C: 8B. 5C 24, 08
        mov     qword [rcx+0F8H], r9                    ; 0025 _ 4C: 89. 89, 000000F8
        mov     qword [rcx+100H], r11                   ; 002C _ 4C: 89. 99, 00000100
        mov     qword [rcx+108H], r11                   ; 0033 _ 4C: 89. 99, 00000108
        sub     r9, r11                                 ; 003A _ 4D: 29. D9
        mov     qword [rcx+110H], r9                    ; 003D _ 4C: 89. 89, 00000110
        ret                                             ; 0044 _ C3
; asco_init_internal End of function

asco_save:; Function begin
        pop     r11                                     ; 0045 _ 41: 5B
        mov     qword [rcx], r11                        ; 0047 _ 4C: 89. 19
        mov     qword [rcx+10H], rsp                    ; 004A _ 48: 89. 61, 10
        push    r11                                     ; 004E _ 41: 53
        mov     qword [rcx+8H], rbp                     ; 0050 _ 48: 89. 69, 08
        stmxcsr dword [rcx+18H]                         ; 0054 _ 0F AE. 59, 18
        fwait                                           ; 0058 _ 9B
        fnstcw  word [rcx+1CH]                          ; 0059 _ D9. 79, 1C
        mov     qword [rcx+20H], rbx                    ; 005C _ 48: 89. 59, 20
        mov     qword [rcx+28H], r12                    ; 0060 _ 4C: 89. 61, 28
        mov     qword [rcx+30H], r13                    ; 0064 _ 4C: 89. 69, 30
        mov     qword [rcx+38H], r14                    ; 0068 _ 4C: 89. 71, 38
        mov     qword [rcx+40H], r15                    ; 006C _ 4C: 89. 79, 40
        mov     qword [rcx+48H], rdi                    ; 0070 _ 48: 89. 79, 48
        mov     qword [rcx+50H], rsi                    ; 0074 _ 48: 89. 71, 50
        movdqu  oword [rcx+58H], xmm6                   ; 0078 _ F3: 0F 7F. 71, 58
        movdqu  oword [rcx+68H], xmm7                   ; 007D _ F3: 0F 7F. 79, 68
        movdqu  oword [rcx+78H], xmm8                   ; 0082 _ F3 44: 0F 7F. 41, 78
        movdqu  oword [rcx+88H], xmm9                   ; 0088 _ F3 44: 0F 7F. 89, 00000088
        movdqu  oword [rcx+98H], xmm10                  ; 0091 _ F3 44: 0F 7F. 91, 00000098
        movdqu  oword [rcx+0A8H], xmm11                 ; 009A _ F3 44: 0F 7F. 99, 000000A8
        movdqu  oword [rcx+0B8H], xmm12                 ; 00A3 _ F3 44: 0F 7F. A1, 000000B8
        movdqu  oword [rcx+0C8H], xmm13                 ; 00AC _ F3 44: 0F 7F. A9, 000000C8
        movdqu  oword [rcx+0D8H], xmm14                 ; 00B5 _ F3 44: 0F 7F. B1, 000000D8
        movdqu  oword [rcx+0E8H], xmm15                 ; 00BE _ F3 44: 0F 7F. B9, 000000E8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword [gs:abs 8H]                  ; 00C7 _ 65 4C: 8B. 1C 25, 00000008
        mov     qword [rcx+0F8H], r11                   ; 00D0 _ 4C: 89. 99, 000000F8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword [gs:abs 10H]                 ; 00D7 _ 65 4C: 8B. 1C 25, 00000010
        mov     qword [rcx+100H], r11                   ; 00E0 _ 4C: 89. 99, 00000100
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword [gs:abs 1478H]               ; 00E7 _ 65 4C: 8B. 1C 25, 00001478
        mov     qword [rcx+108H], r11                   ; 00F0 _ 4C: 89. 99, 00000108
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword [gs:abs 1748H]               ; 00F7 _ 65 4C: 8B. 1C 25, 00001748
        mov     qword [rcx+110H], r11                   ; 0100 _ 4C: 89. 99, 00000110
        xor     eax, eax                                ; 0107 _ 31. C0
        ret                                             ; 0109 _ C3
; asco_save End of function

asco_load:; Function begin
        mov     r11, qword [rcx]                        ; 010A _ 4C: 8B. 19
        mov     rbp, qword [rcx+8H]                     ; 010D _ 48: 8B. 69, 08
        mov     rsp, qword [rcx+10H]                    ; 0111 _ 48: 8B. 61, 10
        ldmxcsr dword [rcx+18H]                         ; 0115 _ 0F AE. 51, 18
        fwait                                           ; 0119 _ 9B
        fnclex                                          ; 011A _ DB. E2
        fldcw   word [rcx+1CH]                          ; 011C _ D9. 69, 1C
        mov     rbx, qword [rcx+20H]                    ; 011F _ 48: 8B. 59, 20
        mov     r12, qword [rcx+28H]                    ; 0123 _ 4C: 8B. 61, 28
        mov     r13, qword [rcx+30H]                    ; 0127 _ 4C: 8B. 69, 30
        mov     r14, qword [rcx+38H]                    ; 012B _ 4C: 8B. 71, 38
        mov     r15, qword [rcx+40H]                    ; 012F _ 4C: 8B. 79, 40
        mov     rdi, qword [rcx+48H]                    ; 0133 _ 48: 8B. 79, 48
        mov     rsi, qword [rcx+50H]                    ; 0137 _ 48: 8B. 71, 50
        movdqu  xmm6, oword [rcx+58H]                   ; 013B _ F3: 0F 6F. 71, 58
        movdqu  xmm7, oword [rcx+68H]                   ; 0140 _ F3: 0F 6F. 79, 68
        movdqu  xmm8, oword [rcx+78H]                   ; 0145 _ F3 44: 0F 6F. 41, 78
        movdqu  xmm9, oword [rcx+88H]                   ; 014B _ F3 44: 0F 6F. 89, 00000088
        movdqu  xmm10, oword [rcx+98H]                  ; 0154 _ F3 44: 0F 6F. 91, 00000098
        movdqu  xmm11, oword [rcx+0A8H]                 ; 015D _ F3 44: 0F 6F. 99, 000000A8
        movdqu  xmm12, oword [rcx+0B8H]                 ; 0166 _ F3 44: 0F 6F. A1, 000000B8
        movdqu  xmm13, oword [rcx+0C8H]                 ; 016F _ F3 44: 0F 6F. A9, 000000C8
        movdqu  xmm14, oword [rcx+0D8H]                 ; 0178 _ F3 44: 0F 6F. B1, 000000D8
        movdqu  xmm15, oword [rcx+0E8H]                 ; 0181 _ F3 44: 0F 6F. B9, 000000E8
        mov     r10, qword [rcx+0F8H]                   ; 018A _ 4C: 8B. 91, 000000F8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword [gs:abs 8H], r10                  ; 0191 _ 65 4C: 89. 14 25, 00000008
        mov     r10, qword [rcx+100H]                   ; 019A _ 4C: 8B. 91, 00000100
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword [gs:abs 10H], r10                 ; 01A1 _ 65 4C: 89. 14 25, 00000010
        mov     r10, qword [rcx+108H]                   ; 01AA _ 4C: 8B. 91, 00000108
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword [gs:abs 1478H], r10               ; 01B1 _ 65 4C: 89. 14 25, 00001478
        mov     r10, qword [rcx+110H]                   ; 01BA _ 4C: 8B. 91, 00000110
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword [gs:abs 1748H], r10               ; 01C1 _ 65 4C: 89. 14 25, 00001748
        mov     rcx, rbx                                ; 01CA _ 48: 89. D9
        mov     eax, 1                                  ; 01CD _ B8, 00000001
        jmp     r11                                     ; 01D2 _ 41: FF. E3
; asco_load End of function
