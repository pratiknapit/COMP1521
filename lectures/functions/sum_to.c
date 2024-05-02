// An example of a C program with a function with 
// one input and a return value

#include <stdio.h>

int sum_to(int n);

int main(void) {
    int max = 10;
    int result = sum_to(max);
    printf("Sum 1 ... %d = %d\n", max, result);
    return 0;
}

int sum_to(int n) {
    int sum = 0;
    int i = 1;
    while (i <= n) {
        sum = sum + i;
        i++;
    }
    return sum;
}