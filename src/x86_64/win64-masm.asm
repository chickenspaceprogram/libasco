; Disassembly of file: source.win.o
; Tue Feb  3 20:45:02 2026
; Type: ELF64
; Syntax: MASM/ML64
; Instruction set: SSE2, x64, 80x87
option dotname

public asco_init_routine
public asco_swap


.code

asco_init_routine PROC
        mov     rcx, rbx                                ; 0000 _ 48: 89. D9
        call    r12                                     ; 0003 _ 41: FF. D4
        mov     rsp, qword ptr [r13]                    ; 0006 _ 49: 8B. 65, 00
        movdqu  xmm6, xmmword ptr [rsp]                 ; 000A _ F3: 0F 6F. 34 24
        movdqu  xmm7, xmmword ptr [rsp+10H]             ; 000F _ F3: 0F 6F. 7C 24, 10
        movdqu  xmm8, xmmword ptr [rsp+20H]             ; 0015 _ F3 44: 0F 6F. 44 24, 20
        movdqu  xmm9, xmmword ptr [rsp+30H]             ; 001C _ F3 44: 0F 6F. 4C 24, 30
        movdqu  xmm10, xmmword ptr [rsp+40H]            ; 0023 _ F3 44: 0F 6F. 54 24, 40
        movdqu  xmm11, xmmword ptr [rsp+50H]            ; 002A _ F3 44: 0F 6F. 5C 24, 50
        movdqu  xmm12, xmmword ptr [rsp+60H]            ; 0031 _ F3 44: 0F 6F. 64 24, 60
        movdqu  xmm13, xmmword ptr [rsp+70H]            ; 0038 _ F3 44: 0F 6F. 6C 24, 70
        movdqu  xmm14, xmmword ptr [rsp+80H]            ; 003F _ F3 44: 0F 6F. B4 24, 00000080
        movdqu  xmm15, xmmword ptr [rsp+90H]            ; 0049 _ F3 44: 0F 6F. BC 24, 00000090
        add     rsp, 160                                ; 0053 _ 48: 81. C4, 000000A0
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword ptr gs:[30H]                 ; 005A _ 65 4C: 8B. 14 25, 00000030
        pop     [r10+1478H]                   ; 0063 _ 41: 8F. 82, 00001478
        pop     [r10+20H]                     ; 006A _ 41: 8F. 42, 10
        pop     [r10+10H]                     ; 006A _ 41: 8F. 42, 10
        pop     [r10+8H]                      ; 006E _ 41: 8F. 42, 08
        pop     rsi                                     ; 0072 _ 5E
        pop     rdi                                     ; 0073 _ 5F
        pop     r15                                     ; 0074 _ 41: 5F
        pop     r14                                     ; 0076 _ 41: 5E
        pop     r13                                     ; 0078 _ 41: 5D
        pop     r12                                     ; 007A _ 41: 5C
        pop     rbx                                     ; 007C _ 5B
        fldcw   word ptr [rsp+4H]                       ; 007D _ D9. 6C 24, 04
        ldmxcsr dword ptr [rsp]                         ; 0081 _ 0F AE. 14 24
        pop     rbp                                     ; 0085 _ 5D
        pop     rbp                                     ; 0086 _ 5D
        ret                                             ; 0087 _ C3
asco_init_routine ENDP

