cesar:
    push rbp
    mov rbp, rsp
    ;rdi = s, esi = x
    push r12
    mov r12, rdi    ;r12 = s
    push r13
    mov r13, rsi    ;r13 = x
    ;preservo rdi y rsi para no perder el puntero al string y el valor de x luego de hacer calls
    call strlen
    push r14
    mov r14, rax    ;r14 = n
    ;preservo el valor de n en un registro no volatil
    mov rdi, r14
    call malloc
    ;malloc retorna en rax la dirección de memoria donde se reservó espacio
    push r15
    mov r15, rax    ;r15 = result
    .loop:
        xor rdi, rdi
        mov dil, byte[r12]
        ;movemos el char a dil para llamar a ord
        call ord
        ;ord retorna en al el valor de la letra
        add al, byte[r13]
        ;sumamos x al valor de la letra
        mov dil, al
        ;movemos el valor de la letra a dil para llamar a chr
        call chr
        ;chr retorna en al la letra correspondiente al valor
        mov byte[r15], al
        ;guardamos la letra en la posición correspondiente de result

        dec r14
        cmp r14, 0
        jne .loop
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret