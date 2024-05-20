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
    sub rsp, 0x8                                            ; 00000025
    movsd [rsp], xmm3                                       ; 00000029
    sub rsp, 0x8                                            ; 0000002e
    call rbx                                                ; 00000032
    add rsp, 0x8                                            ; 00000034
    movsd xmm3, [rsp]                                       ; 00000038
    add rsp, 0x8                                            ; 0000003d

    ; pop rax
    movsd xmm2, [rsp]                                       ; 00000041
    add rsp, 0x8                                            ; 00000046

    ; in
    mov rax, strict qword 0x1                               ; 0000004a
    sub rsp, 0x8                                            ; 00000054
    mov rdi, fmt_string                                     ; 00000058
    mov rsi, rsp                                            ; 00000062
    mov rbx, scanf                                          ; 00000065
    sub rsp, 0x8                                            ; 0000006f
    movsd [rsp], xmm3                                       ; 00000073
    sub rsp, 0x8                                            ; 00000078
    call rbx                                                ; 0000007c
    add rsp, 0x8                                            ; 0000007e
    movsd xmm3, [rsp]                                       ; 00000082
    add rsp, 0x8                                            ; 00000087

    ; pop rbx
    movsd xmm3, [rsp]                                       ; 0000008b
    add rsp, 0x8                                            ; 00000090

    ; in
    mov rax, strict qword 0x1                               ; 00000094
    sub rsp, 0x8                                            ; 0000009e
    mov rdi, fmt_string                                     ; 000000a2
    mov rsi, rsp                                            ; 000000ac
    mov rbx, scanf                                          ; 000000af
    sub rsp, 0x8                                            ; 000000b9
    movsd [rsp], xmm3                                       ; 000000bd
    sub rsp, 0x8                                            ; 000000c2
    call rbx                                                ; 000000c6
    add rsp, 0x8                                            ; 000000c8
    movsd xmm3, [rsp]                                       ; 000000cc
    add rsp, 0x8                                            ; 000000d1

    ; pop rcx
    movsd xmm4, [rsp]                                       ; 000000d5
    add rsp, 0x8                                            ; 000000da

    ; push rax
    sub rsp, 0x8                                            ; 000000de
    movsd [rsp], xmm2                                       ; 000000e2

    ; push 0
    mov rbx, strict qword 0x0                               ; 000000e7
    push rbx                                                ; 000000f1

    ; je 118
    movsd xmm0, [rsp]                                       ; 000000f2
    add rsp, 0x8                                            ; 000000f7
    movsd xmm1, [rsp]                                       ; 000000fb
    add rsp, 0x8                                            ; 00000100
    comisd xmm0, xmm1                                       ; 00000104
    je 0x20d                                                ; 00000108

    ; call 163
    call 0x2dc                                              ; 0000010e

    ; push rdx
    sub rsp, 0x8                                            ; 00000113
    movsd [rsp], xmm5                                       ; 00000117

    ; push 0
    mov rbx, strict qword 0x0                               ; 0000011c
    push rbx                                                ; 00000126

    ; ja 187
    movsd xmm0, [rsp]                                       ; 00000127
    add rsp, 0x8                                            ; 0000012c
    movsd xmm1, [rsp]                                       ; 00000130
    add rsp, 0x8                                            ; 00000135
    comisd xmm0, xmm1                                       ; 00000139
    ja 0x360                                                ; 0000013d

    ; push rdx
    sub rsp, 0x8                                            ; 00000143
    movsd [rsp], xmm5                                       ; 00000147

    ; sqrt
    movsd xmm1, [rsp]                                       ; 0000014c
    sqrtsd xmm0, xmm1                                       ; 00000151
    movsd [rsp], xmm0                                       ; 00000155

    ; pop rdx
    movsd xmm5, [rsp]                                       ; 0000015a
    add rsp, 0x8                                            ; 0000015f

    ; push rdx
    sub rsp, 0x8                                            ; 00000163
    movsd [rsp], xmm5                                       ; 00000167

    ; push rbx
    sub rsp, 0x8                                            ; 0000016c
    movsd [rsp], xmm3                                       ; 00000170

    ; push -1
    mov rbx, strict qword 0xbff0000000000000                ; 00000175
    push rbx                                                ; 0000017f

    ; mul
    movsd xmm0, [rsp]                                       ; 00000180
    add rsp, 0x8                                            ; 00000185
    movsd xmm1, [rsp]                                       ; 00000189
    add rsp, 0x8                                            ; 0000018e
    mulsd xmm1, xmm0                                        ; 00000192
    sub rsp, 0x8                                            ; 00000196
    movsd [rsp], xmm1                                       ; 0000019a

    ; pop rcx
    movsd xmm4, [rsp]                                       ; 0000019f
    add rsp, 0x8                                            ; 000001a4

    ; push rcx
    sub rsp, 0x8                                            ; 000001a8
    movsd [rsp], xmm4                                       ; 000001ac

    ; add
    movsd xmm0, [rsp]                                       ; 000001b1
    add rsp, 0x8                                            ; 000001b6
    movsd xmm1, [rsp]                                       ; 000001ba
    add rsp, 0x8                                            ; 000001bf
    addsd xmm1, xmm0                                        ; 000001c3
    sub rsp, 0x8                                            ; 000001c7
    movsd [rsp], xmm1                                       ; 000001cb

    ; push 2
    mov rbx, strict qword 0x4000000000000000                ; 000001d0
    push rbx                                                ; 000001da

    ; push rax
    sub rsp, 0x8                                            ; 000001db
    movsd [rsp], xmm2                                       ; 000001df

    ; mul
    movsd xmm0, [rsp]                                       ; 000001e4
    add rsp, 0x8                                            ; 000001e9
    movsd xmm1, [rsp]                                       ; 000001ed
    add rsp, 0x8                                            ; 000001f2
    mulsd xmm1, xmm0                                        ; 000001f6
    sub rsp, 0x8                                            ; 000001fa
    movsd [rsp], xmm1                                       ; 000001fe

    ; pop rax
    movsd xmm2, [rsp]                                       ; 00000203
    add rsp, 0x8                                            ; 00000208

    ; push rax
    sub rsp, 0x8                                            ; 0000020c
    movsd [rsp], xmm2                                       ; 00000210

    ; div
    movsd xmm0, [rsp]                                       ; 00000215
    add rsp, 0x8                                            ; 0000021a
    movsd xmm1, [rsp]                                       ; 0000021e
    add rsp, 0x8                                            ; 00000223
    divsd xmm1, xmm0                                        ; 00000227
    sub rsp, 0x8                                            ; 0000022b
    movsd [rsp], xmm1                                       ; 0000022f

    ; out
    mov rax, strict qword 0x1                               ; 00000234
    mov rdi, fmt_string                                     ; 0000023e
    movsd xmm0, [rsp]                                       ; 00000248
    mov rbx, printf                                         ; 0000024d
    sub rsp, 0x8                                            ; 00000257
    movsd [rsp], xmm2                                       ; 0000025b
    sub rsp, 0x8                                            ; 00000260
    call rbx                                                ; 00000264
    add rsp, 0x8                                            ; 00000266
    movsd xmm2, [rsp]                                       ; 0000026a
    add rsp, 0x8                                            ; 0000026f
    add rsp, 0x8                                            ; 00000273

    ; push rcx
    sub rsp, 0x8                                            ; 00000277
    movsd [rsp], xmm4                                       ; 0000027b

    ; push rdx
    sub rsp, 0x8                                            ; 00000280
    movsd [rsp], xmm5                                       ; 00000284

    ; sub
    movsd xmm0, [rsp]                                       ; 00000289
    add rsp, 0x8                                            ; 0000028e
    movsd xmm1, [rsp]                                       ; 00000292
    add rsp, 0x8                                            ; 00000297
    subsd xmm1, xmm0                                        ; 0000029b
    sub rsp, 0x8                                            ; 0000029f
    movsd [rsp], xmm1                                       ; 000002a3

    ; push rax
    sub rsp, 0x8                                            ; 000002a8
    movsd [rsp], xmm2                                       ; 000002ac

    ; div
    movsd xmm0, [rsp]                                       ; 000002b1
    add rsp, 0x8                                            ; 000002b6
    movsd xmm1, [rsp]                                       ; 000002ba
    add rsp, 0x8                                            ; 000002bf
    divsd xmm1, xmm0                                        ; 000002c3
    sub rsp, 0x8                                            ; 000002c7
    movsd [rsp], xmm1                                       ; 000002cb

    ; out
    mov rax, strict qword 0x1                               ; 000002d0
    mov rdi, fmt_string                                     ; 000002da
    movsd xmm0, [rsp]                                       ; 000002e4
    mov rbx, printf                                         ; 000002e9
    sub rsp, 0x8                                            ; 000002f3
    movsd [rsp], xmm2                                       ; 000002f7
    sub rsp, 0x8                                            ; 000002fc
    call rbx                                                ; 00000300
    add rsp, 0x8                                            ; 00000302
    movsd xmm2, [rsp]                                       ; 00000306
    add rsp, 0x8                                            ; 0000030b
    add rsp, 0x8                                            ; 0000030f

    ; jmp 187
    jmp 0x18a                                               ; 00000313

    ; push rbx
    sub rsp, 0x8                                            ; 00000318
    movsd [rsp], xmm3                                       ; 0000031c

    ; push 0
    mov rbx, strict qword 0x0                               ; 00000321
    push rbx                                                ; 0000032b

    ; je 187
    movsd xmm0, [rsp]                                       ; 0000032c
    add rsp, 0x8                                            ; 00000331
    movsd xmm1, [rsp]                                       ; 00000335
    add rsp, 0x8                                            ; 0000033a
    comisd xmm0, xmm1                                       ; 0000033e
    je 0x15b                                                ; 00000342

    ; push 0
    mov rbx, strict qword 0x0                               ; 00000348
    push rbx                                                ; 00000352

    ; push rcx
    sub rsp, 0x8                                            ; 00000353
    movsd [rsp], xmm4                                       ; 00000357

    ; sub
    movsd xmm0, [rsp]                                       ; 0000035c
    add rsp, 0x8                                            ; 00000361
    movsd xmm1, [rsp]                                       ; 00000365
    add rsp, 0x8                                            ; 0000036a
    subsd xmm1, xmm0                                        ; 0000036e
    sub rsp, 0x8                                            ; 00000372
    movsd [rsp], xmm1                                       ; 00000376

    ; push rbx
    sub rsp, 0x8                                            ; 0000037b
    movsd [rsp], xmm3                                       ; 0000037f

    ; div
    movsd xmm0, [rsp]                                       ; 00000384
    add rsp, 0x8                                            ; 00000389
    movsd xmm1, [rsp]                                       ; 0000038d
    add rsp, 0x8                                            ; 00000392
    divsd xmm1, xmm0                                        ; 00000396
    sub rsp, 0x8                                            ; 0000039a
    movsd [rsp], xmm1                                       ; 0000039e

    ; out
    mov rax, strict qword 0x1                               ; 000003a3
    mov rdi, fmt_string                                     ; 000003ad
    movsd xmm0, [rsp]                                       ; 000003b7
    mov rbx, printf                                         ; 000003bc
    sub rsp, 0x8                                            ; 000003c6
    movsd [rsp], xmm2                                       ; 000003ca
    sub rsp, 0x8                                            ; 000003cf
    call rbx                                                ; 000003d3
    add rsp, 0x8                                            ; 000003d5
    movsd xmm2, [rsp]                                       ; 000003d9
    add rsp, 0x8                                            ; 000003de
    add rsp, 0x8                                            ; 000003e2

    ; jmp 187
    jmp 0xb7                                                ; 000003e6

    ; push rbx
    sub rsp, 0x8                                            ; 000003eb
    movsd [rsp], xmm3                                       ; 000003ef

    ; push rbx
    sub rsp, 0x8                                            ; 000003f4
    movsd [rsp], xmm3                                       ; 000003f8

    ; mul
    movsd xmm0, [rsp]                                       ; 000003fd
    add rsp, 0x8                                            ; 00000402
    movsd xmm1, [rsp]                                       ; 00000406
    add rsp, 0x8                                            ; 0000040b
    mulsd xmm1, xmm0                                        ; 0000040f
    sub rsp, 0x8                                            ; 00000413
    movsd [rsp], xmm1                                       ; 00000417

    ; push rax
    sub rsp, 0x8                                            ; 0000041c
    movsd [rsp], xmm2                                       ; 00000420

    ; push rcx
    sub rsp, 0x8                                            ; 00000425
    movsd [rsp], xmm4                                       ; 00000429

    ; mul
    movsd xmm0, [rsp]                                       ; 0000042e
    add rsp, 0x8                                            ; 00000433
    movsd xmm1, [rsp]                                       ; 00000437
    add rsp, 0x8                                            ; 0000043c
    mulsd xmm1, xmm0                                        ; 00000440
    sub rsp, 0x8                                            ; 00000444
    movsd [rsp], xmm1                                       ; 00000448

    ; push 4
    mov rbx, strict qword 0x4010000000000000                ; 0000044d
    push rbx                                                ; 00000457

    ; mul
    movsd xmm0, [rsp]                                       ; 00000458
    add rsp, 0x8                                            ; 0000045d
    movsd xmm1, [rsp]                                       ; 00000461
    add rsp, 0x8                                            ; 00000466
    mulsd xmm1, xmm0                                        ; 0000046a
    sub rsp, 0x8                                            ; 0000046e
    movsd [rsp], xmm1                                       ; 00000472

    ; sub
    movsd xmm0, [rsp]                                       ; 00000477
    add rsp, 0x8                                            ; 0000047c
    movsd xmm1, [rsp]                                       ; 00000480
    add rsp, 0x8                                            ; 00000485
    subsd xmm1, xmm0                                        ; 00000489
    sub rsp, 0x8                                            ; 0000048d
    movsd [rsp], xmm1                                       ; 00000491

    ; pop rdx
    movsd xmm5, [rsp]                                       ; 00000496
    add rsp, 0x8                                            ; 0000049b

    ; ret
    ret                                                     ; 0000049f

    ; hlt
    mov rax, strict qword 0x0                               ; 000004a0
    ret                                                     ; 000004aa

section .rodata
fmt_string db '%lg'
