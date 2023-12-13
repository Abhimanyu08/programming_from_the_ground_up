
.section .data

message:
.ascii "Hey diddle diddle!\0"

filename:
.ascii "heynow.txt\0"


.section .bss

.equ BUFFER_SIZE, 50
.lcomm BUFFER_DATA, BUFFER_SIZE 


.section .text
.equ SYS_OPEN, 5
.equ O_CREAT_WRONLY_TRUNC, 03101

.globl _start

_start:
    
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp
    open_file:
    movl $SYS_OPEN, %eax
    movl $filename, %ebx
    movl $O_CREAT_WRONLY_TRUNC, %ecx

    movl $0666, %edx

    int $0x80

    #right now we have the file descriptor in %eax
    movl %eax, -4(%ebp)
    # now we write message char by char into BUFFER_DATA 
    movl $-1, %edi
    movl $-1, %esi
    read_message:
    incl %edi
    incl %esi

    cmpl $BUFFER_SIZE,%edi
    je read_message_end

    movl $message, %eax
    movl $BUFFER_DATA, %ebx
    movb (%eax, %edi, 1), %cl
    cmpb $0, %cl
    je read_message_end
    
    movb %cl, (%ebx, %edi, 1)

    jmp read_message

    read_message_end:
    write_to_file:
    movl -4(%ebp), %ebx #move the file descriptor in %ebx
    movl $4, %eax #write system call
    movl $BUFFER_DATA, %ecx
    movl %esi, %edx

    int $0x80

    cmpl $BUFFER_SIZE,%esi
    jl end
    movl $0, %esi
    jmp read_message

    end:

    movl %ebp, %esp
    popl %ebp

    #----close file-------
    movl $6, %eax #close system call
    movl $filename, %ebx
    int $0x80

    #--------exit-----

    movl $1, %eax
    movl $0, %ebx
    int $0x80


