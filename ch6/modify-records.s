# The purpose of this program is to modify the records stored in test.dat. It'll read every record, increment the age, and write the data to an output file


.include "linux.s"
.include "record-def.s"


.section .data

outfile:
.ascii "output.dat\0"

inpfile:
.ascii "test.dat\0"

.section .bss
.lcomm record_buffer, RECORD_SIZE

.section .text

.globl _start
_start:

    movl %esp, %ebp
    subl $8, %esp

    #----Open the file-----------
    movl $SYS_OPEN, %eax
    movl $inpfile, %ebx 
    movl $0, %ecx
    movl $0666, %edx
    int $LINUX_SYSCALL #file descriptor now is in %eax

    movl %eax, -4(%ebp)
    #---------open the output file------
    movl $SYS_OPEN, %eax
    movl $outfile, %ebx 
    movl $0101, %ecx
    movl $0666, %edx
    int $LINUX_SYSCALL #file descriptor now is in %eax

    movl %eax, -8(%ebp)



    #----------Reading the file one record at a time-------- 
    loop_begin:
    pushl -4(%ebp)
    pushl $record_buffer
    call read_record
    addl $8, %esp

    cmpl $RECORD_SIZE, %eax
    jne loop_end

    ##modify record buffer - increase the age by 1
    movl $RECORD_AGE,%eax
    movl $record_buffer, %ebx
    movl (%ebx,%eax,4), %ecx 
    incl %ecx
    movl %ecx, (%ebx,%eax,4)

    ##now write this record buffer to output file
    
    pushl -8(%ebp)
    pushl $record_buffer
    call write_record
    addl $8, %esp

    jmp loop_begin


    loop_end:
    # close the input file
    movl $SYS_CLOSE, %eax
    movl -4 (%ebp), %ebx
    int $LINUX_SYSCALL

    #close the output file
    movl $SYS_CLOSE, %eax
    movl -4 (%ebp), %ebx
    int $LINUX_SYSCALL

    #exit
    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $LINUX_SYSCALL

    movl %ebp, %esp







    
    







