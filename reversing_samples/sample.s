global _start

section .text

_start:
    mov rax, 0x3c
    mov rdx, 0
    syscall
