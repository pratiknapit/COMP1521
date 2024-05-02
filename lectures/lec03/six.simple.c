#include <stdio.h>

int main(void) {
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);

    if (n % 2 != 0) goto epilogue;
    if (n % 3 != 0) goto epilogue;
        printf("six-ish");
        putchar("\n");

epilogue:
    return 0;
}