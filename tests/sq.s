global _start

section .text

_start:

    ; jmp 76
    jmp 0x4c

    ; push rbx
    sub rsp, 0x8
    movsd [rsp], xmm3

    ; push 0
    push 0x0

    ; je 187
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    comisd xmm0, xmm1
    je 0xbb

    ; push 0
    push 0x0

    ; push rcx
    sub rsp, 0x8
    movsd [rsp], xmm4

    ; sub
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    subsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; push rbx
    sub rsp, 0x8
    movsd [rsp], xmm3

    ; div
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    divsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; out
    sub rsp, 0x8
    mov rdi, 0x560fa87572c0
    movsd xmm0, [rsp]
    add rsp, 0x8
    mov rax, 0x560fa8687330
    call rax

    ; jmp 187
    jmp 0xbb

    ; push rbx
    sub rsp, 0x8
    movsd [rsp], xmm3

    ; push rbx
    sub rsp, 0x8
    movsd [rsp], xmm3

    ; mul
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    mulsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; push rax
    sub rsp, 0x8
    movsd [rsp], xmm2

    ; push rcx
    sub rsp, 0x8
    movsd [rsp], xmm4

    ; mul
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    mulsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; push 4
    push 0x4010000000000000

    ; mul
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    mulsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; sub
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    subsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; ret
    ret

    ; in
    sub rsp, 0x8
    mov rdi, 0x560fa87572c0
    mov rsi, rsp
    mov rax, 0x560fa8687330
    call rax

    ; pop rax
    movsd xmm2, [rsp]
    add rsp, 0x8

    ; in
    sub rsp, 0x8
    mov rdi, 0x560fa87572c0
    mov rsi, rsp
    mov rax, 0x560fa8687330
    call rax

    ; pop rbx
    movsd xmm3, [rsp]
    add rsp, 0x8

    ; in
    sub rsp, 0x8
    mov rdi, 0x560fa87572c0
    mov rsi, rsp
    mov rax, 0x560fa8687330
    call rax

    ; pop rcx
    movsd xmm4, [rsp]
    add rsp, 0x8

    ; push rax
    sub rsp, 0x8
    movsd [rsp], xmm2

    ; push 0
    push 0x0

    ; je 9
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    comisd xmm0, xmm1
    je 0x9

    ; call 54
    call 0x36

    ; pop rdx
    movsd xmm5, [rsp]
    add rsp, 0x8

    ; push rdx
    sub rsp, 0x8
    movsd [rsp], xmm5

    ; push 0
    push 0x0

    ; ja 187
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    comisd xmm0, xmm1
    ja 0xbb

    ; push rdx
    sub rsp, 0x8
    movsd [rsp], xmm5

    ; sqrt
    movsd xmm1, [rsp]
    sqrtsd xmm0, xmm1
    movsd [rsp], xmm0

    ; pop rdx
    movsd xmm5, [rsp]
    add rsp, 0x8

    ; push rdx
    sub rsp, 0x8
    movsd [rsp], xmm5

    ; push rbx
    sub rsp, 0x8
    movsd [rsp], xmm3

    ; push -1
    push 0xbff0000000000000

    ; mul
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    mulsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; pop rcx
    movsd xmm4, [rsp]
    add rsp, 0x8

    ; push rcx
    sub rsp, 0x8
    movsd [rsp], xmm4

    ; add
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    addsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; push 2
    push 0x4000000000000000

    ; push rax
    sub rsp, 0x8
    movsd [rsp], xmm2

    ; mul
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    mulsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; pop rax
    movsd xmm2, [rsp]
    add rsp, 0x8

    ; push rax
    sub rsp, 0x8
    movsd [rsp], xmm2

    ; div
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    divsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; out
    sub rsp, 0x8
    mov rdi, 0x560fa87572c0
    movsd xmm0, [rsp]
    add rsp, 0x8
    mov rax, 0x560fa8687330
    call rax

    ; push rcx
    sub rsp, 0x8
    movsd [rsp], xmm4

    ; push rdx
    sub rsp, 0x8
    movsd [rsp], xmm5

    ; sub
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    subsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; push rax
    sub rsp, 0x8
    movsd [rsp], xmm2

    ; div
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    divsd xmm0, xmm1
    sub rsp, 0x8
    movsd [rsp], xmm0

    ; out
    sub rsp, 0x8
    mov rdi, 0x560fa87572c0
    movsd xmm0, [rsp]
    add rsp, 0x8
    mov rax, 0x560fa8687330
    call rax

    mov rax, 0x3c
    mov rdx, 0x0
    syscall
