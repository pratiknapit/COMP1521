#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    char *ret1;
    char *ret2;
    int value1;
    int value2;
    if ((ret1 = getenv(argv[1])) == NULL) {
        value1 = 42;
    } else {
        value1 = atoi(ret1);
    }

    if ((ret2 = getenv(argv[2])) == NULL) {
        value2 = 42;
    } else {
        value2 = atoi(ret2);
    }

    int diff = value1 - value2;

    return (abs(diff) < 10) ? printf("1\n") : printf("0\n"); 
}