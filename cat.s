#to start with I'll try to write a program which just displays the contents of the file on the terminal - similar to cat command


# Our program will be invoked by - ./cat file.txt

.section .data

.section .bss

.equ BUFFER_SIZE, 10
.lcomm BUFFER_DATA, BUFFER_SIZE


.section .text

.globl _start
_start:

movl %esp, %ebp
subl $4, %esp
#first we'll try and open the file

open_file:
movl $5, %eax #store the open system call in %eax register
movl 8(%ebp), %ebx #the command line arguments to the program will be stored on the stack. first item on stack is return address, second item will be our filename

movl $0, %ecx #store the mode (read,write, both, read-only etc) in %ecx. 0 corresponds to read-only mode

movl $0666, %edx #store the permissions in %edx

int $0x80 #call linux


#now that we've called open system call, file descriptor will be storedin %eax, we'll store it above the base pointer in the stack
movl %eax, -4(%ebp)


read_file:


movl $3, %eax #read system call in %eax
movl -4(%ebp), %ebx #read system call requires the file descriptor to be stored in %ebx
movl $BUFFER_DATA, %ecx #read system call requires the memory location where it should put the data that it has read to be stored in %ecx
movl $BUFFER_SIZE, %edx #read system call requires the amount of data to be read to be stored in %edx

int $0x80

#after read system call is finished it stores the number of bytes read in %eax. If it's <= 0, we've reached the end of file
cmpl $0, %eax
jle end


write_to_stdout:

movl %eax,%edx #move the number of bytes read to %edx

movl $4, %eax #write system call
movl $1, %ebx #we store the file desriptor we want to write to in %ebx. We want to write to terminal which has file descriptor 1 by default
movl $BUFFER_DATA, %ecx #write system call requires the address of the data to be written should be stored in %ecx
int $0x80

jmp read_file


end: 
#here's we'll close the file
movl $6, %eax #close system call
movl 8(%ebp), %ebx
int $0x80


#---exit----
movl $1, %eax 
movl $0, %ebx
int $0x80
