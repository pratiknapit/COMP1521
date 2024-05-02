#include <stdio.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    // Use fgetc to read the file and printf for output

    // the printf format you need will be similar to "byte %4ld: %3d 0x%02x"

    FILE *fd = fopen(argv[1], "r");

    int i = 0;
    int c;
    while ((c = fgetc(fd)) != EOF) {
        //  print 
        printf("byte %4d: %3d 0x%02x", i, c, c);
        if (isprint(c)) {
            printf(" \'%c\'", (char)c);
        }
        putchar('\n');
        i++;
    }


    fclose(fd);

    return 0;
}