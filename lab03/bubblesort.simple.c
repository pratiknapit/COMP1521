// Reads 10 numbers into an array, bubblesorts them
// and then prints the 10 numbers
// then print them

#include <stdio.h>

#define ARRAY_LEN 10

int main(void) {
    int i;
    int numbers[ARRAY_LEN] = { 0 };

scan_loop:
    i = 0;
    while (i < ARRAY_LEN) {
        scanf("%d", &numbers[i]);
        i++;
    }


    int swapped = 1;

swap_loop_cond:
    if (swapped == 0) goto swap_loop_end;

swap_loop_body:
    swapped = 0;
    i = 1;

swap_loop_2_cond:
    if (i >= ARRAY_LEN) goto swap_loop_step;


    int x = numbers[i];
    int y = numbers[i-1];
    if (x >= y) goto swap_loop_2_step;
    numbers[i] = y;
    numbers[i - 1] = x;
    swapped = 1;

swap_loop_2_step:
    i++;
    goto swap_loop_2_cond;

swap_loop_step:
    goto swap_loop_cond;

swap_loop_end:

print_loop:
    i = 0;
    while (i < ARRAY_LEN) {
        printf("%d\n", numbers[i]);
        i++;
    }
}
