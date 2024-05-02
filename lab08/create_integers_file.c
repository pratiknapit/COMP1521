#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[]) {

    // use fopen to create the file and fprintf to output to the file. 

    // Use atoi to convert a null-terminated string to an int. 

    // In general, strtol is a more useful function it allows error handling - but this is not required for this exercise.

    FILE *fd = fopen(argv[1], "w");

    int first_int = atoi(argv[2]);

    int last_int = atoi(argv[3]);

    while (first_int <= last_int) {
        fprintf(fd, "%d\n", first_int);
        first_int++;
    }

    fclose(fd);

    return 0;
}