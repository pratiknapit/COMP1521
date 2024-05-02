#include "bit_rotate.h"

// return the value bits rotated left n_rotations
uint16_t bit_rotate(int n_rotations, uint16_t bits) {

    n_rotations %= 16;

    // -3 rotations = 3 rotations to the right = 16 + -3 = 13 rotations to the left

    if (n_rotations < 0) 
        n_rotations += 16;
    
    uint16_t rotate_left = bits << n_rotations;

    // If we rotate left and push bits off, then we also need to bring them back.
    // To do this we can just rotate right. 

    uint16_t rotate_lost_bits_right = bits >> (16 - n_rotations);

    uint16_t rotated_bits = rotate_left | rotate_lost_bits_right;

    return rotated_bits;
}
