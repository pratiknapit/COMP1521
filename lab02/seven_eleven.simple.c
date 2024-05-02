// Read a number and print positive multiples of 7 or 11 < n

#include <stdio.h>

int main(void) {
    int number, i;

    printf("Enter a number: ");
    scanf("%d", &number);

    i = 1;

loop_cond:
    if (i >= number) goto loop_end;

loop_body:
    if (i % 7 == 0) goto print_num;
    if (i % 11 == 0) goto print_num;
    goto loop_step;

print_num:
    printf("%d\n", i);

loop_step:
    i = i + 1;
    goto loop_cond;

loop_end:
    return 0;

}
