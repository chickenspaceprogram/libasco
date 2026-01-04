; Disassembly of file: source.win.o
; Sun Jan  4 11:41:47 2026
; Type: COFF64
; Syntax: NASM
; Instruction set: SSE2, x64, 80x87

default rel

global asco_init_internal
global asco_save
global asco_load

extern eax                                              ; dword


SECTION .text   align=16 exec                           ; section number 1, code

asco_init_internal:; Function begin
        mov     qword [rcx], rdx                        ; 0000 _ 48: 89. 11
        mov     qword [rcx+8H], 0                       ; 0003 _ 48: C7. 41, 08, 00000000
        mov     qword [rcx+10H], r9                     ; 000B _ 4C: 89. 49, 10
        mov     dword [rcx+18H], 8064                   ; 000F _ C7. 41, 18, 00001F80
; Note: Length-changing prefix causes delay on old Intel processors
        mov     word [rcx+1CH], 895                     ; 0016 _ 66: C7. 41, 1C, 037F
        mov     qword [rcx+20H], r8                     ; 001C _ 4C: 89. 41, 20
        ret                                             ; 0020 _ C3
; asco_init_internal End of function

asco_save:; Function begin
        pop     r11                                     ; 0021 _ 41: 5B
        mov     qword [rcx], r11                        ; 0023 _ 4C: 89. 19
        mov     qword [rcx+10H], rsp                    ; 0026 _ 48: 89. 61, 10
        push    r11                                     ; 002A _ 41: 53
        mov     qword [rcx+8H], rbp                     ; 002C _ 48: 89. 69, 08
        stmxcsr dword [rcx+18H]                         ; 0030 _ 0F AE. 59, 18
        fwait                                           ; 0034 _ 9B
        fnstcw  word [rcx+1CH]                          ; 0035 _ D9. 79, 1C
        mov     qword [rcx+20H], rbx                    ; 0038 _ 48: 89. 59, 20
        mov     qword [rcx+28H], r12                    ; 003C _ 4C: 89. 61, 28
        mov     qword [rcx+30H], r13                    ; 0040 _ 4C: 89. 69, 30
        mov     qword [rcx+38H], r14                    ; 0044 _ 4C: 89. 71, 38
        mov     qword [rcx+40H], r15                    ; 0048 _ 4C: 89. 79, 40
        mov     qword [rcx+48H], rdi                    ; 004C _ 48: 89. 79, 48
        mov     qword [rcx+50H], rsi                    ; 0050 _ 48: 89. 71, 50
        movdqu  oword [rcx+58H], xmm6                   ; 0054 _ F3: 0F 7F. 71, 58
        movdqu  oword [rcx+68H], xmm7                   ; 0059 _ F3: 0F 7F. 79, 68
        movdqu  oword [rcx+78H], xmm8                   ; 005E _ F3 44: 0F 7F. 41, 78
        movdqu  oword [rcx+88H], xmm9                   ; 0064 _ F3 44: 0F 7F. 89, 00000088
        movdqu  oword [rcx+98H], xmm10                  ; 006D _ F3 44: 0F 7F. 91, 00000098
        movdqu  oword [rcx+0A8H], xmm11                 ; 0076 _ F3 44: 0F 7F. 99, 000000A8
        movdqu  oword [rcx+0B8H], xmm12                 ; 007F _ F3 44: 0F 7F. A1, 000000B8
        movdqu  oword [rcx+0C8H], xmm13                 ; 0088 _ F3 44: 0F 7F. A9, 000000C8
        movdqu  oword [rcx+0D8H], xmm14                 ; 0091 _ F3 44: 0F 7F. B1, 000000D8
        movdqu  oword [rcx+0E8H], xmm15                 ; 009A _ F3 44: 0F 7F. B9, 000000E8
        xor     eax, eax                                ; 00A3 _ 31. C0
        ret                                             ; 00A5 _ C3
; asco_save End of function

        mov     eax, 1                                  ; 00A6 _ B8, 00000001
        ret                                             ; 00AB _ C3

asco_load:; Function begin
        mov     rbp, qword [rcx+8H]                     ; 00AC _ 48: 8B. 69, 08
        mov     rsp, qword [rcx+10H]                    ; 00B0 _ 48: 8B. 61, 10
        ldmxcsr dword [rcx+18H]                         ; 00B4 _ 0F AE. 51, 18
        fwait                                           ; 00B8 _ 9B
        fnclex                                          ; 00B9 _ DB. E2
        fldcw   word [rcx+1CH]                          ; 00BB _ D9. 69, 1C
        mov     rbx, qword [rcx+20H]                    ; 00BE _ 48: 8B. 59, 20
        mov     r12, qword [rcx+28H]                    ; 00C2 _ 4C: 8B. 61, 28
        mov     r13, qword [rcx+30H]                    ; 00C6 _ 4C: 8B. 69, 30
        mov     r14, qword [rcx+38H]                    ; 00CA _ 4C: 8B. 71, 38
        mov     r15, qword [rcx+40H]                    ; 00CE _ 4C: 8B. 79, 40
        mov     rdi, qword [rcx+48H]                    ; 00D2 _ 48: 8B. 79, 48
        mov     rsi, qword [rcx+50H]                    ; 00D6 _ 48: 8B. 71, 50
        movdqu  xmm6, oword [rcx+58H]                   ; 00DA _ F3: 0F 6F. 71, 58
        movdqu  xmm7, oword [rcx+68H]                   ; 00DF _ F3: 0F 6F. 79, 68
        movdqu  xmm8, oword [rcx+78H]                   ; 00E4 _ F3 44: 0F 6F. 41, 78
        movdqu  xmm9, oword [rcx+88H]                   ; 00EA _ F3 44: 0F 6F. 89, 00000088
        movdqu  xmm10, oword [rcx+98H]                  ; 00F3 _ F3 44: 0F 6F. 91, 00000098
        movdqu  xmm11, oword [rcx+0A8H]                 ; 00FC _ F3 44: 0F 6F. 99, 000000A8
        movdqu  xmm12, oword [rcx+0B8H]                 ; 0105 _ F3 44: 0F 6F. A1, 000000B8
        movdqu  xmm13, oword [rcx+0C8H]                 ; 010E _ F3 44: 0F 6F. A9, 000000C8
        movdqu  xmm14, oword [rcx+0D8H]                 ; 0117 _ F3 44: 0F 6F. B1, 000000D8
        movdqu  xmm15, oword [rcx+0E8H]                 ; 0120 _ F3 44: 0F 6F. B9, 000000E8
        mov     rcx, rbx                                ; 0129 _ 48: 89. D9
; Note: Address is not rip-relative
        mov     dword [abs eax], 1                      ; 012C _ C7. 04 25, 00000000, 00000001
        jmp     near [rcx]                              ; 0137 _ FF. 21
; asco_load End of function

        nop                                             ; 0139 _ 90
        nop                                             ; 013A _ 90
        nop                                             ; 013B _ 90
        nop                                             ; 013C _ 90
        nop                                             ; 013D _ 90
        nop                                             ; 013E _ 90
        nop                                             ; 013F _ 90


SECTION .data   align=16 noexec                         ; section number 2, data


SECTION .bss    align=16 noexec                         ; section number 3, bss


