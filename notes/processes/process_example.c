#include <stdio.h>
#include <unistd.h>

int main(void) {
    printf("In process_example main\n");
    printf("P: my pid is %d.\n", getpid());
    printf("P: my parent is %d.\n", getppid());
    sleep(3);

    return 0;
}