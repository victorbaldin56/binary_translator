extern printf
extern scanf

global main

section .text

main:
    default abs

    ; in
    mov rax, strict qword 0x1                               ; 00000000
    sub rsp, 0x8                                            ; 0000000a
    mov rdi, fmt_string                                     ; 0000000e
    mov rsi, rsp                                            ; 00000018
    mov rbx, scanf                                          ; 0000001b
    call rbx                                                ; 00000025

    ; pop rax
    movsd xmm2, [rsp]                                       ; 00000027
    add rsp, 0x8                                            ; 0000002c

    ; in
    mov rax, strict qword 0x1                               ; 00000030
    sub rsp, 0x8                                            ; 0000003a
    mov rdi, fmt_string                                     ; 0000003e
    mov rsi, rsp                                            ; 00000048
    mov rbx, scanf                                          ; 0000004b
    call rbx                                                ; 00000055

    ; pop rbx
    movsd xmm3, [rsp]                                       ; 00000057
    add rsp, 0x8                                            ; 0000005c

    ; in
    mov rax, strict qword 0x1                               ; 00000060
    sub rsp, 0x8                                            ; 0000006a
    mov rdi, fmt_string                                     ; 0000006e
    mov rsi, rsp                                            ; 00000078
    mov rbx, scanf                                          ; 0000007b
    call rbx                                                ; 00000085

    ; pop rcx
    movsd xmm4, [rsp]                                       ; 00000087
    add rsp, 0x8                                            ; 0000008c

    ; push rax
    sub rsp, 0x8                                            ; 00000090
    movsd [rsp], xmm2                                       ; 00000094

    ; push 0
    mov rbx, strict qword 0x0                               ; 00000099
    push rbx                                                ; 000000a3

    ; je 118
    movsd xmm0, [rsp]                                       ; 000000a4
    add rsp, 0x8                                            ; 000000a9
    movsd xmm1, [rsp]                                       ; 000000ad
    add rsp, 0x8                                            ; 000000b2
    comisd xmm0, xmm1                                       ; 000000b6
    je 0x1d9                                                ; 000000ba

    ; call 163
    call 0x28e                                              ; 000000c0

    ; push rdx
    sub rsp, 0x8                                            ; 000000c5
    movsd [rsp], xmm5                                       ; 000000c9

    ; push 0
    mov rbx, strict qword 0x0                               ; 000000ce
    push rbx                                                ; 000000d8

    ; ja 187
    movsd xmm0, [rsp]                                       ; 000000d9
    add rsp, 0x8                                            ; 000000de
    movsd xmm1, [rsp]                                       ; 000000e2
    add rsp, 0x8                                            ; 000000e7
    comisd xmm0, xmm1                                       ; 000000eb
    ja 0x312                                                ; 000000ef

    ; push rdx
    sub rsp, 0x8                                            ; 000000f5
    movsd [rsp], xmm5                                       ; 000000f9

    ; sqrt
    movsd xmm1, [rsp]                                       ; 000000fe
    sqrtsd xmm0, xmm1                                       ; 00000103
    movsd [rsp], xmm0                                       ; 00000107

    ; pop rdx
    movsd xmm5, [rsp]                                       ; 0000010c
    add rsp, 0x8                                            ; 00000111

    ; push rdx
    sub rsp, 0x8                                            ; 00000115
    movsd [rsp], xmm5                                       ; 00000119

    ; push rbx
    sub rsp, 0x8                                            ; 0000011e
    movsd [rsp], xmm3                                       ; 00000122

    ; push -1
    mov rbx, strict qword 0xbff0000000000000                ; 00000127
    push rbx                                                ; 00000131

    ; mul
    movsd xmm0, [rsp]                                       ; 00000132
    add rsp, 0x8                                            ; 00000137
    movsd xmm1, [rsp]                                       ; 0000013b
    add rsp, 0x8                                            ; 00000140
    mulsd xmm0, xmm1                                        ; 00000144
    sub rsp, 0x8                                            ; 00000148
    movsd [rsp], xmm0                                       ; 0000014c

    ; pop rcx
    movsd xmm4, [rsp]                                       ; 00000151
    add rsp, 0x8                                            ; 00000156

    ; push rcx
    sub rsp, 0x8                                            ; 0000015a
    movsd [rsp], xmm4                                       ; 0000015e

    ; add
    movsd xmm0, [rsp]                                       ; 00000163
    add rsp, 0x8                                            ; 00000168
    movsd xmm1, [rsp]                                       ; 0000016c
    add rsp, 0x8                                            ; 00000171
    addsd xmm0, xmm1                                        ; 00000175
    sub rsp, 0x8                                            ; 00000179
    movsd [rsp], xmm0                                       ; 0000017d

    ; push 2
    mov rbx, strict qword 0x4000000000000000                ; 00000182
    push rbx                                                ; 0000018c

    ; push rax
    sub rsp, 0x8                                            ; 0000018d
    movsd [rsp], xmm2                                       ; 00000191

    ; mul
    movsd xmm0, [rsp]                                       ; 00000196
    add rsp, 0x8                                            ; 0000019b
    movsd xmm1, [rsp]                                       ; 0000019f
    add rsp, 0x8                                            ; 000001a4
    mulsd xmm0, xmm1                                        ; 000001a8
    sub rsp, 0x8                                            ; 000001ac
    movsd [rsp], xmm0                                       ; 000001b0

    ; pop rax
    movsd xmm2, [rsp]                                       ; 000001b5
    add rsp, 0x8                                            ; 000001ba

    ; push rax
    sub rsp, 0x8                                            ; 000001be
    movsd [rsp], xmm2                                       ; 000001c2

    ; div
    movsd xmm0, [rsp]                                       ; 000001c7
    add rsp, 0x8                                            ; 000001cc
    movsd xmm1, [rsp]                                       ; 000001d0
    add rsp, 0x8                                            ; 000001d5
    divsd xmm0, xmm1                                        ; 000001d9
    sub rsp, 0x8                                            ; 000001dd
    movsd [rsp], xmm0                                       ; 000001e1

    ; out
    mov rax, strict qword 0x1                               ; 000001e6
    mov rdi, fmt_string                                     ; 000001f0
    movsd xmm0, [rsp]                                       ; 000001fa
    mov rbx, printf                                         ; 000001ff
    call rbx                                                ; 00000209
    add rsp, 0x8                                            ; 0000020b

    ; push rcx
    sub rsp, 0x8                                            ; 0000020f
    movsd [rsp], xmm4                                       ; 00000213

    ; push rdx
    sub rsp, 0x8                                            ; 00000218
    movsd [rsp], xmm5                                       ; 0000021c

    ; sub
    movsd xmm0, [rsp]                                       ; 00000221
    add rsp, 0x8                                            ; 00000226
    movsd xmm1, [rsp]                                       ; 0000022a
    add rsp, 0x8                                            ; 0000022f
    subsd xmm0, xmm1                                        ; 00000233
    sub rsp, 0x8                                            ; 00000237
    movsd [rsp], xmm0                                       ; 0000023b

    ; push rax
    sub rsp, 0x8                                            ; 00000240
    movsd [rsp], xmm2                                       ; 00000244

    ; div
    movsd xmm0, [rsp]                                       ; 00000249
    add rsp, 0x8                                            ; 0000024e
    movsd xmm1, [rsp]                                       ; 00000252
    add rsp, 0x8                                            ; 00000257
    divsd xmm0, xmm1                                        ; 0000025b
    sub rsp, 0x8                                            ; 0000025f
    movsd [rsp], xmm0                                       ; 00000263

    ; out
    mov rax, strict qword 0x1                               ; 00000268
    mov rdi, fmt_string                                     ; 00000272
    movsd xmm0, [rsp]                                       ; 0000027c
    mov rbx, printf                                         ; 00000281
    call rbx                                                ; 0000028b
    add rsp, 0x8                                            ; 0000028d

    ; jmp 187
    jmp 0x170                                               ; 00000291

    ; push rbx
    sub rsp, 0x8                                            ; 00000296
    movsd [rsp], xmm3                                       ; 0000029a

    ; push 0
    mov rbx, strict qword 0x0                               ; 0000029f
    push rbx                                                ; 000002a9

    ; je 187
    movsd xmm0, [rsp]                                       ; 000002aa
    add rsp, 0x8                                            ; 000002af
    movsd xmm1, [rsp]                                       ; 000002b3
    add rsp, 0x8                                            ; 000002b8
    comisd xmm0, xmm1                                       ; 000002bc
    je 0x141                                                ; 000002c0

    ; push 0
    mov rbx, strict qword 0x0                               ; 000002c6
    push rbx                                                ; 000002d0

    ; push rcx
    sub rsp, 0x8                                            ; 000002d1
    movsd [rsp], xmm4                                       ; 000002d5

    ; sub
    movsd xmm0, [rsp]                                       ; 000002da
    add rsp, 0x8                                            ; 000002df
    movsd xmm1, [rsp]                                       ; 000002e3
    add rsp, 0x8                                            ; 000002e8
    subsd xmm0, xmm1                                        ; 000002ec
    sub rsp, 0x8                                            ; 000002f0
    movsd [rsp], xmm0                                       ; 000002f4

    ; push rbx
    sub rsp, 0x8                                            ; 000002f9
    movsd [rsp], xmm3                                       ; 000002fd

    ; div
    movsd xmm0, [rsp]                                       ; 00000302
    add rsp, 0x8                                            ; 00000307
    movsd xmm1, [rsp]                                       ; 0000030b
    add rsp, 0x8                                            ; 00000310
    divsd xmm0, xmm1                                        ; 00000314
    sub rsp, 0x8                                            ; 00000318
    movsd [rsp], xmm0                                       ; 0000031c

    ; out
    mov rax, strict qword 0x1                               ; 00000321
    mov rdi, fmt_string                                     ; 0000032b
    movsd xmm0, [rsp]                                       ; 00000335
    mov rbx, printf                                         ; 0000033a
    call rbx                                                ; 00000344
    add rsp, 0x8                                            ; 00000346

    ; jmp 187
    jmp 0xb7                                                ; 0000034a

    ; push rbx
    sub rsp, 0x8                                            ; 0000034f
    movsd [rsp], xmm3                                       ; 00000353

    ; push rbx
    sub rsp, 0x8                                            ; 00000358
    movsd [rsp], xmm3                                       ; 0000035c

    ; mul
    movsd xmm0, [rsp]                                       ; 00000361
    add rsp, 0x8                                            ; 00000366
    movsd xmm1, [rsp]                                       ; 0000036a
    add rsp, 0x8                                            ; 0000036f
    mulsd xmm0, xmm1                                        ; 00000373
    sub rsp, 0x8                                            ; 00000377
    movsd [rsp], xmm0                                       ; 0000037b

    ; push rax
    sub rsp, 0x8                                            ; 00000380
    movsd [rsp], xmm2                                       ; 00000384

    ; push rcx
    sub rsp, 0x8                                            ; 00000389
    movsd [rsp], xmm4                                       ; 0000038d

    ; mul
    movsd xmm0, [rsp]                                       ; 00000392
    add rsp, 0x8                                            ; 00000397
    movsd xmm1, [rsp]                                       ; 0000039b
    add rsp, 0x8                                            ; 000003a0
    mulsd xmm0, xmm1                                        ; 000003a4
    sub rsp, 0x8                                            ; 000003a8
    movsd [rsp], xmm0                                       ; 000003ac

    ; push 4
    mov rbx, strict qword 0x4010000000000000                ; 000003b1
    push rbx                                                ; 000003bb

    ; mul
    movsd xmm0, [rsp]                                       ; 000003bc
    add rsp, 0x8                                            ; 000003c1
    movsd xmm1, [rsp]                                       ; 000003c5
    add rsp, 0x8                                            ; 000003ca
    mulsd xmm0, xmm1                                        ; 000003ce
    sub rsp, 0x8                                            ; 000003d2
    movsd [rsp], xmm0                                       ; 000003d6

    ; sub
    movsd xmm0, [rsp]                                       ; 000003db
    add rsp, 0x8                                            ; 000003e0
    movsd xmm1, [rsp]                                       ; 000003e4
    add rsp, 0x8                                            ; 000003e9
    subsd xmm0, xmm1                                        ; 000003ed
    sub rsp, 0x8                                            ; 000003f1
    movsd [rsp], xmm0                                       ; 000003f5

    ; pop rdx
    movsd xmm5, [rsp]                                       ; 000003fa
    add rsp, 0x8                                            ; 000003ff

    ; ret
    ret                                                     ; 00000403

    ; hlt
    mov rax, strict qword 0x0                               ; 00000404
    ret                                                     ; 0000040e

section .rodata
fmt_string db '%lg '
