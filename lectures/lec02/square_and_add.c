#include <stdio.h>

int main(void) {
    int a, b;

    printf("Enter a number: ");
    scanf("%d", &a);

    printf("Enter another number: ");
    scanf("%d", &b);

    printf("The sum of the squares of ")
    printf("%d", a);
    printf(" and ");
    printf("%d", b);
    printf(" is ");
    printf("%d", a*a + b*b);
    putchar('\n');

    return 0;
}