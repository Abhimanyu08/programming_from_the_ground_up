.section .data

list:
.long 1,2,3

.section .text

.globl _start


_start:

movl $list, %ebx

movl $1, %eax

int $0x80
