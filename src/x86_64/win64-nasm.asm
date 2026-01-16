; Disassembly of file: source.win.o
; Fri Jan 16 02:10:57 2026
; Type: ELF64
; Syntax: NASM
; Instruction set: SSE2, x64, 80x87

default rel

global asco_init_internal
global asco_save
global asco_load


SECTION .text   align=1 exec                            ; section number 1, code

asco_init_internal:; Function begin
        mov     qword [rcx], rdx                        ; 0000 _ 48: 89. 11
        mov     qword [rcx+8H], 0                       ; 0003 _ 48: C7. 41, 08, 00000000
        mov     qword [rcx+10H], r9                     ; 000B _ 4C: 89. 49, 10
        mov     dword [rcx+18H], 8064                   ; 000F _ C7. 41, 18, 00001F80
; Note: Length-changing prefix causes delay on Intel processors
        mov     word [rcx+1CH], 895                     ; 0016 _ 66: C7. 41, 1C, 037F
        mov     qword [rcx+20H], r8                     ; 001C _ 4C: 89. 41, 20
        mov     r11, qword [rsp+8H]                     ; 0020 _ 4C: 8B. 5C 24, 08
        mov     qword [rcx+0F8H], r9                    ; 0025 _ 4C: 89. 89, 000000F8
        mov     qword [rcx+100H], r11                   ; 002C _ 4C: 89. 99, 00000100
        ret                                             ; 0033 _ C3
; asco_init_internal End of function

asco_save:; Function begin
        pop     r11                                     ; 0034 _ 41: 5B
        mov     qword [rcx], r11                        ; 0036 _ 4C: 89. 19
        mov     qword [rcx+10H], rsp                    ; 0039 _ 48: 89. 61, 10
        push    r11                                     ; 003D _ 41: 53
        mov     qword [rcx+8H], rbp                     ; 003F _ 48: 89. 69, 08
        stmxcsr dword [rcx+18H]                         ; 0043 _ 0F AE. 59, 18
        fwait                                           ; 0047 _ 9B
        fnstcw  word [rcx+1CH]                          ; 0048 _ D9. 79, 1C
        mov     qword [rcx+20H], rbx                    ; 004B _ 48: 89. 59, 20
        mov     qword [rcx+28H], r12                    ; 004F _ 4C: 89. 61, 28
        mov     qword [rcx+30H], r13                    ; 0053 _ 4C: 89. 69, 30
        mov     qword [rcx+38H], r14                    ; 0057 _ 4C: 89. 71, 38
        mov     qword [rcx+40H], r15                    ; 005B _ 4C: 89. 79, 40
        mov     qword [rcx+48H], rdi                    ; 005F _ 48: 89. 79, 48
        mov     qword [rcx+50H], rsi                    ; 0063 _ 48: 89. 71, 50
        movdqu  oword [rcx+58H], xmm6                   ; 0067 _ F3: 0F 7F. 71, 58
        movdqu  oword [rcx+68H], xmm7                   ; 006C _ F3: 0F 7F. 79, 68
        movdqu  oword [rcx+78H], xmm8                   ; 0071 _ F3 44: 0F 7F. 41, 78
        movdqu  oword [rcx+88H], xmm9                   ; 0077 _ F3 44: 0F 7F. 89, 00000088
        movdqu  oword [rcx+98H], xmm10                  ; 0080 _ F3 44: 0F 7F. 91, 00000098
        movdqu  oword [rcx+0A8H], xmm11                 ; 0089 _ F3 44: 0F 7F. 99, 000000A8
        movdqu  oword [rcx+0B8H], xmm12                 ; 0092 _ F3 44: 0F 7F. A1, 000000B8
        movdqu  oword [rcx+0C8H], xmm13                 ; 009B _ F3 44: 0F 7F. A9, 000000C8
        movdqu  oword [rcx+0D8H], xmm14                 ; 00A4 _ F3 44: 0F 7F. B1, 000000D8
        movdqu  oword [rcx+0E8H], xmm15                 ; 00AD _ F3 44: 0F 7F. B9, 000000E8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword [gs:abs 8H]                  ; 00B6 _ 65 4C: 8B. 1C 25, 00000008
        mov     qword [rcx+0F8H], r11                   ; 00BF _ 4C: 89. 99, 000000F8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r11, qword [gs:abs 10H]                 ; 00C6 _ 65 4C: 8B. 1C 25, 00000010
        mov     qword [rcx+100H], r11                   ; 00CF _ 4C: 89. 99, 00000100
        xor     eax, eax                                ; 00D6 _ 31. C0
        ret                                             ; 00D8 _ C3
