as --32 square.s -o square.o
as --32 square_test.s -o square_test.o
ld -m elf_i386 square.o square_test.o -o main

./main

echo $?
