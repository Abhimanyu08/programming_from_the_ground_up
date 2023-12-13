#This file includes two functions which can read and write a record to a file
# They take the following arguments
# - The address of the buffer where the record should be read to
# - The file descriptor from which to read or write
.include "record-def.s"
.include "linux.s"


.equ ST_READ_BUFFER,8 #the buffer address will be the first argument
.equ ST_FILEDES, 12 #the file descriptor will be the second

.section .text
.globl read_record

.type read_record, @function

read_record:
    
    pushl %ebp
    movl %esp, %ebp

    pushl %ebx #we are going to be using %ebx in this function so we are storing it's previous value on to the stack so that we can recover it

    movl $SYS_READ, %eax
    movl ST_FILEDES(%ebp), %ebx
    movl ST_READ_BUFFER(%ebp), %ecx
    movl $RECORD_SIZE, %edx
    int $LINUX_SYSCALL

    #no of bytes read is stored in the %eax

    popl %ebx
    movl %ebp, %esp
    popl %ebp
    ret

    
