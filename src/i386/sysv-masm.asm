; Disassembly of file: source.sysv.o
; Wed Jan  7 16:35:56 2026
; Type: ELF32
; Syntax: MASM/ML
; Instruction set: 80386

.386
option dotname
.model flat

public asco_init_internal
public asco_save
public asco_load


_text   SEGMENT BYTE PUBLIC 'CODE'                      ; section number 1

asco_init_internal PROC NEAR
        mov     eax, dword ptr [esp+4H]                 ; 0000 _ 8B. 44 24, 04
        mov     edx, dword ptr [esp+8H]                 ; 0004 _ 8B. 54 24, 08
        mov     dword ptr [eax], edx                    ; 0008 _ 89. 10
        mov     dword ptr [eax+4H], 0                   ; 000A _ C7. 40, 04, 00000000
        mov     edx, dword ptr [ebp+10H]                ; 0011 _ 8B. 55, 10
        sub     edx, 8                                  ; 0014 _ 83. EA, 08
        mov     dword ptr [edx], 0                      ; 0017 _ C7. 02, 00000000
        mov     ecx, dword ptr [esp+0CH]                ; 001D _ 8B. 4C 24, 0C
        mov     dword ptr [edx+4H], ecx                 ; 0021 _ 89. 4A, 04
        mov     dword ptr [eax+8H], edx                 ; 0024 _ 89. 50, 08
        ret                                             ; 0027 _ C3
asco_init_internal ENDP

asco_save PROC NEAR
        mov     eax, dword ptr [esp+4H]                 ; 0028 _ 8B. 44 24, 04
        pop     edx                                     ; 002C _ 5A
        mov     dword ptr [eax], edx                    ; 002D _ 89. 10
        mov     dword ptr [eax+4H], ebp                 ; 002F _ 89. 68, 04
        mov     dword ptr [eax+8H], esp                 ; 0032 _ 89. 60, 08
        mov     dword ptr [eax+0CH], ebx                ; 0035 _ 89. 58, 0C
        mov     dword ptr [eax+10H], edi                ; 0038 _ 89. 78, 10
        mov     dword ptr [eax+14H], esi                ; 003B _ 89. 70, 14
        mov     eax, 0                                  ; 003E _ B8, 00000000
        jmp     edx                                     ; 0043 _ FF. E2
asco_save ENDP

asco_load PROC NEAR
        mov     eax, dword ptr [esp+4H]                 ; 0045 _ 8B. 44 24, 04
        mov     edx, dword ptr [eax]                    ; 0049 _ 8B. 10
        mov     ebp, dword ptr [eax+4H]                 ; 004B _ 8B. 68, 04
        mov     esp, dword ptr [eax+8H]                 ; 004E _ 8B. 60, 08
        mov     ebx, dword ptr [eax+0CH]                ; 0051 _ 8B. 58, 0C
        mov     edi, dword ptr [eax+10H]                ; 0054 _ 8B. 78, 10
        mov     esi, dword ptr [eax+14H]                ; 0057 _ 8B. 70, 14
        mov     eax, 1                                  ; 005A _ B8, 00000001
        jmp     edx                                     ; 005F _ FF. E2
asco_load ENDP

_text   ENDS

_data   SEGMENT BYTE PUBLIC 'DATA'                      ; section number 2

_data   ENDS

.bss    SEGMENT BYTE PUBLIC 'BSS'                       ; section number 3

.bss    ENDS

.note.gnu.property SEGMENT DWORD PUBLIC 'CONST'         ; section number 4

        db 04H, 00H, 00H, 00H, 18H, 00H, 00H, 00H       ; 0000 _ ........
        db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H       ; 0008 _ ....GNU.
        db 02H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H      ; 0010 _ ........
        db 00H, 00H, 00H, 00H, 01H, 00H, 01H, 0C0H      ; 0018 _ ........
        db 04H, 00H, 00H, 00H, 01H, 00H, 00H, 00H       ; 0020 _ ........

.note.gnu.property ENDS

END