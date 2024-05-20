extern printf
extern scanf

global main

section .text

main:
    default abs

    ; jmp 72
    jmp 0xc3                                                ; 00000000

    ; push rax
    sub rsp, 0x8                                            ; 00000005
    movsd [rsp], xmm2                                       ; 00000009

    ; push 0
    mov rbx, strict qword 0x0                               ; 0000000e
    push rbx                                                ; 00000018

    ; je 60
    movsd xmm0, [rsp]                                       ; 00000019
    add rsp, 0x8                                            ; 0000001e
    movsd xmm1, [rsp]                                       ; 00000022
    add rsp, 0x8                                            ; 00000027
    comisd xmm0, xmm1                                       ; 0000002b
    je 0x80                                                 ; 0000002f

    ; push rax
    sub rsp, 0x8                                            ; 00000035
    movsd [rsp], xmm2                                       ; 00000039

    ; push rax
    sub rsp, 0x8                                            ; 0000003e
    movsd [rsp], xmm2                                       ; 00000042

    ; push 1
    mov rbx, strict qword 0x3ff0000000000000                ; 00000047
    push rbx                                                ; 00000051

    ; sub
    movsd xmm0, [rsp]                                       ; 00000052
    add rsp, 0x8                                            ; 00000057
    movsd xmm1, [rsp]                                       ; 0000005b
    add rsp, 0x8                                            ; 00000060
    subsd xmm1, xmm0                                        ; 00000064
    sub rsp, 0x8                                            ; 00000068
    movsd [rsp], xmm1                                       ; 0000006c

    ; pop rax
    movsd xmm2, [rsp]                                       ; 00000071
    add rsp, 0x8                                            ; 00000076

    ; call 9
    call 0xffffff8a                                         ; 0000007a

    ; push rax
    sub rsp, 0x8                                            ; 0000007f
    movsd [rsp], xmm2                                       ; 00000083

    ; mul
    movsd xmm0, [rsp]                                       ; 00000088
    add rsp, 0x8                                            ; 0000008d
    movsd xmm1, [rsp]                                       ; 00000091
    add rsp, 0x8                                            ; 00000096
    mulsd xmm1, xmm0                                        ; 0000009a
    sub rsp, 0x8                                            ; 0000009e
    movsd [rsp], xmm1                                       ; 000000a2

    ; pop rax
    movsd xmm2, [rsp]                                       ; 000000a7
    add rsp, 0x8                                            ; 000000ac

    ; ret
    ret                                                     ; 000000b0

    ; push 1
    mov rbx, strict qword 0x3ff0000000000000                ; 000000b1
    push rbx                                                ; 000000bb

    ; pop rax
    movsd xmm2, [rsp]                                       ; 000000bc
    add rsp, 0x8                                            ; 000000c1

    ; ret
    ret                                                     ; 000000c5

    ; in
    mov rax, strict qword 0x1                               ; 000000c6
    sub rsp, 0x8                                            ; 000000d0
    mov rdi, scanf_fmt                                      ; 000000d4
    mov rsi, rsp                                            ; 000000de
    mov rbx, scanf                                          ; 000000e1
    sub rsp, 0x8                                            ; 000000eb
    movsd [rsp], xmm3                                       ; 000000ef
    sub rsp, 0x8                                            ; 000000f4
    call rbx                                                ; 000000f8
    add rsp, 0x8                                            ; 000000fa
    movsd xmm3, [rsp]                                       ; 000000fe
    add rsp, 0x8                                            ; 00000103

    ; pop rax
    movsd xmm2, [rsp]                                       ; 00000107
    add rsp, 0x8                                            ; 0000010c

    ; call 9
    call 0xfffffef4                                         ; 00000110

    ; push rax
    sub rsp, 0x8                                            ; 00000115
    movsd [rsp], xmm2                                       ; 00000119

    ; out
    mov rax, strict qword 0x1                               ; 0000011e
    mov rdi, scanf_fmt                                      ; 00000128
    movsd xmm0, [rsp]                                       ; 00000132
    mov rbx, printf                                         ; 00000137
    sub rsp, 0x8                                            ; 00000141
    movsd [rsp], xmm2                                       ; 00000145
    sub rsp, 0x8                                            ; 0000014a
    call rbx                                                ; 0000014e
    add rsp, 0x8                                            ; 00000150
    movsd xmm2, [rsp]                                       ; 00000154
    add rsp, 0x8                                            ; 00000159
    add rsp, 0x8                                            ; 0000015d

    ; hlt
    mov rax, strict qword 0x0                               ; 00000161
    ret                                                     ; 0000016b

section .rodata
scanf_fmt db '%lg'
