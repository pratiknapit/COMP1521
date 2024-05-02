#include <stdlib.h>
#include <stdio.h> 

int is_odd1(int n) {
    return ((n % 2) != 0);
}

int is_odd2(int n) {
    // least significant bit is a 1 == odd integer
    // use AND operator and mask to get least significant bit 
    // therefore is we use 0000 0001 == 1 as the mask on n this will tell us what is the least significant bit

    return n & 1;
}