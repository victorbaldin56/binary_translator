global _start

section .text

_start:

    ; jmp 76
    jmp 0x142

    ; push rbx
    sub rsp, 0x8
    movsd [rsp], xmm3

    ; push 0
    mov rax, 0x0
    push rax

    ; je 187
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    comisd xmm0, xmm1
    je 0xffffffd8

    ; push 0
    mov rax, 0x0
    push rax

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
    mov rdi, 0x745904c0
    movsd xmm0, [rsp]
    add rsp, 0x8
    mov rax, 0x744be330
    call rax

    ; jmp 187
    jmp 0xffffff6b

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
    mov rax, 0x0
    push rax

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
    mov rdi, 0x745904c0
    mov rsi, rsp
    mov rax, 0x744be330
    call rax

    ; pop rax
    movsd xmm2, [rsp]
    add rsp, 0x8

    ; in
    sub rsp, 0x8
    mov rdi, 0x745904c0
    mov rsi, rsp
    mov rax, 0x744be330
    call rax

    ; pop rbx
    movsd xmm3, [rsp]
    add rsp, 0x8

    ; in
    sub rsp, 0x8
    mov rdi, 0x745904c0
    mov rsi, rsp
    mov rax, 0x744be330
    call rax

    ; pop rcx
    movsd xmm4, [rsp]
    add rsp, 0x8

    ; push rax
    sub rsp, 0x8
    movsd [rsp], xmm2

    ; push 0
    mov rax, 0x0
    push rax

    ; je 9
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    comisd xmm0, xmm1
    je 0xfffffe4d

    ; call 54
    call 0xfffffedc

    ; pop rdx
    movsd xmm5, [rsp]
    add rsp, 0x8

    ; push rdx
    sub rsp, 0x8
    movsd [rsp], xmm5

    ; push 0
    mov rax, 0x0
    push rax

    ; ja 187
    movsd xmm0, [rsp]
    add rsp, 0x8
    movsd xmm1, [rsp]
    add rsp, 0x8
    comisd xmm0, xmm1
    ja 0xfffffe11

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
    mov rax, 0x0
    push rax

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
    mov rax, 0x0
    push rax

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
    mov rdi, 0x745904c0
    movsd xmm0, [rsp]
    add rsp, 0x8
    mov rax, 0x744be330
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
    mov rdi, 0x745904c0
    movsd xmm0, [rsp]
    add rsp, 0x8
    mov rax, 0x744be330
    call rax

    mov rax, 0x3c
    mov rdx, 0x0
    syscall
