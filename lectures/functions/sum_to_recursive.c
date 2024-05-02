#include <stdio.h>

int sum_to(int n);

int main(void) {
    int max = 10;
    int result = sum_to(max);
    printf("Sum 1 ... %d = %d\n", max, result);
    return 0;
}

int sum_to(int n) {
    if (n == 0) {
        return 0;
    } else {
        int result = sum_to(n-1);
        return n + result;
    }
}