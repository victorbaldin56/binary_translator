jmp main

Factorial:
    push rax
    push 0
    je end ; condition of the recursion end

    push rax

    push rax
    push 1
    sub
    pop rax

    call Factorial ; recursive call

    push rax
    mul ; fact(n) = n*fact(n - 1)

    pop rax
    ret

end:
    push 1
    pop rax
    ret

main:
    in
    pop rax

    call Factorial

    push rax
    out

    hlt
