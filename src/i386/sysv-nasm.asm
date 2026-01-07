; Disassembly of file: source.sysv.o
; Wed Jan  7 02:45:11 2026
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
        mov     edx, dword [ebp+10H]                    ; 0011 _ 8B. 55, 10
        sub     edx, 8                                  ; 0014 _ 83. EA, 08
        mov     dword [edx], 0                          ; 0017 _ C7. 02, 00000000
        mov     ecx, dword [esp+0CH]                    ; 001D _ 8B. 4C 24, 0C
        mov     dword [edx+4H], ecx                     ; 0021 _ 89. 4A, 04
        mov     dword [eax+8H], edx                     ; 0024 _ 89. 50, 08
        ret                                             ; 0027 _ C3
; asco_init_internal End of function

asco_save:; Function begin
        pop     edx                                     ; 0028 _ 5A
        mov     dword [eax], edx                        ; 0029 _ 89. 10
        mov     eax, dword [esp]                        ; 002B _ 8B. 04 24
        mov     dword [eax+4H], ebp                     ; 002E _ 89. 68, 04
        mov     dword [eax+8H], esp                     ; 0031 _ 89. 60, 08
        mov     dword [eax+0CH], ebx                    ; 0034 _ 89. 58, 0C
        mov     dword [eax+10H], edi                    ; 0037 _ 89. 78, 10
        mov     dword [eax+14H], esi                    ; 003A _ 89. 70, 14
        mov     eax, 0                                  ; 003D _ B8, 00000000
        jmp     edx                                     ; 0042 _ FF. E2
; asco_save End of function

asco_load:; Function begin
        mov     eax, dword [esp+4H]                     ; 0044 _ 8B. 44 24, 04
        mov     edx, dword [eax]                        ; 0048 _ 8B. 10
        mov     ebp, dword [eax+4H]                     ; 004A _ 8B. 68, 04
        mov     esp, dword [eax+8H]                     ; 004D _ 8B. 60, 08
        mov     ebx, dword [eax+0CH]                    ; 0050 _ 8B. 58, 0C
        mov     edi, dword [eax+10H]                    ; 0053 _ 8B. 78, 10
        mov     esi, dword [eax+14H]                    ; 0056 _ 8B. 70, 14
        mov     eax, 1                                  ; 0059 _ B8, 00000001
        jmp     edx                                     ; 005E _ FF. E2
; asco_load End of function


SECTION .data   align=1 noexec                          ; section number 2, data


SECTION .bss    align=1 noexec                          ; section number 3, bss


SECTION .note.gnu.property align=4 noexec               ; section number 4, const

        db 04H, 00H, 00H, 00H, 18H, 00H, 00H, 00H       ; 0000 _ ........
        db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H       ; 0008 _ ....GNU.
        db 02H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H      ; 0010 _ ........
        db 00H, 00H, 00H, 00H, 01H, 00H, 01H, 0C0H      ; 0018 _ ........
        db 04H, 00H, 00H, 00H, 01H, 00H, 00H, 00H       ; 0020 _ ........


