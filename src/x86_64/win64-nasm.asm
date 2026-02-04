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
        pop     dword [r10+20H]                         ; 006A _ 41: 8F. 42, 20
        pop     dword [r10+10H]                         ; 006E _ 41: 8F. 42, 10
        pop     dword [r10+8H]                          ; 0072 _ 41: 8F. 42, 08
        pop     rsi                                     ; 0076 _ 5E
        pop     rdi                                     ; 0077 _ 5F
        pop     r15                                     ; 0078 _ 41: 5F
        pop     r14                                     ; 007A _ 41: 5E
        pop     r13                                     ; 007C _ 41: 5D
        pop     r12                                     ; 007E _ 41: 5C
        pop     rbx                                     ; 0080 _ 5B
        fldcw   word [rsp+4H]                           ; 0081 _ D9. 6C 24, 04
        ldmxcsr dword [rsp]                             ; 0085 _ 0F AE. 14 24
        pop     rbp                                     ; 0089 _ 5D
        pop     rbp                                     ; 008A _ 5D
        ret                                             ; 008B _ C3
; asco_init_routine End of function

asco_swap:; Function begin
        push    rbp                                     ; 008C _ 55
        push    rbp                                     ; 008D _ 55
        stmxcsr dword [rsp]                             ; 008E _ 0F AE. 1C 24
        fwait                                           ; 0092 _ 9B
        fnstcw  word [rsp+4H]                           ; 0093 _ D9. 7C 24, 04
        push    rbx                                     ; 0097 _ 53
        push    r12                                     ; 0098 _ 41: 54
        push    r13                                     ; 009A _ 41: 55
        push    r14                                     ; 009C _ 41: 56
        push    r15                                     ; 009E _ 41: 57
        push    rdi                                     ; 00A0 _ 57
        push    rsi                                     ; 00A1 _ 56
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword [gs:abs 30H]                 ; 00A2 _ 65 4C: 8B. 14 25, 00000030
        push    qword [r10+8H]                          ; 00AB _ 41: FF. 72, 08
        push    qword [r10+10H]                         ; 00AF _ 41: FF. 72, 10
        push    qword [r10+20H]                         ; 00B3 _ 41: FF. 72, 20
        push    qword [r10+1478H]                       ; 00B7 _ 41: FF. B2, 00001478
        sub     rsp, 160                                ; 00BE _ 48: 81. EC, 000000A0
        movdqu  oword [rsp], xmm6                       ; 00C5 _ F3: 0F 7F. 34 24
        movdqu  oword [rsp+10H], xmm7                   ; 00CA _ F3: 0F 7F. 7C 24, 10
        movdqu  oword [rsp+20H], xmm8                   ; 00D0 _ F3 44: 0F 7F. 44 24, 20
        movdqu  oword [rsp+30H], xmm9                   ; 00D7 _ F3 44: 0F 7F. 4C 24, 30
        movdqu  oword [rsp+40H], xmm10                  ; 00DE _ F3 44: 0F 7F. 54 24, 40
        movdqu  oword [rsp+50H], xmm11                  ; 00E5 _ F3 44: 0F 7F. 5C 24, 50
        movdqu  oword [rsp+60H], xmm12                  ; 00EC _ F3 44: 0F 7F. 64 24, 60
        movdqu  oword [rsp+70H], xmm13                  ; 00F3 _ F3 44: 0F 7F. 6C 24, 70
        movdqu  oword [rsp+80H], xmm14                  ; 00FA _ F3 44: 0F 7F. B4 24, 00000080
        movdqu  oword [rsp+90H], xmm15                  ; 0104 _ F3 44: 0F 7F. BC 24, 00000090
        mov     qword [rcx], rsp                        ; 010E _ 48: 89. 21
        mov     rsp, rdx                                ; 0111 _ 48: 89. D4
        movdqu  xmm6, oword [rsp]                       ; 0114 _ F3: 0F 6F. 34 24
        movdqu  xmm7, oword [rsp+10H]                   ; 0119 _ F3: 0F 6F. 7C 24, 10
        movdqu  xmm8, oword [rsp+20H]                   ; 011F _ F3 44: 0F 6F. 44 24, 20
        movdqu  xmm9, oword [rsp+30H]                   ; 0126 _ F3 44: 0F 6F. 4C 24, 30
        movdqu  xmm10, oword [rsp+40H]                  ; 012D _ F3 44: 0F 6F. 54 24, 40
        movdqu  xmm11, oword [rsp+50H]                  ; 0134 _ F3 44: 0F 6F. 5C 24, 50
        movdqu  xmm12, oword [rsp+60H]                  ; 013B _ F3 44: 0F 6F. 64 24, 60
        movdqu  xmm13, oword [rsp+70H]                  ; 0142 _ F3 44: 0F 6F. 6C 24, 70
        movdqu  xmm14, oword [rsp+80H]                  ; 0149 _ F3 44: 0F 6F. B4 24, 00000080
        movdqu  xmm15, oword [rsp+90H]                  ; 0153 _ F3 44: 0F 6F. BC 24, 00000090
        add     rsp, 160                                ; 015D _ 48: 81. C4, 000000A0
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword [gs:abs 30H]                 ; 0164 _ 65 4C: 8B. 14 25, 00000030
        pop     dword [r10+1478H]                       ; 016D _ 41: 8F. 82, 00001478
        pop     dword [r10+20H]                         ; 0174 _ 41: 8F. 42, 20
        pop     dword [r10+10H]                         ; 0178 _ 41: 8F. 42, 10
        pop     dword [r10+8H]                          ; 017C _ 41: 8F. 42, 08
        pop     rsi                                     ; 0180 _ 5E
        pop     rdi                                     ; 0181 _ 5F
        pop     r15                                     ; 0182 _ 41: 5F
        pop     r14                                     ; 0184 _ 41: 5E
        pop     r13                                     ; 0186 _ 41: 5D
        pop     r12                                     ; 0188 _ 41: 5C
        pop     rbx                                     ; 018A _ 5B
        fldcw   word [rsp+4H]                           ; 018B _ D9. 6C 24, 04
        ldmxcsr dword [rsp]                             ; 018F _ 0F AE. 14 24
        pop     rbp                                     ; 0193 _ 5D
        pop     rbp                                     ; 0194 _ 5D
        ret                                             ; 0195 _ C3
; asco_swap End of function
