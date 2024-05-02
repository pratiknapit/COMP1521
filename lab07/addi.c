// generate the encoded binary for an addi instruction, including opcode and operands

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

#include "addi.h"

// return the encoded binary MIPS for addi $t,$s, i
uint32_t addi(int t, int s, int i) {

    uint32_t op_code = (uint32_t)1 << 29;

    uint32_t register_1 = (uint32_t)s << 21;

    uint32_t register_2 = (uint32_t)t << 16;

    uint32_t imm = (uint16_t)i;

    uint32_t result = op_code | register_1 | register_2 | imm;

    return result;

}
