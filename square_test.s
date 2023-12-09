.section .data

inputs:
.long 2,3,4,5,6,7,8

outputs:
.long 4,9,16,9,36,49,64

length:
.long 7 

.extern square
.section .text


.globl _start

_start:

movl $0, %edi

jmp start_test_loop


start_test_loop:
	cmpl length, %edi
	je end_loop
	movl inputs(,%edi,4), %ebx
	pushl %ebx
	call square
	
	cmpl outputs(,%edi,4), %ebx
	cmpl %ebx, %eax
	jl test_fail_end
	jg test_fail_end
	incl %edi
	jmp start_test_loop

	end_loop:
		movl $0, %ebx
		movl $1, %eax
		int $0x80
	
	test_fail_end:
		movl $1, %ebx
		movl $1, %eax
		int $0x80

