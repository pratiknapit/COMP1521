// An example to show how you can check a bit using AND operator
// and set a bit to 0 using AND

#include <stdio.h>
#include <stdint.h>

int main(void) {
    uint8_t x = 5;          // 0000 0101
    uint8_t mask = 2;       // 0000 0010 --> mask 
                            // 0000 0000 --> result

    uint8_t result = x & mask;

    if (result == 0) { 
        printf("Bit at position 1 in %d, is 0\n", x);
    } else {
        printf("Bit at position 1 in %d, is 1\n", x);
    }

    // How do we set bit at pos 2 to 0

    uint8_t z = 5;          // 0000 0101
    mask = 0xFB             // 1111 1011 --> mask in 8-bit unsigned binary
                            // 0000 0001
    // Here we can set bit in pos 2 to 0 using the mask and and operator.

    result = z & mask;

    printf("%hhu\n", result);


}