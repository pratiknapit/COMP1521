#include <assert.h>
#include <error.h>
#include <errno.h>
#include <unistd.h>

#define NUM_THREADS 5

void *do_stuff(void *argument) {
    int *arg = argument;

    int *val = malloc(sizeof(int)); 

    if (val == NULL) {
        return NULL;
    }

    printf("Thread processing with arg %d returning %d\n", *arg, val);
    return &val;
}