; asco_save End of function

asco_load:; Function begin
        mov     r11, qword [rcx]                        ; 00D9 _ 4C: 8B. 19
        mov     rbp, qword [rcx+8H]                     ; 00DC _ 48: 8B. 69, 08
        mov     rsp, qword [rcx+10H]                    ; 00E0 _ 48: 8B. 61, 10
        ldmxcsr dword [rcx+18H]                         ; 00E4 _ 0F AE. 51, 18
        fwait                                           ; 00E8 _ 9B
        fnclex                                          ; 00E9 _ DB. E2
        fldcw   word [rcx+1CH]                          ; 00EB _ D9. 69, 1C
        mov     rbx, qword [rcx+20H]                    ; 00EE _ 48: 8B. 59, 20
        mov     r12, qword [rcx+28H]                    ; 00F2 _ 4C: 8B. 61, 28
        mov     r13, qword [rcx+30H]                    ; 00F6 _ 4C: 8B. 69, 30
        mov     r14, qword [rcx+38H]                    ; 00FA _ 4C: 8B. 71, 38
        mov     r15, qword [rcx+40H]                    ; 00FE _ 4C: 8B. 79, 40
        mov     rdi, qword [rcx+48H]                    ; 0102 _ 48: 8B. 79, 48
        mov     rsi, qword [rcx+50H]                    ; 0106 _ 48: 8B. 71, 50
        movdqu  xmm6, oword [rcx+58H]                   ; 010A _ F3: 0F 6F. 71, 58
        movdqu  xmm7, oword [rcx+68H]                   ; 010F _ F3: 0F 6F. 79, 68
        movdqu  xmm8, oword [rcx+78H]                   ; 0114 _ F3 44: 0F 6F. 41, 78
        movdqu  xmm9, oword [rcx+88H]                   ; 011A _ F3 44: 0F 6F. 89, 00000088
        movdqu  xmm10, oword [rcx+98H]                  ; 0123 _ F3 44: 0F 6F. 91, 00000098
        movdqu  xmm11, oword [rcx+0A8H]                 ; 012C _ F3 44: 0F 6F. 99, 000000A8
        movdqu  xmm12, oword [rcx+0B8H]                 ; 0135 _ F3 44: 0F 6F. A1, 000000B8
        movdqu  xmm13, oword [rcx+0C8H]                 ; 013E _ F3 44: 0F 6F. A9, 000000C8
        movdqu  xmm14, oword [rcx+0D8H]                 ; 0147 _ F3 44: 0F 6F. B1, 000000D8
        movdqu  xmm15, oword [rcx+0E8H]                 ; 0150 _ F3 44: 0F 6F. B9, 000000E8
        mov     r10, qword [rcx+0F8H]                   ; 0159 _ 4C: 8B. 91, 000000F8
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword [gs:abs 8H], r10                  ; 0160 _ 65 4C: 89. 14 25, 00000008
        mov     r10, qword [rcx+100H]                   ; 0169 _ 4C: 8B. 91, 00000100
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     qword [gs:abs 10H], r10                 ; 0170 _ 65 4C: 89. 14 25, 00000010
        mov     rcx, rbx                                ; 0179 _ 48: 89. D9
        mov     eax, 1                                  ; 017C _ B8, 00000001
        jmp     r11                                     ; 0181 _ 41: FF. E3
; asco_load End of function


SECTION .data   align=1 noexec                          ; section number 2, data


SECTION .bss    align=1 noexec                          ; section number 3, bss


SECTION .note.gnu.property align=8 noexec               ; section number 4, const

        db 04H, 00H, 00H, 00H, 20H, 00H, 00H, 00H       ; 0000 _ .... ...
        db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H       ; 0008 _ ....GNU.
        db 02H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H      ; 0010 _ ........
        db 01H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 0018 _ ........
        db 01H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H      ; 0020 _ ........
        db 09H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 0028 _ ........


