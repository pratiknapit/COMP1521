#include <stdio.h>

/*
FILE *fopen(const char *pathname, const char *mode)
    • fopen() is stdio.h equivalent to open()
    • mode is string of 1 or more characters including:
    • r open text file for reading.
    • w open text file for writing truncated to 0 zero length if it exists created if does not exist
    • a open text file for writing writes append to it if it exists created if does not exist

fopen returns a FILE * pointer
    • FILE is stdio.h equivalent to file descriptors
    • FILE is an opaque struct - we can not access fields
    • FILE stores file descriptor
    • FILE may also for efficiency store buffered data,
*/

int main(int argc, char *argv[]) {
    
    FILE *fd = fopen(argv[1], "r");
    //int fd = open(argv[1], O_RDONLY);

    if (fd == NULL) {
        perror(argv[1]);
        return 1;
    }

    int c;
    // read(fd, &c, 1);
    while ((c = fgetc(fd)) != EOF) {
        printf("%c", c);
    }

    //close(fd);
    fclose(fd);
    
    return 0;
}