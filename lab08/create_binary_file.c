#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

    // Use fopen to create the file and fputc to output to the file. 

    // atoi() is used to convert a null-terminated string to an int.
    FILE *fd = fopen(argv[1], "w+");

    for (int i = 2; i < argc; i++) {
        // Convert the command-line argument to an integer.
        int ascii_value = atoi(argv[i]);
        fputc((char)ascii_value, fd);
    }

    return 0;
}