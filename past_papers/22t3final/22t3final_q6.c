// COMP1521 22T3 ... final exam, question 6

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int main(int argc, char *argv[]) {

    assert(argc == 3);

    char *filename = argv[1];
    int line = atoi(argv[2]);

    assert(line > 0);

    // ADD YOUR CODE HERE
    FILE *fp = fopen(filename, "r");
    FILE *tmp = fopen("tmpfile", "w");
    int line_counter = 1;
    int c;
    while ((c = fgetc(fp)) != EOF) {
        if (line_counter != line) {
            fputc(c, tmp);
        }
        if (c == '\n') {
            line_counter++;
        }
    }
    fclose(fp);
    fclose(tmp);

    fp = fopen(filename, "w");

    tmp = fopen("tmpfile", "r");

    while ((c = fgetc(tmp)) != EOF) {
        fputc(c, fp);
    }

    fclose(fp);
    fclose(tmp);

    return 0;
}
