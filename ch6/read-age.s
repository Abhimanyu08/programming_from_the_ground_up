#this program is to be done later because I don't know how to print numbers to STDOUT

.include "linux.s"
.include "record-def.s"

.section .data

.section .bss
.lcomm record_buffer, RECORD_SIZE


.section .text


.globl _start

_start:

    movl %esp, %ebp
    subl $4, %esp

    
    #---Open the file--
    movl $SYS_OPEN, %eax 
    movl 8(%ebp), %ebx
    movl $0, %ecx
    movl $0666, %edx
    int $LINUX_SYSCALL

    
    #read the records
    loop_begin
    pushl %eax 
    pushl $record_buffer
    call read_record
    addl $8, %esp





