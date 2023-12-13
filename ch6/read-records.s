
.include "linux.s"
.include "record-def.s"


.section .data

.lcomm record_buffer, RECORD_SIZE
filename:
.ascii "test.dat\0"

.section .text


.globl _start

_start:



pushl %ebp
movl %esp, %ebp

subl $8, %esp

movl $SYS_OPEN, %eax
movl $filename, %ebx
movl $0, %ecx #read only mode
movl $0666, %edx
int $LINUX_SYSCALL

movl %eax, -4 (%ebp)



read_loop_begin: 

#---------------------------Read the record------------------
pushl -4 (%ebp) #push file descriptor 
pushl $record_buffer #push buffer to read the record into
call read_record
addl $8, %esp


# if no of bytes read < record size, we have finished reading
cmpl $RECORD_SIZE, %eax
jne finished_reading


#----------count the length of first name----------------
pushl $record_buffer
call count_chars
addl $4, %esp

#------Add newline character to first name
movl %eax, -8(%ebp)
pushl %eax #length of buffer
pushl $record_buffer #address tostart of buffer
call write_newline
addl $8, %esp

#---------------print the first name to STDOUT-------------




movl -8(%ebp), %edx #move the no of bytes of first name to %edx
incl %edx #increment because we added a newline

movl $SYS_WRITE, %eax
movl $STDOUT, %ebx
movl $record_buffer, %ecx

int $LINUX_SYSCALL
jmp read_loop_begin



finished_reading:

movl %ebp, %esp
popl %ebp

movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL





    













