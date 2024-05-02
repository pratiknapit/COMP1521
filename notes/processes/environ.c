// print all environment varibles

#include <stdio.h>

int main(void) {
    extern char **environ;
    
    for (int i = 0; environ[i] != NULL; i++) {
        printf("%s\n", environ[i]);
    }

    char *value = getenv("HOME");

    return 0;
}

