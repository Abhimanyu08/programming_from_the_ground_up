.section .data
.section .text
.globl _start

_start:

end:
movl $1, %eax # this is the linux kernel command
# number (system call) for exiting
# a program
movl $5, %ebx # this is the status number we will
# return to the operating system.
# Change this around and it will
# return different things to
# echo $?
int $0x80
