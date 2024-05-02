# Integers

printf("%d", 0x2A) --> prints 42 where the integer is represented in hexadecimal using 0x prefix

printf("%d", 052) --> prints 42 where the integer is represented in octal (based 8)

printf("%d", 0b101010) --> prints 42 where the integer is represented in binary (on most C compilers)

## Unsigned ints

CSE machines with 32 bits, can store 2^32 numbers. Therefore we can store values from 0 ... 2^32 - 1 for int datatype.

Use 2's complement for negative representation of unsigned integers. The reason for this is because addition and other operations are easier in the 2's complement representation. 

- Positive and zero represented in obvious way.
- For an n-bit binary number the representation of -b is 2^n - b. 

*What does this 8 bit 2's complement binary number represent in decimal?*
11111111

In 8-bit binary this represents = 1 * 2^7 + 1 * 2^6 + ... + 1 + 2^0
                                = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128
                                = 255
Thus, working backward this must represent the unsigned integer -1 in 8-bit 2's complement representation.

Another algorithm is to flip all bits and add 1. This will give 00000001. Then working backwards this would mean that flipping all bits of 00000001 and adding 1 will give us 11111111, therefore our original number must of been -1. 

## Other data types

- char = 1 byte = 8 bits
- short = 2 bytes = 16 bits
- int = 4 bytes = 32 bits
- double = 8 bytes = 64 bits

sizeof variable -> returns number of bytes to store variable
sizeof (type) -> returns number of bytes to store *type*. 

## Endian-ness

0x3FAB1234 = 4 byte address in hexadecimal.

In some system we store each byte either from most significant byte at the smallest memory address (big endian): 

BIG endian : 3F, AB, 12, 34

or system will store each byte from least significant byte at the smallest memory address (small endian):

SMALL endian : 34, 12, AB, 3F 

