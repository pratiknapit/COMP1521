#include <assert.h>
#include <stdint.h>
#include <stdlib.h>

// given a uint32_t value,
// return 1 iff the least significant (bottom) byte
// is equal to the 2nd least significant byte; and
// return 0 otherwise
int practice_q2(uint32_t value) {
    // PUT YOUR CODE HERE
    uint32_t mask = (1 << 8) - 1;

    return (value & mask) == (value >> 8 & mask);
}
