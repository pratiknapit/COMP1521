// compile .c files specified as command line arguments
//
// if my_program.c and other_program.c is speicified as an argument then the follow two command will be executed:
// /usr/local/bin/dcc my_program.c -o my_program
// /usr/local/bin/dcc other_program.c -o other_program

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <spawn.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>

#define DCC_PATH "/usr/local/bin/dcc"

extern char **environ;

int main(int argc, char **argv)
{
    pid_t pid;
    for (int i = 1; i < argc; i++) 
    {
        int len = strlen(argv[i]);
        char compiled_file_name[len + 1];
        strcpy(compiled_file_name, argv[i]);
        
        compiled_file_name[len - 2] = '\0';

        char *dcc_argv[] = {DCC_PATH, argv[i], "-o", compiled_file_name, NULL};

        printf("running the command: \"%s %s %s %s\"\n", DCC_PATH, argv[i], "-o", compiled_file_name);

        int ret = posix_spawn(&pid, DCC_PATH, NULL, NULL, dcc_argv, environ);

        if (ret != 0) 
        {
            errno = ret; 
            perror("spawn");
            return 1;
        }

        int exit_status;
        if (waitpid(pid, &exit_status, 0) == -1) 
        {
            perror("waitpid");
            return 1;
        }
    }

    return EXIT_SUCCESS;
}
