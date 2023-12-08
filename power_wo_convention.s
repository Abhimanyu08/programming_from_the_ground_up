.section .data

.section .text



.globl _start


_start:

pushl $2

pushl $3

call power

movl $1, %eax

int $0x80

.type power, @function

power:


movl 8 (%esp), %ebx #2
movl %ebx, %ecx 
movl 4 (%esp), %edx #3
jmp power_loop

power_loop:

cmpl $1, %edx
je power_end
pushl %ebx
pushl %ecx

call multiply

addl $8, %esp 

subl $1, %edx

jmp power_loop

power_end:
movl %ecx, %ebx
ret

.type multiply, @function

multiply:

movl 4 (%esp), %ecx

imull 8 (%esp), %ecx
ret
