# There need to be made some rules for function calling otherwise large programs might spiral out of control
# 1. Every function will put it's return in value in %eax register
# 2. After any function is called and has returned we need to remove it's parameters from call stack
# 3. We can't rely on just the %esp register to get the parameters off the top of stack because it can change (for eg. if we decide to call another function inside a function we will push the parameters on top or we can reserve extra space for local variables by subl $8, %esp), therefore we'll point %ebp register to the top of stack.
# 4. We can't use registers to store local variables because they should be free for use for any other function we might call



.section .data

.section .text

.globl _start

_start:

pushl $2
pushl $3

call power #at this point return address was pushed to the top of stack

addl $8, %esp #remove the parameters of power from the top of stack

movl %eax, %ebx #move the result to %ebx

movl $1, %eax #prepare to call exit system call

int $0x80

#exponent would be at the top of the stack
#base would be second item of the stack
.type power, @function

power:
	#first we need to put the old base pointer at the top of stack
	pushl %ebp
	#now we need to point the new base pointer to the top of the stack
	movl %esp, %ebp
	#now we'll reserve 2 words for local variables	
	subl $8, %esp
	#we'll store current power in -8 (%ebp) and current result in -4 (%ebp)
	movl 8(%ebp), -8(%ebp) 
	movl 12(%ebp), -4(%ebp) #stack looks like this rn: 3, 2, old bp, retun addr, 3, 2
	jmp power_loop_start

	power_loop_start:
		cmpl -8(%ebp), $1
		je power_loop_end

		#prepare to call multiply
		pushl -4(%ebp)
		pushl 12(%ebp)
		call multiply
		addl $8, %esp #remove the parameters of multiply from the top of stack
		#result of multiply is in %eax
		movl %eax, -4(%ebp)
		subl $1, -8(%esp)
	
	power_loop_end:
		movl -4(%ebp), %eax #stores the result in %eax register
		movl %ebp, %esp #remove the space reserved for local variables. Now at the top of stack is the old base pointer i.e value of base pointer before calling the power function
		popl %ebp #restore the old base pointer
		ret

	
.type multiply, @function
multiply:

	movl 4(%esp), %eax
	movl 8(%esp), %ebx

	imull %ebx, %eax
	ret

