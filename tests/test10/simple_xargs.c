#include <stdio.h>
#include <spawn.h>
#include <sys/wait.h>
#include <string.h>

#define MAX_LINE 1024

int main(int argc, char *argv[]) {
    

    pid_t pid;
    extern char **environ;
    char line[MAX_LINE + 1];
    while (fgets(line, sizeof line, stdin) != NULL) {

        char *pos;
        if ((pos = strchr(line, '\n')) != NULL) {
            *pos = '\0';
        }

        char *command_argv[] = {argv[1], line, NULL};
        posix_spawn(&pid, argv[1], NULL, NULL, command_argv, environ);
        int status;
        waitpid(pid, &status, 0);
    }


    return 1;
}