// Read 10 numbers into an array then print the numbers which are
// larger than the final number read.

#include <stdio.h>

#define ARRAY_LEN 10

int main(void) {
    int i, final_number;
    int numbers[ARRAY_LEN] = { 0 };

loop_1_init:
    i = 0;

loop_1_cond:
    if (i >= ARRAY_LEN) goto loop_2_init;

loop_1_body:
    scanf("%d", &numbers[i]);
    final_number = numbers[i];
    i++;
    goto loop_1_cond;

loop_2_init:
    i = 0;

loop_2_cond:
    if (i >= ARRAY_LEN) goto end;
    if (numbers[i] < final_number) goto loop_2_step;
    printf("%d\n", numbers[i]);

loop_2_step:
    i++;
    goto loop_2_cond;

end:
    return 0;
}