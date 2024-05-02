#include <stdio.h>
#include <stdint.h>

int main(void) {
    // To flip bits use XOR mask at the position where we want to flip we put 1 in the mask.
    uint8_t x = 5;          // 0000 0101
    uint8_t mask = 2;       // 0000 0010 --> XOR will flip bit at position 1 from 0 to 1.
                            // 0000 0111 --> result after OR operation
    printf("%hhu\n", x);

    x = x ^ mask;

    printf("%hhu\n", x);

    x = x ^ mask            // Should flip bit at position 1 back to 0.

    printf("%hhu\n", x);

}