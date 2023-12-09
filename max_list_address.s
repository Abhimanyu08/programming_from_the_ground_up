# this program uses an ending address to know when to stop scanning the list. Problem no 4 in "Use the concepts" of pftgu page 52

.section .data

list:
.long 12,40,10,3,4,7,30


.section .text

.globl _start

_start:


movl $list , %eax #we move the starting address into the %eax register
movl %eax, %edx
addl $28, %edx #we'll keep ending address inside the %edx. in this case we'll stop after having read 7 longs (4 bytes each) starting at list

movl (%eax), %ecx  #this is indirect addressing mode
movl %ecx, %ebx # We keep track of maximum till now in %ebx. It's the list's first item at the start

start_loop:
addl $4, %eax 
cmpl %edx, %eax
je end_loop

movl (%eax), %ecx 
cmpl %ebx, %ecx
jle start_loop

movl %ecx, %ebx
jmp start_loop

end_loop:
movl $1, %eax

int $0x80


# to find the maximum in the list we need to keep track of 
# - current index we are at - %eax
# - maximum till now - %ebx
# - current list[index] - %ecx
