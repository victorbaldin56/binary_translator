#!/bin/bash

nasm -f elf64 -l sq.lst -F dwarf sq.s
ld -dynamic-linker /lib64/ld-linux-x86-64.so.2 sq.o -lc
