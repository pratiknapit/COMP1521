#include <stdio.h>

// Prints digits from an integer one per line, in reverse order using modulus.

int main(int argc, char *argv[]) {
    int num;
    int rem;

    while (1) {

        // get number
        printf("Integer? ");
        if (scanf("%d", &num) != 1) break;

        // extract the digits
        rem = num;

        do {
            printf("%d\n", rem % 10);
            rem = rem / 10;
        } while (rem != 0);
    }

    return 0;
}