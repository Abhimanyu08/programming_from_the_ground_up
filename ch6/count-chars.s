#PURPOSE: Count the characters until a null byte is reached.
#
#INPUT: The address of the character string
#
#OUTPUT: Returns the count in %eax


.type count_chars, @function
.globl count_chars


count_chars:

    pushl %ebp
    movl %esp, %ebp
    pushl %ebx

    movl $-1, %eax
    movl 8(%ebp), %ebx



    loop_begin:
       incl %eax 
       movb (%ebx, %eax, 1), %cl

       cmpb $0,%cl

       je loop_end

       jmp loop_begin

    loop_end:
        
        popl %ebx
        popl %ebp
        ret


