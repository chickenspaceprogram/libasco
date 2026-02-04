.text
.global asco_init_routine
.global asco_swap
asco_init_routine:
 mov %rbx, %rcx
 call *%r12
 mov (%r13), %rsp
 ldmxcsr (%rsp)
 fldcw 4(%rsp)
 movq 8(%rsp), %rbp
 movq 0x10(%rsp), %rbx
 movq 0x18(%rsp), %r12
 movq 0x20(%rsp), %r13
 movq 0x28(%rsp), %r14
 movq 0x30(%rsp), %r15
 movq 0x38(%rsp), %rdi
 movq %gs:(0x30), %r10
 movq 0x40(%rsp), %r11
 movq %r11, 0x08(%r10)
 movq 0x48(%rsp), %r11
 movq %r11, 0x10(%r10)
 movq 0x50(%rsp), %r11
 movq %r11, 0x20(%r10)
 movq 0x58(%rsp), %r11
 movq %r11, 0x1478(%r10)
 movdqu 0x60(%rsp), %xmm6
 movdqu 0x70(%rsp), %xmm7
 movdqu 0x80(%rsp), %xmm8
 movdqu 0x90(%rsp), %xmm9
 movdqu 0xa0(%rsp), %xmm10
 movdqu 0xb0(%rsp), %xmm11
 movdqu 0xc0(%rsp), %xmm12
 movdqu 0xd0(%rsp), %xmm13
 movdqu 0xe0(%rsp), %xmm14
 movdqu 0xf0(%rsp), %xmm15
 movq 0x100(%rsp), %rsi
 leaq 0x108(%rsp), %rsp
 ret
asco_swap:
 leaq -0x108(%rsp), %rsp
 stmxcsr (%rsp)
 fstcw 4(%rsp)
 movq %rbp, 0x08(%rsp)
 movq %rbx, 0x10(%rsp)
 movq %r12, 0x18(%rsp)
 movq %r13, 0x20(%rsp)
 movq %r14, 0x28(%rsp)
 movq %r15, 0x30(%rsp)
 movq %rdi, 0x38(%rsp)
 movq %gs:(0x30), %r10
 movq 0x08(%r10), %r11
 movq %r11, 0x40(%rsp)
 movq 0x10(%r10), %r11
 movq %r11, 0x48(%rsp)
 movq 0x20(%r10), %r11
 movq %r11, 0x50(%rsp)
 movq 0x1478(%r10), %r11
 movq %r11, 0x58(%rsp)
 movdqu %xmm6, 0x60(%rsp)
 movdqu %xmm7, 0x70(%rsp)
 movdqu %xmm8, 0x80(%rsp)
 movdqu %xmm9, 0x90(%rsp)
 movdqu %xmm10, 0xa0(%rsp)
 movdqu %xmm11, 0xb0(%rsp)
 movdqu %xmm12, 0xc0(%rsp)
 movdqu %xmm13, 0xd0(%rsp)
 movdqu %xmm14, 0xe0(%rsp)
 movdqu %xmm15, 0xf0(%rsp)
 movq %rsi, 0x100(%rsp)
 movq %rsp, (%rcx)
 movq %rdx, %rsp
 ldmxcsr (%rsp)
 fldcw 4(%rsp)
 movq 8(%rsp), %rbp
 movq 0x10(%rsp), %rbx
 movq 0x18(%rsp), %r12
 movq 0x20(%rsp), %r13
 movq 0x28(%rsp), %r14
 movq 0x30(%rsp), %r15
 movq 0x38(%rsp), %rdi
 movq %gs:(0x30), %r10
 movq 0x40(%rsp), %r11
 movq %r11, 0x08(%r10)
 movq 0x48(%rsp), %r11
 movq %r11, 0x10(%r10)
 movq 0x50(%rsp), %r11
 movq %r11, 0x20(%r10)
 movq 0x58(%rsp), %r11
 movq %r11, 0x1478(%r10)
 movdqu 0x60(%rsp), %xmm6
 movdqu 0x70(%rsp), %xmm7
 movdqu 0x80(%rsp), %xmm8
 movdqu 0x90(%rsp), %xmm9
 movdqu 0xa0(%rsp), %xmm10
 movdqu 0xb0(%rsp), %xmm11
 movdqu 0xc0(%rsp), %xmm12
 movdqu 0xd0(%rsp), %xmm13
 movdqu 0xe0(%rsp), %xmm14
 movdqu 0xf0(%rsp), %xmm15
 movq 0x100(%rsp), %rsi
 leaq 0x108(%rsp), %rsp
 ret
