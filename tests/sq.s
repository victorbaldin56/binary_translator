extern printf
extern scanf

global _start

section .text

_start:
    default abs

    ; jmp 76
    jmp 0x16b                                               ; 00000000

    ; push rbx
    sub rsp, 0x8                                            ; 00000005
    movsd [rsp], xmm3                                       ; 00000009

    ; push 0
    mov rbx, strict qword 0x0                               ; 0000000e
    push rbx                                                ; 00000018

    ; je 187
    movsd xmm0, [rsp]                                       ; 00000019
    add rsp, 0x8                                            ; 0000001e
    movsd xmm1, [rsp]                                       ; 00000022
    add rsp, 0x8                                            ; 00000027
    comisd xmm0, xmm1                                       ; 0000002b
    je 0xffffffce                                           ; 0000002f

    ; push 0
    mov rbx, strict qword 0x0                               ; 00000035
    push rbx                                                ; 0000003f

    ; push rcx
    sub rsp, 0x8                                            ; 00000040
    movsd [rsp], xmm4                                       ; 00000044

    ; sub
    movsd xmm0, [rsp]                                       ; 00000049
    add rsp, 0x8                                            ; 0000004e
    movsd xmm1, [rsp]                                       ; 00000052
    add rsp, 0x8                                            ; 00000057
    subsd xmm0, xmm1                                        ; 0000005b
    sub rsp, 0x8                                            ; 0000005f
    movsd [rsp], xmm0                                       ; 00000063

    ; push rbx
    sub rsp, 0x8                                            ; 00000068
    movsd [rsp], xmm3                                       ; 0000006c

    ; div
    movsd xmm0, [rsp]                                       ; 00000071
    add rsp, 0x8                                            ; 00000076
    movsd xmm1, [rsp]                                       ; 0000007a
    add rsp, 0x8                                            ; 0000007f
    divsd xmm0, xmm1                                        ; 00000083
    sub rsp, 0x8                                            ; 00000087
    movsd [rsp], xmm0                                       ; 0000008b

    ; out
    mov rax, strict qword 0x1                               ; 00000090
    sub rsp, 0x8                                            ; 0000009a
    mov rdi, fmt_string                                     ; 0000009e
    movsd xmm0, [rsp]                                       ; 000000a8
    add rsp, 0x8                                            ; 000000ad
    mov rbx, printf                                         ; 000000b1
    call rbx                                                ; 000000bb

    ; jmp 187
    jmp 0xffffff40                                          ; 000000bd

    ; push rbx
    sub rsp, 0x8                                            ; 000000c2
    movsd [rsp], xmm3                                       ; 000000c6

    ; push rbx
    sub rsp, 0x8                                            ; 000000cb
    movsd [rsp], xmm3                                       ; 000000cf

    ; mul
    movsd xmm0, [rsp]                                       ; 000000d4
    add rsp, 0x8                                            ; 000000d9
    movsd xmm1, [rsp]                                       ; 000000dd
    add rsp, 0x8                                            ; 000000e2
    mulsd xmm0, xmm1                                        ; 000000e6
    sub rsp, 0x8                                            ; 000000ea
    movsd [rsp], xmm0                                       ; 000000ee

    ; push rax
    sub rsp, 0x8                                            ; 000000f3
    movsd [rsp], xmm2                                       ; 000000f7

    ; push rcx
    sub rsp, 0x8                                            ; 000000fc
    movsd [rsp], xmm4                                       ; 00000100

    ; mul
    movsd xmm0, [rsp]                                       ; 00000105
    add rsp, 0x8                                            ; 0000010a
    movsd xmm1, [rsp]                                       ; 0000010e
    add rsp, 0x8                                            ; 00000113
    mulsd xmm0, xmm1                                        ; 00000117
    sub rsp, 0x8                                            ; 0000011b
    movsd [rsp], xmm0                                       ; 0000011f

    ; push 4
    mov rbx, strict qword 0x4010000000000000                ; 00000124
    push rbx                                                ; 0000012e

    ; mul
    movsd xmm0, [rsp]                                       ; 0000012f
    add rsp, 0x8                                            ; 00000134
    movsd xmm1, [rsp]                                       ; 00000138
    add rsp, 0x8                                            ; 0000013d
    mulsd xmm0, xmm1                                        ; 00000141
    sub rsp, 0x8                                            ; 00000145
    movsd [rsp], xmm0                                       ; 00000149

    ; sub
    movsd xmm0, [rsp]                                       ; 0000014e
    add rsp, 0x8                                            ; 00000153
    movsd xmm1, [rsp]                                       ; 00000157
    add rsp, 0x8                                            ; 0000015c
    subsd xmm0, xmm1                                        ; 00000160
    sub rsp, 0x8                                            ; 00000164
    movsd [rsp], xmm0                                       ; 00000168

    ; ret
    ret                                                     ; 0000016d

    ; in
    mov rax, strict qword 0x1                               ; 0000016e
    sub rsp, 0x8                                            ; 00000178
    mov rdi, fmt_string                                     ; 0000017c
    mov rsi, rsp                                            ; 00000186
    sub rsp, 0x8                                            ; 00000189
    mov rbx, scanf                                          ; 0000018d
    call rbx                                                ; 00000197
    add rsp, 0x8                                            ; 00000199

    ; pop rax
    movsd xmm2, [rsp]                                       ; 0000019d
    add rsp, 0x8                                            ; 000001a2

    ; in
    mov rax, strict qword 0x1                               ; 000001a6
    sub rsp, 0x8                                            ; 000001b0
    mov rdi, fmt_string                                     ; 000001b4
    mov rsi, rsp                                            ; 000001be
    sub rsp, 0x8                                            ; 000001c1
    mov rbx, scanf                                          ; 000001c5
    call rbx                                                ; 000001cf
    add rsp, 0x8                                            ; 000001d1

    ; pop rbx
    movsd xmm3, [rsp]                                       ; 000001d5
    add rsp, 0x8                                            ; 000001da

    ; in
    mov rax, strict qword 0x1                               ; 000001de
    sub rsp, 0x8                                            ; 000001e8
    mov rdi, fmt_string                                     ; 000001ec
    mov rsi, rsp                                            ; 000001f6
    sub rsp, 0x8                                            ; 000001f9
    mov rbx, scanf                                          ; 000001fd
    call rbx                                                ; 00000207
    add rsp, 0x8                                            ; 00000209

    ; pop rcx
    movsd xmm4, [rsp]                                       ; 0000020d
    add rsp, 0x8                                            ; 00000212

    ; push rax
    sub rsp, 0x8                                            ; 00000216
    movsd [rsp], xmm2                                       ; 0000021a

    ; push 0
    mov rbx, strict qword 0x0                               ; 0000021f
    push rbx                                                ; 00000229

    ; je 9
    movsd xmm0, [rsp]                                       ; 0000022a
    add rsp, 0x8                                            ; 0000022f
    movsd xmm1, [rsp]                                       ; 00000233
    add rsp, 0x8                                            ; 00000238
    comisd xmm0, xmm1                                       ; 0000023c
    je 0xfffffdc2                                           ; 00000240

    ; call 54
    call 0xfffffe79                                         ; 00000246

    ; pop rdx
    movsd xmm5, [rsp]                                       ; 0000024b
    add rsp, 0x8                                            ; 00000250

    ; push rdx
    sub rsp, 0x8                                            ; 00000254
    movsd [rsp], xmm5                                       ; 00000258

    ; push 0
    mov rbx, strict qword 0x0                               ; 0000025d
    push rbx                                                ; 00000267

    ; ja 187
    movsd xmm0, [rsp]                                       ; 00000268
    add rsp, 0x8                                            ; 0000026d
    movsd xmm1, [rsp]                                       ; 00000271
    add rsp, 0x8                                            ; 00000276
    comisd xmm0, xmm1                                       ; 0000027a
    ja 0xfffffd7f                                           ; 0000027e

    ; push rdx
    sub rsp, 0x8                                            ; 00000284
    movsd [rsp], xmm5                                       ; 00000288

    ; sqrt
    movsd xmm1, [rsp]                                       ; 0000028d
    sqrtsd xmm0, xmm1                                       ; 00000292
    movsd [rsp], xmm0                                       ; 00000296

    ; pop rdx
    movsd xmm5, [rsp]                                       ; 0000029b
    add rsp, 0x8                                            ; 000002a0

    ; push rdx
    sub rsp, 0x8                                            ; 000002a4
    movsd [rsp], xmm5                                       ; 000002a8

    ; push rbx
    sub rsp, 0x8                                            ; 000002ad
    movsd [rsp], xmm3                                       ; 000002b1

    ; push -1
    mov rbx, strict qword 0xbff0000000000000                ; 000002b6
    push rbx                                                ; 000002c0

    ; mul
    movsd xmm0, [rsp]                                       ; 000002c1
    add rsp, 0x8                                            ; 000002c6
    movsd xmm1, [rsp]                                       ; 000002ca
    add rsp, 0x8                                            ; 000002cf
    mulsd xmm0, xmm1                                        ; 000002d3
    sub rsp, 0x8                                            ; 000002d7
    movsd [rsp], xmm0                                       ; 000002db

    ; pop rcx
    movsd xmm4, [rsp]                                       ; 000002e0
    add rsp, 0x8                                            ; 000002e5

    ; push rcx
    sub rsp, 0x8                                            ; 000002e9
    movsd [rsp], xmm4                                       ; 000002ed

    ; add
    movsd xmm0, [rsp]                                       ; 000002f2
    add rsp, 0x8                                            ; 000002f7
    movsd xmm1, [rsp]                                       ; 000002fb
    add rsp, 0x8                                            ; 00000300
    addsd xmm0, xmm1                                        ; 00000304
    sub rsp, 0x8                                            ; 00000308
    movsd [rsp], xmm0                                       ; 0000030c

    ; push 2
    mov rbx, strict qword 0x4000000000000000                ; 00000311
    push rbx                                                ; 0000031b

    ; push rax
    sub rsp, 0x8                                            ; 0000031c
    movsd [rsp], xmm2                                       ; 00000320

    ; mul
    movsd xmm0, [rsp]                                       ; 00000325
    add rsp, 0x8                                            ; 0000032a
    movsd xmm1, [rsp]                                       ; 0000032e
    add rsp, 0x8                                            ; 00000333
    mulsd xmm0, xmm1                                        ; 00000337
    sub rsp, 0x8                                            ; 0000033b
    movsd [rsp], xmm0                                       ; 0000033f

    ; pop rax
    movsd xmm2, [rsp]                                       ; 00000344
    add rsp, 0x8                                            ; 00000349

    ; push rax
    sub rsp, 0x8                                            ; 0000034d
    movsd [rsp], xmm2                                       ; 00000351

    ; div
    movsd xmm0, [rsp]                                       ; 00000356
    add rsp, 0x8                                            ; 0000035b
    movsd xmm1, [rsp]                                       ; 0000035f
    add rsp, 0x8                                            ; 00000364
    divsd xmm0, xmm1                                        ; 00000368
    sub rsp, 0x8                                            ; 0000036c
    movsd [rsp], xmm0                                       ; 00000370

    ; out
    mov rax, strict qword 0x1                               ; 00000375
    sub rsp, 0x8                                            ; 0000037f
    mov rdi, fmt_string                                     ; 00000383
    movsd xmm0, [rsp]                                       ; 0000038d
    add rsp, 0x8                                            ; 00000392
    mov rbx, printf                                         ; 00000396
    call rbx                                                ; 000003a0

    ; push rcx
    sub rsp, 0x8                                            ; 000003a2
    movsd [rsp], xmm4                                       ; 000003a6

    ; push rdx
    sub rsp, 0x8                                            ; 000003ab
    movsd [rsp], xmm5                                       ; 000003af

    ; sub
    movsd xmm0, [rsp]                                       ; 000003b4
    add rsp, 0x8                                            ; 000003b9
    movsd xmm1, [rsp]                                       ; 000003bd
    add rsp, 0x8                                            ; 000003c2
    subsd xmm0, xmm1                                        ; 000003c6
    sub rsp, 0x8                                            ; 000003ca
    movsd [rsp], xmm0                                       ; 000003ce

    ; push rax
    sub rsp, 0x8                                            ; 000003d3
    movsd [rsp], xmm2                                       ; 000003d7

    ; div
    movsd xmm0, [rsp]                                       ; 000003dc
    add rsp, 0x8                                            ; 000003e1
    movsd xmm1, [rsp]                                       ; 000003e5
    add rsp, 0x8                                            ; 000003ea
    divsd xmm0, xmm1                                        ; 000003ee
    sub rsp, 0x8                                            ; 000003f2
    movsd [rsp], xmm0                                       ; 000003f6

    ; out
    mov rax, strict qword 0x1                               ; 000003fb
    sub rsp, 0x8                                            ; 00000405
    mov rdi, fmt_string                                     ; 00000409
    movsd xmm0, [rsp]                                       ; 00000413
    add rsp, 0x8                                            ; 00000418
    mov rbx, printf                                         ; 0000041c
    call rbx                                                ; 00000426

    mov rax, 0x3c
    mov rdx, 0x0
    syscall

section .rodata
fmt_string db '%lg'
