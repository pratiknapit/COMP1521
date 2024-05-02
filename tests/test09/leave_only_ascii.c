#include <stdio.h>

int main(int argc, char *argv[]) {

    FILE *file = fopen(argv[1], "r");
    FILE *output_file = fopen("./output_file", "w");

    int c;
    while ((c = fgetc(file)) != EOF) {
        if (c < 128 || c > 255) {
            fputc(c, output_file);
        }
    }

    fclose(file);
    fclose(output_file);

    FILE *overwrite_file = fopen(argv[1], "w");
    output_file = fopen("./output_file", "r");

    while ((c = fgetc(output_file)) != EOF) {
        fputc(c, overwrite_file);
    }

    fclose(overwrite_file);
    fclose(output_file);

    return 0;
}