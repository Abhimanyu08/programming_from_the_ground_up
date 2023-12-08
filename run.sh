#! /bin/bash


as --32 $1.s -o $1.o

ld -m elf_i386 $1.o -o $1

./$1 

echo $?

rm $1.o
rm $1
