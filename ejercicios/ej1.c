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
