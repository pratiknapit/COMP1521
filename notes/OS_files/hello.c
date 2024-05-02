#include <stdio.h>
#include <unistd.h>

/*
FILE DESCRIPTORS
0 stdin
1 stdout
2 stderr
*/

int main(void) {
    // man 3 printf
    printf("Hello!\n");

    // man 2 write -- run this in linux terminal 

    write(1, "Hello!\n", 7); // write "Hello!\n" of size 7 bytes to stdout 

    // Can also use hardcore system call

    syscall(1, 1, "Hello!\n", 7); // the first one specifies a write function, the rest is the same inputs.

    return 0;
}