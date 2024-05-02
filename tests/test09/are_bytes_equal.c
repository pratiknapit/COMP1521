#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {

    FILE *file1 = fopen(argv[1], "r");
    int pos1 = atoi(argv[2]);
    
    FILE *file2 = fopen(argv[3], "r");
    int pos2 = atoi(argv[4]);

    fseek(file1, pos1, SEEK_SET);
    fseek(file2, pos2, SEEK_SET);

    int byte1 = fgetc(file1);
    int byte2 = fgetc(file2);
    //fgetc will raise error by reading outside the range after fseek.
    if (byte1 == EOF || byte2 == EOF) {
        printf("byte %d in %s and byte %d in %s are not the same\n", pos1, argv[1], pos2, argv[3]);
        return 0;
    }

    if (byte1 == byte2) {
        printf("byte %d in %s and byte %d in %s are the same\n", pos1, argv[1], pos2, argv[3]);
    } else {
        printf("byte %d in %s and byte %d in %s are not the same\n", pos1, argv[1], pos2, argv[3]);
    }


    return 0;
}