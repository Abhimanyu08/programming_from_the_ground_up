../as.sh max_age

ld -m elf_i386 read-record.o max_age.o -o max-age

./max-age

echo $?

