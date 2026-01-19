default rel

global asco_init_routine
global asco_swap


SECTION .text

asco_init_routine:; Function begin
        mov     rcx, rbx                                ; 0000 _ 48: 89. D9
        call    r12                                     ; 0003 _ 41: FF. D4
        mov     rsp, qword [r13]                        ; 0006 _ 49: 8B. 65, 00
        movdqu  xmm6, oword [rsp]                       ; 000A _ F3: 0F 6F. 34 24
        movdqu  xmm7, oword [rsp+10H]                   ; 000F _ F3: 0F 6F. 7C 24, 10
        movdqu  xmm8, oword [rsp+20H]                   ; 0015 _ F3 44: 0F 6F. 44 24, 20
        movdqu  xmm9, oword [rsp+30H]                   ; 001C _ F3 44: 0F 6F. 4C 24, 30
        movdqu  xmm10, oword [rsp+40H]                  ; 0023 _ F3 44: 0F 6F. 54 24, 40
        movdqu  xmm11, oword [rsp+50H]                  ; 002A _ F3 44: 0F 6F. 5C 24, 50
        movdqu  xmm12, oword [rsp+60H]                  ; 0031 _ F3 44: 0F 6F. 64 24, 60
        movdqu  xmm13, oword [rsp+70H]                  ; 0038 _ F3 44: 0F 6F. 6C 24, 70
        movdqu  xmm14, oword [rsp+80H]                  ; 003F _ F3 44: 0F 6F. B4 24, 00000080
        movdqu  xmm15, oword [rsp+90H]                  ; 0049 _ F3 44: 0F 6F. BC 24, 00000090
        add     rsp, 160                                ; 0053 _ 48: 81. C4, 000000A0
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword [gs:abs 30H]                 ; 005A _ 65 4C: 8B. 14 25, 00000030
        pop     dword [r10+1478H]                       ; 0063 _ 41: 8F. 82, 00001478
        pop     dword [r10+10H]                         ; 006A _ 41: 8F. 42, 10
        pop     dword [r10+8H]                          ; 006E _ 41: 8F. 42, 08
        pop     rsi                                     ; 0072 _ 5E
        pop     rdi                                     ; 0073 _ 5F
        pop     r15                                     ; 0074 _ 41: 5F
        pop     r14                                     ; 0076 _ 41: 5E
        pop     r13                                     ; 0078 _ 41: 5D
        pop     r12                                     ; 007A _ 41: 5C
        pop     rbx                                     ; 007C _ 5B
        fldcw   word [rsp+4H]                           ; 007D _ D9. 6C 24, 04
        ldmxcsr dword [rsp]                             ; 0081 _ 0F AE. 14 24
        pop     rbp                                     ; 0085 _ 5D
        pop     rbp                                     ; 0086 _ 5D
        ret                                             ; 0087 _ C3
; asco_init_routine End of function

