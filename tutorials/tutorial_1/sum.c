#include <stdio.h>

int sum(int k);

int main(void) {
    int num = sum(6);
    printf("%d\n", num);

    return 0;
}

int sum(int k) {
    if (k == 1) {
        return 1;
    }

    return k + sum(k-1);
}