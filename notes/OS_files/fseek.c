/*
int fseek(FILE *stream, long offset, int whence);
• fseek() is stdio equivalent to lseek(), just like lseek():
• offset is in units of bytes, and can be negative
• whence can be one of …
• SEEK_SET — set file position to offset from start of file
• SEEK_CUR — set file position to offset from current position
• SEEK_END — set file position to offset from end of file
• for example:
fseek(stream, 42, SEEK_SET); // move to after 42nd byte in file
fseek(stream, 58, SEEK_CUR); // 58 bytes forward from current position
fseek(stream, -7, SEEK_CUR); // 7 bytes backward from current position
fseek(stream, -1, SEEK_END); // move to before last byte in file
*/

#include <stdio.h>

int main(int argc, char *argv[]) {

    if (argc != 2) {
        fprintf(stderr, "Usage: %s <source file>\n", argv[0]);
        return 1;
    }

    FILE *input_stream = fopen(argv[1], "rb"); //rb is unnecessary but its means read byte

    // move to a position 1 byte from end of file and read 1 byte
    fseek(input_stream, -1, SEEK_END);
    printf("Last byte of the file is 0x%02x\n", fgetc(input_stream));

    //move to a position 0 bytes from start of file and read 1 byte
    fseek(input_stream, 0, SEEK_SET);
    printf("first byte of the file is 0x%02x\n", fgetc(input_stream));

    return 0;
} 