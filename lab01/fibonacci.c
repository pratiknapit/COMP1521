#include <stdio.h>
#include <stdlib.h>

#define SERIES_MAX 30

int fibo(int num);

int main(void) {
    int num;
    int scan_out = scanf("%d", &num);
    while (scan_out != EOF) {
        int val = fibo(num);
        printf("%d\n", val);
        scan_out = scanf("%d", &num);
    }
    return EXIT_SUCCESS;
}

int fibo(int num) {
    if (num == 1 || num == 0) {
        return num;
    }
    return fibo(num-1) + fibo(num-2);
}