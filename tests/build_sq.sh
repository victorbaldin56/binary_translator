#!/bin/bash

../Debug/trans -S sq.s sq.spu
nasm -f elf64 -l sq.lst -F dwarf sq.s
clang sq.o -no-pie -o sq.out
