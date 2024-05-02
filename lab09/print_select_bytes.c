#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        perror(argv[1]);
        return 1;
    }

    for (int i = 2; i < argc; i++) {
        fseek(file, atoi(argv[i]), SEEK_SET);
        int c = fgetc(file);
        if (isprint(c)) {
            printf("%d - 0x%02X - \'%c\'", c, c, c);
        } else {
            printf("%d - 0x%02X", c, c);
        }
        putchar('\n');
    }

    fclose(file);
    return 0;
}