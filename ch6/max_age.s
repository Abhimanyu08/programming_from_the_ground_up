.include "record-def.s"
.include "linux.s"

.section .data
filename:
.ascii "test.dat\0"

.section .bss
.lcomm record_buffer, RECORD_SIZE

.section .text


.globl _start

_start:

movl %esp, %ebp
subl $8, %esp

#open the file test.dat
movl $SYS_OPEN, %eax
movl $filename, %ebx
movl $0, %ecx
movl $0666, %edx
int $LINUX_SYSCALL

movl %eax, -4 (%ebp)
movl $0, -8 (%ebp)

loop_start:

    pushl -4 (%ebp)
    pushl $record_buffer
    call read_record
    addl $8, %esp

    cmpl $RECORD_SIZE,%eax
    jl end_loop

    movl $RECORD_AGE, %ebx

    movl record_buffer(,%ebx, 1), %ecx
    cmpl -8 (%ebp),%ecx
    jle loop_start

    movl %ecx, -8 (%ebp)
    jmp loop_start

end_loop:
    movl $SYS_CLOSE, %eax
    movl -4 (%ebp), %ebx
    int $LINUX_SYSCALL
 

    movl -8 (%ebp), %ebx
    movl $SYS_EXIT, %eax
    int $LINUX_SYSCALL

   

exit:
    movl %ebp, %esp
    movl $SYS_EXIT, %eax
    int $LINUX_SYSCALL






    


