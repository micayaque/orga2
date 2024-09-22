Una $\textcolor{pink}{lista\ enlazada}$ es una estructura de datos que nos permite almacenar datos como una secuencia de $\textcolor{pink}{nodos}$. 

Cada $\textcolor{pink}{nodo}$ consiste de su $\textcolor{pink}{valor}$ y un $\textcolor{pink}{puntero}$ al nodo que viene después. 

Lo único que se necesita para tener acceso a toda la
lista es un puntero al nodo que la encabeza (llamado $\textcolor{pink}{head}$).
$\textcolor{pink}{}$

Considere la siguiente estructura y sus operaciones:
```c
typedef struct node_str {
    struct node_str* siguiente;
    int32_t valor;
} node_t;
```
```c
node_t* agregarAdelante(int32_t valor, node_t* siguiente);
```
```c
node_t* agregarAdelante_asm(int32_t valor, node_t* siguiente);
```
```c
int32_t valorEn(uint32_t indice, node_t* cabeza);
```
```c
void destruirLista(node_t* cabeza);
```
a) Implemente `agregarAdelante(int32 t, node t*)` de forma que la expresión `head = agregarAdelante(123,
head);` nos permita agregar el valor `123` al principio de la lista llamada head.

```c
node_t* agregarAdelante(int32_t valor, node_t* siguiente) {
    node_t* nuevo = malloc(sizeof(node_t));
    nuevo->valor = valor;
    nuevo->siguiente = siguiente;
    return nuevo;
}
```
b) Implemente `agregarAdelante_asm(int32 t, node t*)` en lenguaje ensamblador.
```asm
NODE_SIZE EQU 12
OFFSET_SIGUIENTE EQU 0
OFFSET_VALOR EQU 8
;edi = valor rsi = siguiente
agregarAdelante_asm:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    xor r12, r12
    mov r12d, edi   ; r12d = valor
    mov r13, rsi    ; r13 = siguiente
    mov rdi, NODE_SIZE
    call malloc
    ;ahora en rax tenemos la dirección de memoria donde se encuentra el nuevo nodo
    mov [rax + OFFSET_SIGUIENTE], r13
    mov dword [rax + OFFSET_VALOR], r12d 
    pop r13
    pop r12
    pop rbp
    ret
```

Opcional ⋆ ⋆ ⋆ 

Implemente `valorEn(uint32 t, node t*)` en Assembler de forma que nos permita obtener el i-ésimo elemento de la lista.

Opcional ⋆ ⋆ ⋆ 

Implemente `destruirLista(node t*)` en Assembler, que dada la cabeza de la lista elimina toda la lista. Corrobore su correcto funcionamiento utilizando valgrind.

