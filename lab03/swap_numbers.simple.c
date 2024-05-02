// Read 10 numbers into an array
// swap any pair of numbers which are out of order
// then print the array

#include <stdio.h>

#define ARRAY_LEN 10

int main(void) {
    int i;
    int numbers[ARRAY_LEN] = { 0 };

scan_loop_init:
    i = 0;
scan_loop_cond:
    if (i >= ARRAY_LEN) scan_loop_end;
scan_loop_body:
     scanf("%d", &numbers[i]);
scan_loop_step:
    i++;
scan_loop_end:

swap_loop_init:
    i = 1;
swap_loop_cond:
    if (i >= ARRAY_LEN) swap_loop_end:
swap_loop_body:
    int x = numbers[i];
    int y = numbers[i - 1];
    if (x >= y) swap_loop_step:
    numbers[i] = y;
    numbers[i-1] = x;
swap_loop_step:
    i++;
    
print_loop:
    i = 0;
    while (i < ARRAY_LEN) {
        printf("%d\n", numbers[i]);
        i++;
    }
}
