# this program uses a length count rather than the number 0 in the list to know when to stop. Problem No 5 in "Use the concepts" section on page number 52 of pftgu

.section .data

list:
.long 12,40,10,3,4,7,30

length:
.long 7

.section .text

.globl _start

_start:


movl $0, %eax #we keep track of current index in %eax. 0 at the start

movl list(,%eax,4), %ecx  # we keep track of current list[index] in %ecx.this is indexed addressing mode. One thing I noticed is you can't just say list(,$0,4), your index needs to be in a register.
movl %ecx, %ebx # We keep track of maximum till now in %ebx. It's the list's first item at the start

start_loop:
incl %eax 
cmpl length, %eax

je end_loop

movl list(,%eax,4), %ecx 
je end_loop
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
