#include<stdio.h>
#include<unistd.h>

// simple exmple of program replacing itself with exec. NOTE WE ARE NOT MAKING A NEW PROCESS.
int main(void) {
    printf("In exec.c %d\n", getpid());
    sleep(3);
    char *echo_argv[] = {"./process_example", NULL};
    execv("./process_example", echo_argv);

    // if we get here there has been an error
    perror("execv");
    return 1;
}