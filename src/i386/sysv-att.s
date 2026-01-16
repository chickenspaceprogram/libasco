.section .note.GNU-stack,"",@progbits
.text
.global asco_init_internal
.global asco_save_internal
.global asco_load
asco_init_internal:
 movl 4(%esp), %eax
 movl 8(%esp), %edx
 movl %edx, (%eax)
 movl $0, 4(%eax)
 movl 16(%esp), %edx
 sub $8, %edx
 movl $0, (%edx)
 movl 12(%esp), %ecx
 movl %ecx, 4(%edx)
 movl %edx, 8(%eax)
 ret
asco_save_internal:
 movl 4(%esp), %eax
 popl %edx
 movl %edx, (%eax)
 movl %ebp, 4(%eax)
 movl %esp, 8(%eax)
 movl %ebx, 12(%eax)
 movl %edi, 16(%eax)
 movl %esi, 20(%eax)
 movl $0, %eax
 jmp *%edx
asco_load_internal:
 movl 4(%esp), %eax
 movl (%eax), %edx
 movl 4(%eax), %ebp
 movl 8(%eax), %esp
 movl 12(%eax), %ebx
 movl 16(%eax), %edi
 movl 20(%eax), %esi
 movl $1, %eax
 jmp *%edx
