#include <stdio.h> 
#include <stdlib.h>

int *get_num_ptr(void);

int main(void) {

    int *num = get_num_ptr();

    printf("%d\n",*num);

    free(num);

    return 0;
}

int *get_num_ptr(void) {

    int *x_pointer = malloc(sizeof(int));

    *x_pointer = 42;

    return x_pointer;
}