asco_swap PROC
        push    rbp                                     ; 0088 _ 55
        push    rbp                                     ; 0089 _ 55
        stmxcsr dword ptr [rsp]                         ; 008A _ 0F AE. 1C 24
        fwait                                           ; 008E _ 9B
        fnstcw  word ptr [rsp+4H]                       ; 008F _ D9. 7C 24, 04
        push    rbx                                     ; 0093 _ 53
        push    r12                                     ; 0094 _ 41: 54
        push    r13                                     ; 0096 _ 41: 55
        push    r14                                     ; 0098 _ 41: 56
        push    r15                                     ; 009A _ 41: 57
        push    rdi                                     ; 009C _ 57
        push    rsi                                     ; 009D _ 56
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword ptr gs:[30H]                 ; 009E _ 65 4C: 8B. 14 25, 00000030
        push    qword ptr [r10+8H]                      ; 00A7 _ 41: FF. 72, 08
        push    qword ptr [r10+10H]                     ; 00AB _ 41: FF. 72, 10
        push    qword ptr [r10+20H]                     ; 00AF _ 41: FF. 72, 20
        push    qword ptr [r10+1478H]                   ; 00B3 _ 41: FF. B2, 00001478
        sub     rsp, 160                                ; 00BA _ 48: 81. EC, 000000A0
        movdqu  xmmword ptr [rsp], xmm6                 ; 00C1 _ F3: 0F 7F. 34 24
        movdqu  xmmword ptr [rsp+10H], xmm7             ; 00C6 _ F3: 0F 7F. 7C 24, 10
        movdqu  xmmword ptr [rsp+20H], xmm8             ; 00CC _ F3 44: 0F 7F. 44 24, 20
        movdqu  xmmword ptr [rsp+30H], xmm9             ; 00D3 _ F3 44: 0F 7F. 4C 24, 30
        movdqu  xmmword ptr [rsp+40H], xmm10            ; 00DA _ F3 44: 0F 7F. 54 24, 40
        movdqu  xmmword ptr [rsp+50H], xmm11            ; 00E1 _ F3 44: 0F 7F. 5C 24, 50
        movdqu  xmmword ptr [rsp+60H], xmm12            ; 00E8 _ F3 44: 0F 7F. 64 24, 60
        movdqu  xmmword ptr [rsp+70H], xmm13            ; 00EF _ F3 44: 0F 7F. 6C 24, 70
        movdqu  xmmword ptr [rsp+80H], xmm14            ; 00F6 _ F3 44: 0F 7F. B4 24, 00000080
        movdqu  xmmword ptr [rsp+90H], xmm15            ; 0100 _ F3 44: 0F 7F. BC 24, 00000090
        mov     qword ptr [rcx], rsp                    ; 010A _ 48: 89. 21
        mov     rsp, rdx                                ; 010D _ 48: 89. D4
        movdqu  xmm6, xmmword ptr [rsp]                 ; 0110 _ F3: 0F 6F. 34 24
        movdqu  xmm7, xmmword ptr [rsp+10H]             ; 0115 _ F3: 0F 6F. 7C 24, 10
        movdqu  xmm8, xmmword ptr [rsp+20H]             ; 011B _ F3 44: 0F 6F. 44 24, 20
        movdqu  xmm9, xmmword ptr [rsp+30H]             ; 0122 _ F3 44: 0F 6F. 4C 24, 30
        movdqu  xmm10, xmmword ptr [rsp+40H]            ; 0129 _ F3 44: 0F 6F. 54 24, 40
        movdqu  xmm11, xmmword ptr [rsp+50H]            ; 0130 _ F3 44: 0F 6F. 5C 24, 50
        movdqu  xmm12, xmmword ptr [rsp+60H]            ; 0137 _ F3 44: 0F 6F. 64 24, 60
        movdqu  xmm13, xmmword ptr [rsp+70H]            ; 013E _ F3 44: 0F 6F. 6C 24, 70
        movdqu  xmm14, xmmword ptr [rsp+80H]            ; 0145 _ F3 44: 0F 6F. B4 24, 00000080
        movdqu  xmm15, xmmword ptr [rsp+90H]            ; 014F _ F3 44: 0F 6F. BC 24, 00000090
        add     rsp, 160                                ; 0159 _ 48: 81. C4, 000000A0
; Note: Address is not rip-relative
; Note: Absolute memory address without relocation
        mov     r10, qword ptr gs:[30H]                 ; 0160 _ 65 4C: 8B. 14 25, 00000030
        pop     [r10+1478H]                   ; 0169 _ 41: 8F. 82, 00001478
        pop     [r10+20H]                     ; 0170 _ 41: 8F. 42, 20
        pop     [r10+10H]                     ; 0174 _ 41: 8F. 42, 10
        pop     [r10+8H]                      ; 0178 _ 41: 8F. 42, 08
        pop     rsi                                     ; 017C _ 5E
        pop     rdi                                     ; 017D _ 5F
        pop     r15                                     ; 017E _ 41: 5F
        pop     r14                                     ; 0180 _ 41: 5E
        pop     r13                                     ; 0182 _ 41: 5D
        pop     r12                                     ; 0184 _ 41: 5C
        pop     rbx                                     ; 0186 _ 5B
        fldcw   word ptr [rsp+4H]                       ; 0187 _ D9. 6C 24, 04
        ldmxcsr dword ptr [rsp]                         ; 018B _ 0F AE. 14 24
        pop     rbp                                     ; 018F _ 5D
        pop     rbp                                     ; 0190 _ 5D
        ret                                             ; 0191 _ C3
asco_swap ENDP

END
