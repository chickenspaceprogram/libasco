; Disassembly of file: source.sysv.o
; Wed Jan  7 16:56:07 2026
; Type: ELF32
; Syntax: NASM
; Instruction set: 80386


global asco_init_internal
global asco_save
global asco_load


SECTION .text   align=1 exec                            ; section number 1, code

asco_init_internal:; Function begin
        mov     eax, dword [esp+4H]                     ; 0000 _ 8B. 44 24, 04
        mov     edx, dword [esp+8H]                     ; 0004 _ 8B. 54 24, 08
        mov     dword [eax], edx                        ; 0008 _ 89. 10
        mov     dword [eax+4H], 0                       ; 000A _ C7. 40, 04, 00000000
        mov     edx, dword [esp+10H]                    ; 0011 _ 8B. 54 24, 10
        sub     edx, 8                                  ; 0015 _ 83. EA, 08
        mov     dword [edx], 0                          ; 0018 _ C7. 02, 00000000
        mov     ecx, dword [esp+0CH]                    ; 001E _ 8B. 4C 24, 0C
        mov     dword [edx+4H], ecx                     ; 0022 _ 89. 4A, 04
        mov     dword [eax+8H], edx                     ; 0025 _ 89. 50, 08
        ret                                             ; 0028 _ C3
; asco_init_internal End of function

asco_save:; Function begin
        mov     eax, dword [esp+4H]                     ; 0029 _ 8B. 44 24, 04
        pop     edx                                     ; 002D _ 5A
        mov     dword [eax], edx                        ; 002E _ 89. 10
        mov     dword [eax+4H], ebp                     ; 0030 _ 89. 68, 04
        mov     dword [eax+8H], esp                     ; 0033 _ 89. 60, 08
        mov     dword [eax+0CH], ebx                    ; 0036 _ 89. 58, 0C
        mov     dword [eax+10H], edi                    ; 0039 _ 89. 78, 10
        mov     dword [eax+14H], esi                    ; 003C _ 89. 70, 14
        mov     eax, 0                                  ; 003F _ B8, 00000000
        jmp     edx                                     ; 0044 _ FF. E2
; asco_save End of function

asco_load:; Function begin
        mov     eax, dword [esp+4H]                     ; 0046 _ 8B. 44 24, 04
        mov     edx, dword [eax]                        ; 004A _ 8B. 10
        mov     ebp, dword [eax+4H]                     ; 004C _ 8B. 68, 04
        mov     esp, dword [eax+8H]                     ; 004F _ 8B. 60, 08
        mov     ebx, dword [eax+0CH]                    ; 0052 _ 8B. 58, 0C
        mov     edi, dword [eax+10H]                    ; 0055 _ 8B. 78, 10
        mov     esi, dword [eax+14H]                    ; 0058 _ 8B. 70, 14
        mov     eax, 1                                  ; 005B _ B8, 00000001
        jmp     edx                                     ; 0060 _ FF. E2
; asco_load End of function


SECTION .data   align=1 noexec                          ; section number 2, data


SECTION .bss    align=1 noexec                          ; section number 3, bss


SECTION .note.gnu.property align=4 noexec               ; section number 4, const

        db 04H, 00H, 00H, 00H, 18H, 00H, 00H, 00H       ; 0000 _ ........
        db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H       ; 0008 _ ....GNU.
        db 02H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H      ; 0010 _ ........
        db 00H, 00H, 00H, 00H, 01H, 00H, 01H, 0C0H      ; 0018 _ ........
        db 04H, 00H, 00H, 00H, 01H, 00H, 00H, 00H       ; 0020 _ ........


