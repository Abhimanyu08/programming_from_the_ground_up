.section .data


.section .text

.globl _start

_start:

pushl $4
call factorial

addl $4, %esp
movl %eax, %ebx
movl $1, %eax

int $0x80

.type factorial, @function

pushl %ebp #push old base pointer at the top of stack
movl %esp, %ebp #point new base pointer to the top of stack

movl 8 (%ebp), %ebx #move the argument to factorial into ebx
cmpl %ebx, $1 #if argument is 1 jump to factorial end 
je factorial_end
subl $1, %ebx
pushl %ebx

call factorial

imull 8 (%ebp), %eax
ret

factorial_end:
popl %ebp
movl %ebx, %eax	
ret






