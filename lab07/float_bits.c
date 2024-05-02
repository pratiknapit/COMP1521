// Extract the 3 parts of a float using bit operations only

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "floats.h"

// separate out the 3 components of a float
float_components_t float_bits(uint32_t f) {
    float_components_t components;
    components.sign = (f >> 31) & 1;
    components.exponent = (f >> 23) & 0xFF;
    uint32_t mask = (1 << 23) - 1;
    components.fraction = f & mask;

    return components;
}

// given the 3 components of a float
// return 1 if it is NaN, 0 otherwise
int is_nan(float_components_t f) {
    // A float is NaN if the exponent bits are all 1s and the fraction is nonZero
    return (f.exponent == 0xff) && (f.fraction != (uint32_t)0);
}

// given the 3 components of a float
// return 1 if it is inf, 0 otherwise
int is_positive_infinity(float_components_t f) {
    // Positive infinity has all exponent bits set to 1 and fraction bits set to 0
    return !f.sign && (f.exponent == 0xff) && (f.fraction == (uint32_t)0);
}

// given the 3 components of a float
// return 1 if it is -inf, 0 otherwise
int is_negative_infinity(float_components_t f) {
    // PUT YOUR CODE HERE

    return f.sign && (f.exponent == 0xff) && (f.fraction == (uint32_t)0);
}

// given the 3 components of a float
// return 1 if it is 0 or -0, 0 otherwise
int is_zero(float_components_t f) {
    // Zero has all exponent bits set to 0 and all fraction bits set to 0

    return (f.exponent == 0) && (f.fraction == 0);
}
