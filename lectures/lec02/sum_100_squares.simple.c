#include <stdio.h>

int main(void) {
    int sum = 0;

loop__init:
    int i = 1;

loop__cond:
    if (i > 100) goto loop_end;

loop__body:
    int square = i * i;
    sum += square;

loop__step:
    i++;
    goto loop__cond;

loop_end:
    printf("%d", sum);
    putchar("\n");

    return 0;
}