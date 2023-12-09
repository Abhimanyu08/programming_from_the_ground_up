
.section .data

list:
.long 12,20,10,30,4,7,0

.section .text

.globl _start

_start:



pushl $7
pushl $list
call max_list

addl $8, %esp

jmp end

end:
movl %eax, %ebx
movl $1, %eax
int $0x80


#this function takes two arguments:
# - address of the list whose max we need to find
# - length of the list
.type max_list, @function
max_list:

	pushl %ebp	#stack the old base pointer
	movl %esp, %ebp #point new base pointer to top of stack
	subl $4, %esp #local variable which'll store current max value

	movl $-4, %edi #%edi will store the current index
	movl 8 (%ebp), %ebx #address to the start of the list
	movl (%ebx), %eax
	movl %eax, -4 (%ebp) #local variable stores max till now which is the first element in list at the start

	jmp start_loop

	start_loop:
		movl 12 (%ebp), %ebx  #move length of list to %ebx
		imull $4, %ebx #multiply length by 4
		addl $4, %edi
		cmpl %ebx, %edi #if equal end
		je loop_end

		
		movl 8 (%ebp), %ebx #move address to start of list into %ebx
		addl %edi, %ebx
		movl (%ebx), %eax #move current item to %eax
		cmpl -4 (%ebp), %eax
		jle start_loop


		movl %eax, -4 (%ebp)
		jmp start_loop

	loop_end:
		movl -4 (%ebp), %eax
		movl %ebp, %esp
		popl %ebp
		ret


end_test:
	movl $1, %eax
	int $0x80


