.section .data

.section .text


.globl square

.type square, @function

square:

	movl 4 (%esp), %eax
	imull %eax, %eax
	ret
