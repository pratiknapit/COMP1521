// print a square of asterisks
#include <stdio.h>

int main(void) {
    int x;

    scanf("%d", &x);

    int i = 0;

outer_loop_cond:
    if (i >= x) goto outer_loop_end;
    int j = 0;

inner_loop_cond:
    if (j >= x) goto outer_loop_step;
    printf("*");
    j = j + 1;
    goto inner_loop_cond;

outer_loop_step:
    i = i + 1;
    printf("\n");
    goto outer_loop_cond;


outer_loop_end:

    return 0;
}