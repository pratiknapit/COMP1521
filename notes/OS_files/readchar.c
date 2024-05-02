#include <stdio.h>
#include <unistd.h> // System call read

/*
FILE DESCRIPTORS
0 stdin
1 stdout
2 stderr
*/

int main(void) {
    // int c = getchar();
    // printf("%c\n", c);

    // read system call - man 2 read

    char c;
    read(0, &c, 1);
    
    printf("%c\n", c);

    return 0;
}