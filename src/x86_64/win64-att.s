.text
.global asco_init_internal
.global asco_save_internal
.global asco_load_internal
asco_init_internal:
 movq %rdx, (%rcx)
 movq $0, 0x8(%rcx)
 movq %r9, 0x10(%rcx)
 movl $0b1111110000000, 0x18(%rcx)
 movw $0x037F, 0x1c(%rcx)
 movq %r8, 0x20(%rcx)
 ret
asco_save_internal:
 pop %r11
 movq %r11, (%rcx)
 movq %rsp, 0x10(%rcx)
 push %r11
 movq %rbp, 0x8(%rcx)
 stmxcsr 0x18(%rcx)
 fstcw 0x1c(%rcx)
 movq %rbx, 0x20(%rcx)
 movq %r12, 0x28(%rcx)
 movq %r13, 0x30(%rcx)
 movq %r14, 0x38(%rcx)
 movq %r15, 0x40(%rcx)
 movq %rdi, 0x48(%rcx)
 movq %rsi, 0x50(%rcx)
 movdqu %xmm6, 0x58(%rcx)
 movdqu %xmm7, 0x68(%rcx)
 movdqu %xmm8, 0x78(%rcx)
 movdqu %xmm9, 0x88(%rcx)
 movdqu %xmm10, 0x98(%rcx)
 movdqu %xmm11, 0xa8(%rcx)
 movdqu %xmm12, 0xb8(%rcx)
 movdqu %xmm13, 0xc8(%rcx)
 movdqu %xmm14, 0xd8(%rcx)
 movdqu %xmm15, 0xe8(%rcx)
 xorl %eax, %eax
 ret
asco_load_internal:
 movq (%rcx), %r11
 movq 0x8(%rcx), %rbp
 movq 0x10(%rcx), %rsp
 ldmxcsr 0x18(%rcx)
 fclex
 fldcw 0x1c(%rcx)
 movq 0x20(%rcx), %rbx
 movq 0x28(%rcx), %r12
 movq 0x30(%rcx), %r13
 movq 0x38(%rcx), %r14
 movq 0x40(%rcx), %r15
 movq 0x48(%rcx), %rdi
 movq 0x50(%rcx), %rsi
 movdqu 0x58(%rcx), %xmm6
 movdqu 0x68(%rcx), %xmm7
 movdqu 0x78(%rcx), %xmm8
 movdqu 0x88(%rcx), %xmm9
 movdqu 0x98(%rcx), %xmm10
 movdqu 0xa8(%rcx), %xmm11
 movdqu 0xb8(%rcx), %xmm12
 movdqu 0xc8(%rcx), %xmm13
 movdqu 0xd8(%rcx), %xmm14
 movdqu 0xe8(%rcx), %xmm15
 movq %rbx, %rcx
 movl $1, %eax
 jmp *%r11
