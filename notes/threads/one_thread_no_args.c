#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

void *run_thread(void *argument) {
    printf("I am a created thread\n");
    return NULL;
}

int main(void) {
    pthread_t thread_id1;

    int ret = pthread_create(&thread_id1, NULL, run_thread, NULL);

    if (ret < 0) {
        perror("create");
    }

    // Wait for thread to finish.
    //ret = pthread_join(thread_id1, NULL);
    sleep(5);
    printf("In main thread.\n");

    if (ret < 0) {
        perror("join");
    }

    printf("Main thread finished.\n");

    return 0;
}