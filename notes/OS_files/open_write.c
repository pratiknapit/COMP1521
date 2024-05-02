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

/*
flags is a bit-mask defined in <fcntl.h>
• O_RDONLY — open for reading
• O_WRONLY — open for writing
• O_APPEND — append on each write
• O_RDWR — open object for reading and writing
• O_CREAT — create file if doesn’t exist
• O_TRUNC — truncate to size 0
• flags can be combined e.g. (O_WRONLY|O_CREAT)
• if successful, return file descriptor (small non-negative int)
• if unsuccessful, return -1 and set errno to value indicating reason
*/

int main(int argc, char *argv[]) {
    
    if (argc < 2) {
        fprintf(stderr, "Usage %s filename\n", argv[0]);
        return 1;
    }
    // Open file, either create file if its not created, or if it is created then truncate the file to 0, i.e. reset the file to blank.
    int f1 = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC, 0644); 
    // int f1 = open(argv[1], O_WRONLY | O_CREAT | O_APPEND, 0644); 

    write(f1, "Hello!\n", 7);

    close(f1);

    return 0;
}