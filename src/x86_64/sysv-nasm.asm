; Disassembly of file: source.sysv.o
; Sat Jan  3 20:04:41 2026
; Type: ELF64
; Syntax: NASM
; Instruction set: SSE, x64, 80x87

default rel

global asco_init_internal
global asco_save
global asco_load


SECTION .text   align=1 exec                            ; section number 1, code

asco_init_internal:; Function begin
        mov     qword [rdi], rsi                        ; 0000 _ 48: 89. 37
        mov     qword [rdi+8H], 0                       ; 0003 _ 48: C7. 47, 08, 00000000
        mov     qword [rdi+10H], rcx                    ; 000B _ 48: 89. 4F, 10
        mov     dword [rdi+18H], 8064                   ; 000F _ C7. 47, 18, 00001F80
; Note: Length-changing prefix causes delay on old Intel processors
        mov     word [rdi+1CH], 895                     ; 0016 _ 66: C7. 47, 1C, 037F
        mov     qword [rdi+20H], rdx                    ; 001C _ 48: 89. 57, 20
        ret                                             ; 0020 _ C3
; asco_init_internal End of function

asco_save:; Function begin
        lea     r11, [rel Lasco_save_cameback]          ; 0021 _ 4C: 8D. 1D, 0000002A(rel)
        mov     qword [rdi], r11                        ; 0028 _ 4C: 89. 1F
        mov     qword [rdi+8H], rbp                     ; 002B _ 48: 89. 6F, 08
        mov     qword [rdi+10H], rsp                    ; 002F _ 48: 89. 67, 10
        stmxcsr dword [rdi+18H]                         ; 0033 _ 0F AE. 5F, 18
        fwait                                           ; 0037 _ 9B
        fnstcw  word [rdi+1CH]                          ; 0038 _ D9. 7F, 1C
        mov     qword [rdi+20H], rbx                    ; 003B _ 48: 89. 5F, 20
        mov     qword [rdi+28H], r12                    ; 003F _ 4C: 89. 67, 28
        mov     qword [rdi+30H], r13                    ; 0043 _ 4C: 89. 6F, 30
        mov     qword [rdi+38H], r14                    ; 0047 _ 4C: 89. 77, 38
        mov     qword [rdi+40H], r15                    ; 004B _ 4C: 89. 7F, 40
        xor     eax, eax                                ; 004F _ 31. C0
        ret                                             ; 0051 _ C3
; asco_save End of function

Lasco_save_cameback:; Local function
        mov     eax, 1                                  ; 0052 _ B8, 00000001
        ret                                             ; 0057 _ C3

asco_load:; Function begin
        mov     rbp, qword [rdi+8H]                     ; 0058 _ 48: 8B. 6F, 08
        mov     rsp, qword [rdi+10H]                    ; 005C _ 48: 8B. 67, 10
        ldmxcsr dword [rdi+18H]                         ; 0060 _ 0F AE. 57, 18
        fwait                                           ; 0064 _ 9B
        fnclex                                          ; 0065 _ DB. E2
        fldcw   word [rdi+1CH]                          ; 0067 _ D9. 6F, 1C
        mov     rbx, qword [rdi+20H]                    ; 006A _ 48: 8B. 5F, 20
        mov     r12, qword [rdi+28H]                    ; 006E _ 4C: 8B. 67, 28
        mov     r13, qword [rdi+30H]                    ; 0072 _ 4C: 8B. 6F, 30
        mov     r14, qword [rdi+38H]                    ; 0076 _ 4C: 8B. 77, 38
        mov     r15, qword [rdi+40H]                    ; 007A _ 4C: 8B. 7F, 40
        mov     r11, rdi                                ; 007E _ 49: 89. FB
        mov     rdi, rbx                                ; 0081 _ 48: 89. DF
        jmp     near [rsi]                              ; 0084 _ FF. 26
; asco_load End of function


SECTION .data   align=1 noexec                          ; section number 2, data


SECTION .bss    align=1 noexec                          ; section number 3, bss


