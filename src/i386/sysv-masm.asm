; Disassembly of file: source.sysv.o
; Wed Jan  7 16:56:07 2026
; Type: ELF32
; Syntax: MASM/ML
; Instruction set: 80386

.386
option dotname
.model flat

public asco_init_internal
public asco_save_internal
public asco_load_internal


.code

asco_init_internal PROC NEAR
        mov     eax, dword ptr [esp+4H]                 ; 0000 _ 8B. 44 24, 04
        mov     edx, dword ptr [esp+8H]                 ; 0004 _ 8B. 54 24, 08
        mov     dword ptr [eax], edx                    ; 0008 _ 89. 10
        mov     dword ptr [eax+4H], 0                   ; 000A _ C7. 40, 04, 00000000
        mov     edx, dword ptr [esp+10H]                ; 0011 _ 8B. 54 24, 10
        sub     edx, 8                                  ; 0015 _ 83. EA, 08
        mov     dword ptr [edx], 0                      ; 0018 _ C7. 02, 00000000
        mov     ecx, dword ptr [esp+0CH]                ; 001E _ 8B. 4C 24, 0C
        mov     dword ptr [edx+4H], ecx                 ; 0022 _ 89. 4A, 04
        mov     dword ptr [eax+8H], edx                 ; 0025 _ 89. 50, 08
        ret                                             ; 0028 _ C3
asco_init_internal ENDP

asco_save_internal PROC NEAR
        mov     eax, dword ptr [esp+4H]                 ; 0029 _ 8B. 44 24, 04
        pop     edx                                     ; 002D _ 5A
        mov     dword ptr [eax], edx                    ; 002E _ 89. 10
        mov     dword ptr [eax+4H], ebp                 ; 0030 _ 89. 68, 04
        mov     dword ptr [eax+8H], esp                 ; 0033 _ 89. 60, 08
        mov     dword ptr [eax+0CH], ebx                ; 0036 _ 89. 58, 0C
        mov     dword ptr [eax+10H], edi                ; 0039 _ 89. 78, 10
        mov     dword ptr [eax+14H], esi                ; 003C _ 89. 70, 14
        mov     eax, 0                                  ; 003F _ B8, 00000000
        jmp     edx                                     ; 0044 _ FF. E2
asco_save_internal ENDP

asco_load_internal PROC NEAR
        mov     eax, dword ptr [esp+4H]                 ; 0046 _ 8B. 44 24, 04
        mov     edx, dword ptr [eax]                    ; 004A _ 8B. 10
        mov     ebp, dword ptr [eax+4H]                 ; 004C _ 8B. 68, 04
        mov     esp, dword ptr [eax+8H]                 ; 004F _ 8B. 60, 08
        mov     ebx, dword ptr [eax+0CH]                ; 0052 _ 8B. 58, 0C
        mov     edi, dword ptr [eax+10H]                ; 0055 _ 8B. 78, 10
        mov     esi, dword ptr [eax+14H]                ; 0058 _ 8B. 70, 14
        mov     eax, 1                                  ; 005B _ B8, 00000001
        jmp     edx                                     ; 0060 _ FF. E2
asco_load_internal ENDP


END
