.section .data

.section .text

.globl _start

_start:

	pushl $5
	call factorial

	addl $4, %esp
	movl %eax, %ebx
	movl $1, %eax

	int $0x80

.type factorial, @function

factorial:
	pushl %ebp #push old base pointer at the top of stack
	movl %esp, %ebp #point new base pointer to the top of stack

	movl 8 (%ebp), %eax #move the argument to factorial into eax
	cmpl $1, %eax #if argument is 1 jump to factorial end 
	je factorial_end
	subl $1, %eax
	pushl %eax

	call factorial

	imull 8 (%ebp), %eax
	jmp factorial_end

	factorial_end:
		movl %ebp, %esp
		popl %ebp
		ret






