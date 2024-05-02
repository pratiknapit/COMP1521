#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *env1 = getenv(argv[1]);
    if (env1 == NULL) {
        printf("0\n");
        return 0;
    }

    char *env2 = getenv(argv[2]);
    if (env2 == NULL) {
        printf("0\n");
        return 0;
    }

    if (strcmp(env1, env2) == 0) {
        printf("1\n");
        return 0;
    }

    printf("0\n");

    return 0;
}