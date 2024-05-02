// read a number n and print the integers 1..n one per line

#include <stdio.h>

int main(void) {
    int number, i;

    printf("Enter a number: ");
    scanf("%d", &number);

    i = 1;

loop_top:
    if (i > number) goto loop_end;

loop_body:
    printf("%d\n", i);
    i = i + 1;
    goto loop_top;

loop_end:
    return 0;
}
