.section .data

list:
.long 12,20,10,3,4,7,0

.section .text

.globl _start

_start:



pushl $7
pushl $list
call max_list


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

	movl $0, %edi #%edi will store the current index
	movl 8 (%ebp), %ebx #address to the start of the list
	movl (%ebx), %eax
	movl %eax, -4 (%ebp) #local variable stores max till now which is the first element in list at the start

	jmp start_loop

	start_loop:
		movl 12 (%ebp), %ebx  #move length of list to %ebx
		imull $4, %ebx #multiply length by 4
		cmpl %ebx, %edi #if equal end
		je loop_end

		
		movl 8 (%ebp), %ebx #move address to start of list into %ebx
		movl %edi (%ebx), %eax #move first item to %eax
		cmpl %eax, -4 (%ebp)
		jge start_loop

		movl %eax, -4 (%ebp)
		addl $4, %edi
		jmp start_loop

	loop_end:
		movl -4 (%ebp), %eax
		movl %ebp, %esp
		popl %ebp
		ret






