extern printf
extern scanf

global _start

section .text

_start:

    ; jmp 76
    jmp 0x183                                               ; 00000000

    ; push rbx
    sub rsp, 0x8                                            ; 00000005
    movsd [rsp], xmm3                                       ; 00000009

    ; push 0
    mov rax, strict qword 0x0                               ; 0000000e
    push rax                                                ; 00000017

    ; je 187
    movsd xmm0, [rsp]                                       ; 00000018
    add rsp, 0x8                                            ; 0000001d
    movsd xmm1, [rsp]                                       ; 00000021
    add rsp, 0x8                                            ; 00000026
    comisd xmm0, xmm1                                       ; 0000002a
    je 0xffffffd7                                           ; 0000002e

    ; push 0
    mov rax, strict qword 0x0                               ; 00000034
    push rax                                                ; 0000003d

    ; push rcx
    sub rsp, 0x8                                            ; 0000003e
    movsd [rsp], xmm4                                       ; 00000042

    ; sub
    movsd xmm0, [rsp]                                       ; 00000047
    add rsp, 0x8                                            ; 0000004c
    movsd xmm1, [rsp]                                       ; 00000050
    add rsp, 0x8                                            ; 00000055
    subsd xmm0, xmm1                                        ; 00000059
    sub rsp, 0x8                                            ; 0000005d
    movsd [rsp], xmm0                                       ; 00000061

    ; push rbx
    sub rsp, 0x8                                            ; 00000066
    movsd [rsp], xmm3                                       ; 0000006a

    ; div
    movsd xmm0, [rsp]                                       ; 0000006f
    add rsp, 0x8                                            ; 00000074
    movsd xmm1, [rsp]                                       ; 00000078
    add rsp, 0x8                                            ; 0000007d
    divsd xmm0, xmm1                                        ; 00000081
    sub rsp, 0x8                                            ; 00000085
    movsd [rsp], xmm0                                       ; 00000089

    ; out
    sub rsp, 0x8                                            ; 0000008e
    mov rdi, fmt_string                                     ; 00000092
    movsd xmm0, [rsp]                                       ; 0000009b
    add rsp, 0x8                                            ; 000000a0
    mov rax, printf                                         ; 000000a4
    call rax                                                ; 000000ad

    ; jmp 187
    jmp 0xffffff56                                          ; 000000af

    ; push rbx
    sub rsp, 0x8                                            ; 000000b4
    movsd [rsp], xmm3                                       ; 000000b8

    ; push rbx
    sub rsp, 0x8                                            ; 000000bd
    movsd [rsp], xmm3                                       ; 000000c1

    ; mul
    movsd xmm0, [rsp]                                       ; 000000c6
    add rsp, 0x8                                            ; 000000cb
    movsd xmm1, [rsp]                                       ; 000000cf
    add rsp, 0x8                                            ; 000000d4
    mulsd xmm0, xmm1                                        ; 000000d8
    sub rsp, 0x8                                            ; 000000dc
    movsd [rsp], xmm0                                       ; 000000e0

    ; push rax
    sub rsp, 0x8                                            ; 000000e5
    movsd [rsp], xmm2                                       ; 000000e9

    ; push rcx
    sub rsp, 0x8                                            ; 000000ee
    movsd [rsp], xmm4                                       ; 000000f2

    ; mul
    movsd xmm0, [rsp]                                       ; 000000f7
    add rsp, 0x8                                            ; 000000fc
    movsd xmm1, [rsp]                                       ; 00000100
    add rsp, 0x8                                            ; 00000105
    mulsd xmm0, xmm1                                        ; 00000109
    sub rsp, 0x8                                            ; 0000010d
    movsd [rsp], xmm0                                       ; 00000111

    ; push 4
    mov rax, strict qword 0x4010000000000000                ; 00000116
    push rax                                                ; 0000011f

    ; mul
    movsd xmm0, [rsp]                                       ; 00000120
    add rsp, 0x8                                            ; 00000125
    movsd xmm1, [rsp]                                       ; 00000129
    add rsp, 0x8                                            ; 0000012e
    mulsd xmm0, xmm1                                        ; 00000132
    sub rsp, 0x8                                            ; 00000136
    movsd [rsp], xmm0                                       ; 0000013a

    ; sub
    movsd xmm0, [rsp]                                       ; 0000013f
    add rsp, 0x8                                            ; 00000144
    movsd xmm1, [rsp]                                       ; 00000148
    add rsp, 0x8                                            ; 0000014d
    subsd xmm0, xmm1                                        ; 00000151
    sub rsp, 0x8                                            ; 00000155
    movsd [rsp], xmm0                                       ; 00000159

    ; ret
    ret                                                     ; 0000015e

    ; in
    sub rsp, 0x8                                            ; 0000015f
    mov rdi, fmt_string                                     ; 00000163
    mov rsi, rsp                                            ; 0000016c
    mov rax, scanf                                          ; 00000175
    call rax                                                ; 0000017e

    ; pop rax
    movsd xmm2, [rsp]                                       ; 00000180
    add rsp, 0x8                                            ; 00000185

    ; in
    sub rsp, 0x8                                            ; 00000189
    mov rdi, fmt_string                                     ; 0000018d
    mov rsi, rsp                                            ; 00000196
    mov rax, scanf                                          ; 0000019f
    call rax                                                ; 000001a8

    ; pop rbx
    movsd xmm3, [rsp]                                       ; 000001aa
    add rsp, 0x8                                            ; 000001af

    ; in
    sub rsp, 0x8                                            ; 000001b3
    mov rdi, fmt_string                                     ; 000001b7
    mov rsi, rsp                                            ; 000001c0
    mov rax, scanf                                          ; 000001c9
    call rax                                                ; 000001d2

    ; pop rcx
    movsd xmm4, [rsp]                                       ; 000001d4
    add rsp, 0x8                                            ; 000001d9

    ; push rax
    sub rsp, 0x8                                            ; 000001dd
    movsd [rsp], xmm2                                       ; 000001e1

    ; push 0
    mov rax, strict qword 0x0                               ; 000001e6
    push rax                                                ; 000001ef

    ; je 9
    movsd xmm0, [rsp]                                       ; 000001f0
    add rsp, 0x8                                            ; 000001f5
    movsd xmm1, [rsp]                                       ; 000001f9
    add rsp, 0x8                                            ; 000001fe
    comisd xmm0, xmm1                                       ; 00000202
    je 0xfffffe08                                           ; 00000206

    ; call 54
    call 0xfffffeb1                                         ; 0000020c

    ; pop rdx
    movsd xmm5, [rsp]                                       ; 00000211
    add rsp, 0x8                                            ; 00000216

    ; push rdx
    sub rsp, 0x8                                            ; 0000021a
    movsd [rsp], xmm5                                       ; 0000021e

    ; push 0
    mov rax, strict qword 0x0                               ; 00000223
    push rax                                                ; 0000022c

    ; ja 187
    movsd xmm0, [rsp]                                       ; 0000022d
    add rsp, 0x8                                            ; 00000232
    movsd xmm1, [rsp]                                       ; 00000236
    add rsp, 0x8                                            ; 0000023b
    comisd xmm0, xmm1                                       ; 0000023f
    ja 0xfffffdc2                                           ; 00000243

    ; push rdx
    sub rsp, 0x8                                            ; 00000249
    movsd [rsp], xmm5                                       ; 0000024d

    ; sqrt
    movsd xmm1, [rsp]                                       ; 00000252
    sqrtsd xmm0, xmm1                                       ; 00000257
    movsd [rsp], xmm0                                       ; 0000025b

    ; pop rdx
    movsd xmm5, [rsp]                                       ; 00000260
    add rsp, 0x8                                            ; 00000265

    ; push rdx
    sub rsp, 0x8                                            ; 00000269
    movsd [rsp], xmm5                                       ; 0000026d

    ; push rbx
    sub rsp, 0x8                                            ; 00000272
    movsd [rsp], xmm3                                       ; 00000276

    ; push -1
    mov rax, strict qword 0xbff0000000000000                ; 0000027b
    push rax                                                ; 00000284

    ; mul
    movsd xmm0, [rsp]                                       ; 00000285
    add rsp, 0x8                                            ; 0000028a
    movsd xmm1, [rsp]                                       ; 0000028e
    add rsp, 0x8                                            ; 00000293
    mulsd xmm0, xmm1                                        ; 00000297
    sub rsp, 0x8                                            ; 0000029b
    movsd [rsp], xmm0                                       ; 0000029f

    ; pop rcx
    movsd xmm4, [rsp]                                       ; 000002a4
    add rsp, 0x8                                            ; 000002a9

    ; push rcx
    sub rsp, 0x8                                            ; 000002ad
    movsd [rsp], xmm4                                       ; 000002b1

    ; add
    movsd xmm0, [rsp]                                       ; 000002b6
    add rsp, 0x8                                            ; 000002bb
    movsd xmm1, [rsp]                                       ; 000002bf
    add rsp, 0x8                                            ; 000002c4
    addsd xmm0, xmm1                                        ; 000002c8
    sub rsp, 0x8                                            ; 000002cc
    movsd [rsp], xmm0                                       ; 000002d0

    ; push 2
    mov rax, strict qword 0x4000000000000000                ; 000002d5
    push rax                                                ; 000002de

    ; push rax
    sub rsp, 0x8                                            ; 000002df
    movsd [rsp], xmm2                                       ; 000002e3

    ; mul
    movsd xmm0, [rsp]                                       ; 000002e8
    add rsp, 0x8                                            ; 000002ed
    movsd xmm1, [rsp]                                       ; 000002f1
    add rsp, 0x8                                            ; 000002f6
    mulsd xmm0, xmm1                                        ; 000002fa
    sub rsp, 0x8                                            ; 000002fe
    movsd [rsp], xmm0                                       ; 00000302

    ; pop rax
    movsd xmm2, [rsp]                                       ; 00000307
    add rsp, 0x8                                            ; 0000030c

    ; push rax
    sub rsp, 0x8                                            ; 00000310
    movsd [rsp], xmm2                                       ; 00000314

    ; div
    movsd xmm0, [rsp]                                       ; 00000319
    add rsp, 0x8                                            ; 0000031e
    movsd xmm1, [rsp]                                       ; 00000322
    add rsp, 0x8                                            ; 00000327
    divsd xmm0, xmm1                                        ; 0000032b
    sub rsp, 0x8                                            ; 0000032f
    movsd [rsp], xmm0                                       ; 00000333

    ; out
    sub rsp, 0x8                                            ; 00000338
    mov rdi, fmt_string                                     ; 0000033c
    movsd xmm0, [rsp]                                       ; 00000345
    add rsp, 0x8                                            ; 0000034a
    mov rax, printf                                         ; 0000034e
    call rax                                                ; 00000357

    ; push rcx
    sub rsp, 0x8                                            ; 00000359
    movsd [rsp], xmm4                                       ; 0000035d

    ; push rdx
    sub rsp, 0x8                                            ; 00000362
    movsd [rsp], xmm5                                       ; 00000366

    ; sub
    movsd xmm0, [rsp]                                       ; 0000036b
    add rsp, 0x8                                            ; 00000370
    movsd xmm1, [rsp]                                       ; 00000374
    add rsp, 0x8                                            ; 00000379
    subsd xmm0, xmm1                                        ; 0000037d
    sub rsp, 0x8                                            ; 00000381
    movsd [rsp], xmm0                                       ; 00000385

    ; push rax
    sub rsp, 0x8                                            ; 0000038a
    movsd [rsp], xmm2                                       ; 0000038e

    ; div
    movsd xmm0, [rsp]                                       ; 00000393
    add rsp, 0x8                                            ; 00000398
    movsd xmm1, [rsp]                                       ; 0000039c
    add rsp, 0x8                                            ; 000003a1
    divsd xmm0, xmm1                                        ; 000003a5
    sub rsp, 0x8                                            ; 000003a9
    movsd [rsp], xmm0                                       ; 000003ad

    ; out
    sub rsp, 0x8                                            ; 000003b2
    mov rdi, fmt_string                                     ; 000003b6
    movsd xmm0, [rsp]                                       ; 000003bf
    add rsp, 0x8                                            ; 000003c4
    mov rax, printf                                         ; 000003c8
    call rax                                                ; 000003d1

    mov rax, 0x3c
    mov rdx, 0x0
    syscall

section .rodata
fmt_string db '%lg'
