#include <stdio.h>
#include <stdint.h>

int main(void) {
    uint8_t b;
    uint32_t u;
    uint8_t *p;

    u = 0x03040506;
    // load first byte of u
    p = (uint8_t *) &u; // p points to u but p is a 8 bit pointer and there for only points to the first 2 bytes of u. Therefore to 
                        // make sure there are no errors with compiling we have to cast this as a (uint8_t *)
    b = *p; // will go to the value where p is pointing i.e. at the first 2 bytes of u. 
    // prints 6 if little-endian
    // and 3 if big-endian
    printf("%d\n", b);
}