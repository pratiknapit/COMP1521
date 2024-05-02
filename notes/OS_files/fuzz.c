// use fseek to change a random bit in a fiel supplied as a command-line argument

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {

    if (argc != 2) {
        fprintf(stderr, "Usage %s <source file>\n", argv[0]);
        return 1;
    }

    FILE *f = fopen(argv[1], "r+");     // open for reading and writing

    fseek(f, 0, SEEK_END);              // move to end of file

    long n_bytes = ftell(f);            // ftell() will jump to f which is the end of the file and thus get number of bytes in file
    printf("The file contains %ld bytes\n", n_bytes);

    srandom(time(NULL));                // initialise random number, generator with current time

    long target_byte = random() % n_bytes;      // pick a random byte

    fseek(f, target_byte, SEEK_SET);            // move to byte

    int byte = fgetc(f);                // read byte

    int bit = random() % 8;             // pick a random bit

    int new_byte = byte ^ (1 << bit);   // flip the bit - corrupt the bit.

    fseek(f, -1, SEEK_CUR);             // move back to the same position

    fputc(new_byte, f);                 // write the corrupted byte

    fclose(f);

    return 1;
}