#include <stdio.h> 
#include <stdlib.h>

int main(void) {

    int i = 0;
    while (i < 10) {
        printf("%d", i);
        i++;
    }

    for(int j = 0; j<10; j++) {
        printf("%d", j);
    }

    printf("%d", i);

    return 0;
}