#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
The stat.c lecture example prints the permissions as an octal number.

The stat system call returns meta-information about files.

The inode man page describes how permissions are represented.

You may find some of the following approaches useful:

Use the provided masks documented in inode to extract the permissions from the st_mode field of the struct stat returned by stat.
Break the permissions component of st_mode into groups of 3 bits and handle each group in a loop.
Or perhaps best of all, iterate over all 9 bits, and make use of a fixed array of characters and the modulo (%) operator to calculate an index into the array.
*/

/*
Write a C program, which is given one or more pathnames as command line arguments, it should print
one line for each pathnames which gives the permissions of the file or directory.
*/

void stat_file(char *pathname);

int main(int argc, char *argv[]) {

    for (int arg = 1; arg < argc; arg++) {
        stat_file(argv[arg]);
        printf(" %s\n", argv[arg]);
    }

    return 0;
}

void stat_file(char *pathname) {
    struct stat s;
    if (stat(pathname, &s) != 0) {
        perror(pathname);
        exit(1);
    }
    
    char permissions[10];

    if(S_ISDIR(s.st_mode)) {
        printf("d");
    } else {
        printf("-");
    }

    // st_mode is a bitwise-or of these values (& others):

    permissions[0] = (s.st_mode & S_IRUSR) ? 'r' : '-'; // S_IRUSR 0000400 owner has read permission
    permissions[1] = (s.st_mode & S_IWUSR) ? 'w' : '-';
    permissions[2] = (s.st_mode & S_IXUSR) ? 'x' : '-';
    permissions[3] = (s.st_mode & S_IRGRP) ? 'r' : '-';
    permissions[4] = (s.st_mode & S_IWGRP) ? 'w' : '-';
    permissions[5] = (s.st_mode & S_IXGRP) ? 'x' : '-';
    permissions[6] = (s.st_mode & S_IROTH) ? 'r' : '-';
    permissions[7] = (s.st_mode & S_IWOTH) ? 'w' : '-';
    permissions[8] = (s.st_mode & S_IXOTH) ? 'x' : '-';
    permissions[9] = '\0';

    // Print permission string
    printf("%s", permissions);

}