../as.sh read-record
../as.sh count-chars
../as.sh read-records
../as.sh write-newline

ld -m elf_i386 read-record.o count-chars.o read-records.o write-newline.o -o read-records
./read-records

