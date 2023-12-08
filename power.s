.section .data
.section .text
.globl _start
_start:
# this function computes 2^3 + 3^4. We'll calculate power using a function 
# which takes the two numbers as parameters.



pushl $2
pushl $3
#the line below automatically pushes the address of the next instruction to the top of stack.
call power

#at the end of function call we need to deallocate memory taken for these two parameters
addl $8, %esp
pushl %eax

pushl $3
pushl $4

call power 
addl $8, %esp

popl %ebx

addl %eax, %ebx

exit:
movl $1, %eax
int $0x80


.type power, @function
power:
#we need to save the current base pointer value at the top of stack
pushl %ebp
#Now, we can safely save the address of top of stack in the ebp. can't rely #on esp since it may change during execution
movl %esp,%ebp

movl 12 (%ebp), %ebx #this is currently 2
movl 8 (%ebp), %ecx #this is currently 3

subl $4, %esp #make space for 32 bit local variable
movl %ebx, -4 (%ebp)

start_loop:
cmpl $1, %ecx #if power is 1 we store our answer in after %ebp
je loop_exit

cmpl $1, %ebx #if exponent is 1 answer is 1 
je loop_exit

movl -4 (%ebp), %eax
imull %ebx, %eax
movl %eax, -4 (%ebp)


decl %ecx
jmp start_loop


loop_exit:
#move the top of stack to base pointer to get rid of local variables
movl -4 (%ebp), %eax
movl %ebp, %esp
popl %ebp #load to old valueof ebp into base pointer, also stack pointer points at return address now
ret






