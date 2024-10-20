Dada una cadena de texto $s$ definiremos su codificación césar simplificada respecto de un entero $x$ de la siguiente manera:

La función recibe únicamente caracteres en mayúsculas (es una precondición). 

Para explicarlo supongamos la existencia de dos funciones: `ord` y `chr`, ambas definidas para las mayúsculas  únicamente.

* `ord(c)` es el número de letra de $c$. $(A = 0, Z = 25)$

* `chr(n)` es la letra correspondiente al número $n$.
La función “vuelve a empezar desde el princpio” cuando se queda sin letras, o sea `chr(26k + n) == chr(n)`.

Con estas dos funciones el pseudocódigo de `cesar(s, x)` es:
```
resultado := una cadena con tamaño longitud(s)

por cada i de 0 a longitud(s):
    la i-esima letra del resultado es chr(ord(c) + x)
devolver resultado
```
Ejemplo:

* `cesar("CASA", 3) = "FDVD"`
* `cesar("CALABAZA", 7) = "JHSHIHGH"`

Más información: https://es.wikipedia.org/wiki/Cifrado César

Puede asumir que $0 \leq x < 26$. Opcionalmente resuelva el problema general.

Recuerden que todos los bytes que representan las letras estan dadas por la codificaci ́on ASCII. Por ejemplo, el 65 corresponde al caracter A mayúscula. Fijense cual sería el valor binario que tomaría cada letra mayúscula en la codificación ASCII.

### a) Escribir una función en C que dada una cadena de caracteres y un entero, devuelva su codificación césar simplificada.

En C un string es un array de caracteres, `char*`

```c
char* cesar(char* s, int x) {
    int n = strlen(s);
    char* result = malloc(n+1); 
    // +1 porque strlen no cuenta el \0
    for (int i = 0; i < n; i++) {
        result[i] = (char)(ord(s[i]) + x);
    }
    result[strlen(s)] = '\0';
    return result;
}
```

### b) Realice otra implementación en assembler respetando el ABI visto en la cátedra. Cree un pequeño programa en C que utilice esta implementación

```asm
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
```