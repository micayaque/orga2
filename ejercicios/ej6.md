Considerar una estructura de $\textcolor{pink}{lista\ doblemente\ enlazada}$ en donde cada $nodo$ almacena un $string$ de $C$, es decir, un arreglo de caracteres finalizado en el caracter nulo (`‘\0’`).
```c
typedef struct node_t {
    struct node_t *next;
    struct node_t *prev;
    char *string;
} node;
```
a. Escribir en `ASM` una función que reciba como parámetros `n`: `doble puntero a nodo` y lo borre de la lista junto a su `string`. 

Esta función se puede usar tanto para borrar el primer elemento de la lista `(borrarNodo(&lista);)` como para
borrar algún otro `(borrarNodo(&lista->next->next);)`, suponiendo que se pasa un puntero al campo `next` del nodo
anterior.

Utilizar la función `free` para borrar tanto los nodos como las strings.

```c
void borrarNodo(node** n){
    node* aux = *n;
    if(aux->prev != NULL){
        aux->prev->next = aux->next;
    }
    if(aux->next != NULL){
        aux->next->prev = aux->prev;
    }
    free(aux->string);
    free(aux);
}
```
```asm
NULL EQU 0
NEXT_OFFSET EQU 0
PREV_OFFSET EQU 8
STRING_OFFSET EQU 16
;rdi = doble puntero a nodo
borrarNodo:
    push rbp
    mov rbp, rsp
    mov rdi, [rdi]    ;rdi = puntero a nodo
    mov rax, [rdi + NEXT_OFFSET]    ;rax = aux->next
    cmp rax, NULL
    jne .enganchar_next

    ;aux->prev->next = aux->next;
    .enganchar_next:
        mov r8, [rdi + PREV_OFFSET]    ;r8 = aux->prev
        mov r9, [r8 + NEXT_OFFSET]    ;r9 = aux->prev->next
        mov r10, [rdi + NEXT_OFFSET]    
        mov [r9], r10

    mov rax, [rdi + PREV_OFFSET]    ;rax = aux->prev
    cmp rax, NULL
    jne .enganchar_prev

    ;aux->next->prev = aux->prev;
    .enganchar_prev:
        mov r8, [rdi + NEXT_OFFSET]    ;r8 = aux->next
        mov r9, [r8 + PREV_OFFSET]    ;r9 = aux->next->prev
        mov r9, [rdi + PREV_OFFSET]    
        mov r10, [rdi + PREV_OFFSET]    ;r10 = aux->prev;
        mov [r9], r10

    push rdi
    sub rsp, 8
    mov rdi, [rdi + STRING_OFFSET]    ;rdi = aux->string
    call free
    add rsp, 8
    pop rdi
    call free

    pop rbp
    ret