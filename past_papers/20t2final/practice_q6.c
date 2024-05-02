#include <stdio.h>

int main(int argc, char *argv[]) {
    FILE *file = fopen(argv[1], "r");

    int c;
    int ascii_count = 0;
    while ((c = fgetc(file)) != EOF) {
        if (c >= 0 && c <= 127) {
            ascii_count++;
        }
    }
    printf("%s contains %d ASCII bytes\n", argv[1], ascii_count);
}