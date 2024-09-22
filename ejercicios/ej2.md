Escribir un programa en `C` que dados dos strings determine la longitud de su prefijo común más largo.

Ejemplos:

* `prefijo_de("Astronomia", "Astrologia") = 5 // (“Astro”)`
* `prefijo_de("Pinchado", "Pincel") = 4 // (“Pinc”)`
* `prefijo_de("Boca", "River") = 0 // (“”)`
* `prefijo_de("ABCD", "ABCD") = 4 // (“ABCD”)`

```c
int prefijo_de(char* s1, char* s2){
    int n1 = strlen(s1);
    int n2 = strlen(s2);
    int res=0;
    if(n1 > n2){
        for(int i = 0; i < n2; i++){
            if(s1[i] != s2[i]){
                return res;
            }
            res++;
        }
    } else{
        for(int i = 0; i < n1; i++){
            if(s1[i] != s2[i]){
                return res;
            }
            res++;
        }
    }
    return res;
}
```

Opcional Escribir un programa que dados dos strings devuelva “el segundo sin el prefijo común con el primero”.

Para construir un nuevo string deberán hacer uso de memoria dinámica (`malloc/free`).

Ejemplos:
* `quitar_prefijo("Astro", "Astrologia") = "logia"`
* `quitar_prefijo("Pinchado", "Pincel") = "el"`
* `quitar_prefijo("Boca", "River") = "River"`
* `quitar_prefijo("ABCD", "ABCD") = ""`

