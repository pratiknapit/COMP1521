#include <stdint.h>

/**
 * Return the provided value but with its bytes reversed.
 *
 * For example, 22t2final_q3(0x12345678) => 0x78563412
 *
 * *Note* that your task is to
 * reverse the order of *bytes*,
 * *not* to reverse the order of bits.
 **/

uint32_t _22t2final_q3(uint32_t value) {

    uint32_t return_value = 0;
    uint32_t mask = (1 << 8) - 1;
    
    for (int i = 0; i < 4; i++) {
        uint32_t moved_value = value >> (i * 8);
        uint32_t least_sig_bytes = moved_value & mask;
        return_value = return_value | (least_sig_bytes << (24 - i * 8));
    }

    return return_value;
}
