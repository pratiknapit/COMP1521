// Read 10 numbers into an array
// print 0 if they are in non-decreasing order
// print 1 otherwise

#include <stdio.h>

#define ARRAY_LEN 10

int main(void) {
    int i;
    int numbers[ARRAY_LEN] = { 0 };
    int swapped = 0;

    i = 0;

scan_loop:
    if (i >= ARRAY_LEN) goto scan_end; 
    scanf("%d", &numbers[i]);
    i++;

scan_end: 
    i = 1;

print_loop:
    if (i >= ARRAY_LEN) goto end;
    int x = numbers[i];
    int y = numbers[i - 1];
    if (x > y) goto print_step;
    swapped = 1;
    if (swapped == 1) goto end;             // for efficiency

print_step:
    i++;

end:
    printf("%d\n", swapped);
}