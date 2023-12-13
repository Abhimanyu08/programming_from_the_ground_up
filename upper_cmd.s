#This program converts all the characters in a given file to uppercase and displays the text inside terminal


.section .data

.section .bss

.equ BUFFER_SIZE, 10
.lcomm BUFFER_DATA, BUFFER_SIZE


.section .text

.globl _start
_start:

#first we'll try and open the file

read_file:


movl $3, %eax #read system call in %eax
movl $0, %ebx #read system call requires the file descriptor to be stored in %ebx. We are reading from STDIN which has file descriptor 0
movl $BUFFER_DATA, %ecx #read system call requires the memory location where it should put the data that it has read to be stored in %ecx
movl $BUFFER_SIZE, %edx #read system call requires the amount of data to be read to be stored in %edx

int $0x80

#after read system call is finished it stores the number of bytes read in %eax. If it's <= 0, we've reached the end of file
cmpl $0, %eax
jle end


write_to_stdout:

movl %eax,%edx #move the number of bytes read to %edx

pushl %edx
pushl $BUFFER_DATA
call convert_to_upper
addl $4, %esp
popl %edx


movl $4, %eax #write system call
movl $1, %ebx #we store the file desriptor we want to write to in %ebx. We want to write to STDOUT which has file descriptor 1 by default
movl $BUFFER_DATA, %ecx #write system call requires the address of the data to be written should be stored in %ecx
int $0x80

jmp read_file


end: 

#---exit----
movl $1, %eax 
movl $0, %ebx
int $0x80


.type convert_to_upper, @function

#this function will need to two parameters:
# 1. the address to the buffer where the data is
# 2. the length of the buffer
convert_to_upper:

.equ LOWERCASE_A, 'a'
.equ LOWERCASE_Z, 'z'
.equ UPPER_DIST, 'A' - 'a'
pushl %ebp
movl %esp, %ebp

movl $-1, %edi
movl 8(%ebp), %eax #address of the start of the buffer
movl 12(%ebp), %ebx #length of the buffer


loop_begin:
incl %edi
cmpl %ebx, %edi
je loop_end

movb (%eax, %edi, 1), %cl

cmpb $LOWERCASE_A, %cl
jl loop_begin

cmpb $LOWERCASE_Z, %cl
jg loop_begin


addb $UPPER_DIST, %cl
movb %cl, (%eax,%edi,1)
jmp loop_begin


loop_end:
movl %ebp,%esp
popl %ebp
ret
