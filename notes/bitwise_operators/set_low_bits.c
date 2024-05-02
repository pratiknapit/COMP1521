#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include "assert.h"

#include "print_bits.h"

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <exponent>\n", argv[0]);
        return 1;
    }

    int n = strtol(argv[1], NULL, 0);

    uint32_t mask;

    int n_bits = 8 * sizeof mask;

    assert(n >= 0 && n < n_bits);

    mask = 1;
    mask = mask << n; // 1 ... 0 ... 0 --> will create something like 0001000 depending on n which will shift 1 n-bits to the left.
    mask = mask - 1; // will turn 0001 0000 to 0000 1111. 

    printf("The bottom %d bits of %u are ones:\n", n, mask);
    print_bits(mask, n_bits);
    printf("\n");

    return 0;
}