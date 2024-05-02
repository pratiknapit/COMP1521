#include <stdio.h>


int main(void) {

    unsigned int a = 938271;        //decimal 
    unsigned int b = 0xAF12;        //hexadecimal 
    unsigned int c = 0b00101010;    //binary (may not work on all systems) 
    unsigned int d = 0123;          //0 octal 

    printf("Dec: %u, %u, %u, %u \n", a, b, c, d); // printing in decimal
    printf("Hex: %x, %x, %x, %x \n", a, b, c, d); // printing in hexadecimal
    printf("Oct: %o, %o, %o, %o \n", a, b, c, d); // printing in octal

    return 0;
}