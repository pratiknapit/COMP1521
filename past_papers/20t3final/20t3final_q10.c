#include <stdio.h>
#include <stdlib.h>
#include <spawn.h>

int main (int argc, char *argv[]) {
    if (argc == 1) {
        argc++;
        argv[1] = "echo";
    }

    char *line = NULL; // will include the new line character
    size_t length = 0;
    while (getline(&line, &length, stdin) != -1) {
        printf("line: %s and %d\n", line, (int)length);
    }

    return 0;
}