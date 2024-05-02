#include <stdio.h>
#include <unistd.h>

// simple example of program replacing itself with exec

int main(void) {
    char *echo_argv[] = {"/bin/echo", "good-bye", "cruel", "world", NULL};
    execv("/bin/echo", echo_argv); // the whole point of execv is we can run any process from this file. Including processes written in other languages.
    // Execv also will wipe the current code process and run only the exec code and return 0;

    //if we get here there has been an error
    perror("execv");
    return 1;
}