asco_swap:; Function begin
        push    rbp                                     ; 0088 _ 55
        push    rbp                                     ; 0089 _ 55
        stmxcsr dword [rsp]                             ; 008A _ 0F AE. 1C 24
        fwait                                           ; 008E _ 9B
        fnstcw  word [rsp+4H]                           ; 008F _ D9. 7C 24, 04
        push    rbx                                     ; 0093 _ 53
        push    r12                                     ; 0094 _ 41: 54
        push    r13                                     ; 0096 _ 41: 55
        push    r14                                     ; 0098 _ 41: 56
        push    r15                                     ; 009A _ 41: 57
        push    rdi                                     ; 009C _ 57
        push    rsi                                     ; 009D _ 56
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword [gs:abs 30H]                 ; 009E _ 65 4C: 8B. 14 25, 00000030
        push    qword [r10+8H]                          ; 00A7 _ 41: FF. 72, 08
        push    qword [r10+10H]                         ; 00AB _ 41: FF. 72, 10
        push    qword [r10+1478H]                       ; 00AF _ 41: FF. B2, 00001478
        sub     rsp, 160                                ; 00B6 _ 48: 81. EC, 000000A0
        movdqu  oword [rsp], xmm6                       ; 00BD _ F3: 0F 7F. 34 24
        movdqu  oword [rsp+10H], xmm7                   ; 00C2 _ F3: 0F 7F. 7C 24, 10
        movdqu  oword [rsp+20H], xmm8                   ; 00C8 _ F3 44: 0F 7F. 44 24, 20
        movdqu  oword [rsp+30H], xmm9                   ; 00CF _ F3 44: 0F 7F. 4C 24, 30
        movdqu  oword [rsp+40H], xmm10                  ; 00D6 _ F3 44: 0F 7F. 54 24, 40
        movdqu  oword [rsp+50H], xmm11                  ; 00DD _ F3 44: 0F 7F. 5C 24, 50
        movdqu  oword [rsp+60H], xmm12                  ; 00E4 _ F3 44: 0F 7F. 64 24, 60
        movdqu  oword [rsp+70H], xmm13                  ; 00EB _ F3 44: 0F 7F. 6C 24, 70
        movdqu  oword [rsp+80H], xmm14                  ; 00F2 _ F3 44: 0F 7F. B4 24, 00000080
        movdqu  oword [rsp+90H], xmm15                  ; 00FC _ F3 44: 0F 7F. BC 24, 00000090
        mov     qword [rcx], rsp                        ; 0106 _ 48: 89. 21
        mov     rsp, rdx                                ; 0109 _ 48: 89. D4
        movdqu  xmm6, oword [rsp]                       ; 010C _ F3: 0F 6F. 34 24
        movdqu  xmm7, oword [rsp+10H]                   ; 0111 _ F3: 0F 6F. 7C 24, 10
        movdqu  xmm8, oword [rsp+20H]                   ; 0117 _ F3 44: 0F 6F. 44 24, 20
        movdqu  xmm9, oword [rsp+30H]                   ; 011E _ F3 44: 0F 6F. 4C 24, 30
        movdqu  xmm10, oword [rsp+40H]                  ; 0125 _ F3 44: 0F 6F. 54 24, 40
        movdqu  xmm11, oword [rsp+50H]                  ; 012C _ F3 44: 0F 6F. 5C 24, 50
        movdqu  xmm12, oword [rsp+60H]                  ; 0133 _ F3 44: 0F 6F. 64 24, 60
        movdqu  xmm13, oword [rsp+70H]                  ; 013A _ F3 44: 0F 6F. 6C 24, 70
        movdqu  xmm14, oword [rsp+80H]                  ; 0141 _ F3 44: 0F 6F. B4 24, 00000080
        movdqu  xmm15, oword [rsp+90H]                  ; 014B _ F3 44: 0F 6F. BC 24, 00000090
        add     rsp, 160                                ; 0155 _ 48: 81. C4, 000000A0
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword [gs:abs 30H]                 ; 015C _ 65 4C: 8B. 14 25, 00000030
        pop     dword [r10+1478H]                       ; 0165 _ 41: 8F. 82, 00001478
        pop     dword [r10+10H]                         ; 016C _ 41: 8F. 42, 10
        pop     dword [r10+8H]                          ; 0170 _ 41: 8F. 42, 08
        pop     rsi                                     ; 0174 _ 5E
        pop     rdi                                     ; 0175 _ 5F
        pop     r15                                     ; 0176 _ 41: 5F
        pop     r14                                     ; 0178 _ 41: 5E
        pop     r13                                     ; 017A _ 41: 5D
        pop     r12                                     ; 017C _ 41: 5C
        pop     rbx                                     ; 017E _ 5B
        fldcw   word [rsp+4H]                           ; 017F _ D9. 6C 24, 04
        ldmxcsr dword [rsp]                             ; 0183 _ 0F AE. 14 24
        pop     rbp                                     ; 0187 _ 5D
        pop     rbp                                     ; 0188 _ 5D
        ret                                             ; 0189 _ C3
; asco_swap End of function
