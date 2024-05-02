#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

/*
FILE DESCRIPTORS
0 stdin
1 stdout
2 stderr
...
3 fd
*/

int main(int argc, char *argv[]) {

    if (argc != 2) {
        fprintf(stderr, "Usage\n");
        return 1; // Not enough arguments
    }

    int fd = open("data.txt", O_RDONLY);
    printf("%d\n", fd); // will return index of FILE DESCRIPTOR

    if (fd < 0) {
        // fprintf(stderr, "data.txt could not open\n");
        perror(argv[1]); // better to use this to raise errno error
        return 0;
    }
    // errno -l --> will give you err returns 

    char c;
    // int num_read = read(fd, &c, 1); // pass in the file descriptor fd from above. 
    // printf("%d\n", num_read);
    // printf("%c\n", c);

    while (read(fd, &c, 1) > 0) {
        printf("%c", c);
    }
    printf("\n");
    
    close(fd);

    return 0;
}
