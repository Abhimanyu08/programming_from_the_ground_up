
#this function adds a newline character to the end of a buffer
# first argument - address to the start ofbuffer
# seconds argument - length of the buffer


#.globl write_newline


.section .data

newline:
.ascii "\n"

.section .text

.globl write_newline




.type write_newline, @function
write_newline:
    
    pushl %ebp
    movl %esp, %ebp
    
    movl 8 (%ebp), %eax #address to start of buffer
    movl 12 (%ebp), %ebx #length of buffer



    movb newline, %cl
    movb %cl, (%eax, %ebx, 1) 

    movl %ebp, %esp
    popl %ebp 
    ret
    



