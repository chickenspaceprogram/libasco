default rel

global asco_init_internal
global asco_save
global asco_load


SECTION .text

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
        pop     r11                                     ; 0021 _ 41: 5B
        mov     qword [rdi], r11                        ; 0023 _ 4C: 89. 1F
        mov     qword [rdi+10H], rsp                    ; 0026 _ 48: 89. 67, 10
        push    r11                                     ; 002A _ 41: 53
        mov     qword [rdi+8H], rbp                     ; 002C _ 48: 89. 6F, 08
        stmxcsr dword [rdi+18H]                         ; 0030 _ 0F AE. 5F, 18
        fwait                                           ; 0034 _ 9B
        fnstcw  word [rdi+1CH]                          ; 0035 _ D9. 7F, 1C
        mov     qword [rdi+20H], rbx                    ; 0038 _ 48: 89. 5F, 20
        mov     qword [rdi+28H], r12                    ; 003C _ 4C: 89. 67, 28
        mov     qword [rdi+30H], r13                    ; 0040 _ 4C: 89. 6F, 30
        mov     qword [rdi+38H], r14                    ; 0044 _ 4C: 89. 77, 38
        mov     qword [rdi+40H], r15                    ; 0048 _ 4C: 89. 7F, 40
        xor     eax, eax                                ; 004C _ 31. C0
        ret                                             ; 004E _ C3
; asco_save End of function

asco_load:; Function begin
        mov     r11, qword [rdi]                        ; 004F _ 4C: 8B. 1F
        mov     rbp, qword [rdi+8H]                     ; 0052 _ 48: 8B. 6F, 08
        mov     rsp, qword [rdi+10H]                    ; 0056 _ 48: 8B. 67, 10
        ldmxcsr dword [rdi+18H]                         ; 005A _ 0F AE. 57, 18
        fwait                                           ; 005E _ 9B
        fnclex                                          ; 005F _ DB. E2
        fldcw   word [rdi+1CH]                          ; 0061 _ D9. 6F, 1C
        mov     rbx, qword [rdi+20H]                    ; 0064 _ 48: 8B. 5F, 20
        mov     r12, qword [rdi+28H]                    ; 0068 _ 4C: 8B. 67, 28
        mov     r13, qword [rdi+30H]                    ; 006C _ 4C: 8B. 6F, 30
        mov     r14, qword [rdi+38H]                    ; 0070 _ 4C: 8B. 77, 38
        mov     r15, qword [rdi+40H]                    ; 0074 _ 4C: 8B. 7F, 40
        mov     rdi, rbx                                ; 0078 _ 48: 89. DF
        mov     eax, 1                                  ; 007B _ B8, 00000001
        jmp     r11                                     ; 0080 _ 41: FF. E3
; asco_load End of function
