#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    char *home = getenv("HOME");
    char diary[] = "/.diary";
    FILE *file = fopen(strcat(home, diary), "a");
    if (file == NULL) {
        perror("Error opening file.");
        return 1;
    }

    for (int i = 1; i < argc; i++) {
        fprintf(file, "%s ", argv[i]); // can use fprintf here too
    }

    fprintf(file, "\n");

    fclose(file);
    return 0;

}