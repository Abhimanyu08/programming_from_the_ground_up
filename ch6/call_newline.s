.include "linux.s"
.section .data


text:
.ascii "hello"

.section .text


.globl _start

_start:

    pushl $5
    pushl $text


    call write_newline

    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $text, %ecx
    movl $6, %edx

    int $LINUX_SYSCALL

    movl $1, %eax
    movl $0, %ebx

    int $LINUX_SYSCALL
