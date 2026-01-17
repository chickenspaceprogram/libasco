; Disassembly of file: source.win.o
; Sat Jan 17 13:10:32 2026
; Type: ELF64
; Syntax: MASM/ML64
; Instruction set: SSE, x64, 80x87
option dotname

public asco_init_routine
public asco_swap


_text   SEGMENT BYTE 'CODE'                             ; section number 1

asco_init_routine PROC
        mov     rcx, rbx                                ; 0000 _ 48: 89. D9
        call    r12                                     ; 0003 _ 41: FF. D4
        mov     rsp, qword ptr [r13]                    ; 0006 _ 49: 8B. 65, 00
        pop     r15                                     ; 000A _ 41: 5F
        pop     r14                                     ; 000C _ 41: 5E
        pop     r13                                     ; 000E _ 41: 5D
        pop     r12                                     ; 0010 _ 41: 5C
        pop     rbx                                     ; 0012 _ 5B
        fldcw   word ptr [rsp+4H]                       ; 0013 _ D9. 6C 24, 04
        ldmxcsr dword ptr [rsp]                         ; 0017 _ 0F AE. 14 24
        pop     rbp                                     ; 001B _ 5D
        pop     rbp                                     ; 001C _ 5D
        ret                                             ; 001D _ C3
asco_init_routine ENDP

asco_swap PROC
        push    rbp                                     ; 001E _ 55
        push    rbp                                     ; 001F _ 55
        stmxcsr dword ptr [rsp]                         ; 0020 _ 0F AE. 1C 24
        fwait                                           ; 0024 _ 9B
        fnstcw  word ptr [rsp+4H]                       ; 0025 _ D9. 7C 24, 04
        push    rbx                                     ; 0029 _ 53
        push    r12                                     ; 002A _ 41: 54
        push    r13                                     ; 002C _ 41: 55
        push    r14                                     ; 002E _ 41: 56
        push    r15                                     ; 0030 _ 41: 57
        mov     qword ptr [rcx], rsp                    ; 0032 _ 48: 89. 21
        mov     rsp, rdx                                ; 0035 _ 48: 89. D4
        pop     r15                                     ; 0038 _ 41: 5F
        pop     r14                                     ; 003A _ 41: 5E
        pop     r13                                     ; 003C _ 41: 5D
        pop     r12                                     ; 003E _ 41: 5C
        pop     rbx                                     ; 0040 _ 5B
        fldcw   word ptr [rsp+4H]                       ; 0041 _ D9. 6C 24, 04
        ldmxcsr dword ptr [rsp]                         ; 0045 _ 0F AE. 14 24
        pop     rbp                                     ; 0049 _ 5D
        pop     rbp                                     ; 004A _ 5D
        ret                                             ; 004B _ C3
asco_swap ENDP

_text   ENDS

_data   SEGMENT BYTE 'DATA'                             ; section number 2

_data   ENDS

.bss    SEGMENT BYTE 'BSS'                              ; section number 3

.bss    ENDS

.note.gnu.property SEGMENT ALIGN(8) 'CONST'             ; section number 4

        db 04H, 00H, 00H, 00H, 20H, 00H, 00H, 00H       ; 0000 _ .... ...
        db 05H, 00H, 00H, 00H, 47H, 4EH, 55H, 00H       ; 0008 _ ....GNU.
        db 02H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H      ; 0010 _ ........
        db 01H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 0018 _ ........
        db 01H, 00H, 01H, 0C0H, 04H, 00H, 00H, 00H      ; 0020 _ ........
        db 09H, 00H, 00H, 00H, 00H, 00H, 00H, 00H       ; 0028 _ ........

.note.gnu.property ENDS

END