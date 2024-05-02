#include <stdio.h>

int main(void) {
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);

    if (n % 2 != 0) goto n_mod_2_neq_0;
    printf("even\n");
    goto epilogue;

n_mod_2_neq_0;
    printf("odd\n");

epilogue:
    return 0;
}