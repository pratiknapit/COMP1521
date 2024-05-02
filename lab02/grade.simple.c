#include <stdio.h>

int main(void) {
    int mark;

    printf("Enter a mark: ");
    scanf("%d", &mark);

    if (mark < 50) goto print_fl;
    if (mark < 65) goto print_ps;
    if (mark < 75) goto print_cr;
    if (mark < 85) goto print_dn;
    goto print_hd;

print_fl:
    printf("FL\n");
    goto epilogue;

print_ps:
    printf("PS\n");
    goto epilogue;

print_cr:
    printf("CR\n");
    goto epilogue;

print_dn:
    printf("DN\n");
    goto epilogue;

print_hd:
    printf("HD\n");
    goto epilogue;


epilogue:
    return 0;
}