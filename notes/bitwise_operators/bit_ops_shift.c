// extract the nth bit from a value, assuming 1sb 

// assume n is 4

// 7654 3210 
//     &
// 0001 0000
// XXXx XXXX
// Shift right by 4 bits
// 0000 XXXx
// 0000 0001 -> mask
// 0000 000x

int get_nth_bit(uint64_t value, int n) {
    uint64_t shifted_value = value >> n; //shift so that nth bit is now least significant bit
    int bit = shifted_value & 1;         //use mask 1 and & operator to get nth bit value of either 1 or 0. 
    return bit;
}

//print the bottom how_many_bits bits of value
void print_bits(uint64_t value, int how_many_bits) {
    for (int i = how_many_bits - 1; i >= 0; i--) {
        int bit = get_nth_bit(value, i);
        printf("%d", bit);
    }
}

