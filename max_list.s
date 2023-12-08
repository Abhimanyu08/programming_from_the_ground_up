.section .data

list:
.long 12,20,10,3,4,7,0

.section .text

.globl _start

_start:


movl $0, %eax #we keep track of current index in %eax. 0 at the start

movl list(,%eax,4), %ecx  # we keep track of current list[index] in %ecx.this is indexed addressing mode. One thing I noticed is you can't just say list(,$0,4), your index needs to be in a register.
movl %ecx, %ebx # We keep track of maximum till now in %ebx. It's the list's first item at the start

start_loop:
incl %eax 
movl list(,%eax,4), %ecx 
cmpl $0, %ecx
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
