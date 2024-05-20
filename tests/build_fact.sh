#!/bin/bash

../Debug/trans -S fact.s fact.spu
nasm -f elf64 -l fact.lst -F dwarf fact.s
clang fact.o -no-pie -o fact.out
