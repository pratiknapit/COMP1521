#include <stdio.h>
#include <sys/stat.h>
#include <stdlib.h>


int main(int argc, char* argv[]) {

    int remove_num = atoi(argv[1]);

    FILE *read_file = fopen(argv[2], "r");

    FILE *new_file = fopen(argv[3], "w");

    struct stat s;
    stat(argv[2], &s);
    int file_size = (int)s.st_size;

    int c;
    if (file_size <= remove_num) {
        fclose(read_file);
        fclose(new_file);
        return 0;
    }

    int i = 0;
    while ((c = fgetc(read_file)) != EOF && i < (file_size - remove_num)) {
        fputc(c, new_file);
        i++;
    }

    return 0;
}