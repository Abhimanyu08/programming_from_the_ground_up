.include "record-def.s"
.include "linux.s"



.section .data

record1:
    .ascii "Fredrick\0"
    .rept 31 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "Bartlett\0"
    .rept 31 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "4242 S Prairie\nTulsa, OK 55555\0"
    .rept 209 #Padding to 240 bytes
    .byte 0
    .endr

    .long 45

record2:
    .ascii "Marilyn\0"
    .rept 32 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "Taylor\0"
    .rept 33 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "2224 S Johannan St\nChicago, IL 12345\0"
    .rept 203 #Padding to 240 bytes
    .byte 0
    .endr

    .long 29

record3:
    .ascii "Derrick\0"
    .rept 32 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "McIntire\0"
    .rept 31 #Padding to 40 bytes
    .byte 0
    .endr

    .ascii "500 W Oakland\nSan Diego, CA 54321\0"
    .rept 206 #Padding to 240 bytes
    .byte 0
    .endr

    .long 36

filename:
.ascii "test.dat\0" #filename in which to store the data

.globl _start
_start:

movl %esp, %ebp
subl $4, %esp

movl $SYS_OPEN, %eax
movl $filename, %ebx
movl $0101, %ecx
movl $0666, %edx
int $LINUX_SYSCALL


movl %eax, -4(%ebp)



# Write the first record into the file
pushl -4(%ebp) 
pushl $record1
call write_record

addl $8, %esp #remove the parameters from stack

pushl -4(%ebp) 
pushl $record2
call write_record

addl $8, %esp #remove the parameters from stack

pushl -4(%ebp) 
pushl $record3
call write_record

addl $8, %esp #remove the parameters from stack


#---------Close the file---------------

movl $SYS_CLOSE, %eax
movl -4(%ebp), %ebx
int $LINUX_SYSCALL


#exit
movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL




