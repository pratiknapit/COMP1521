#include <stdlib.h>
#include <pthread.h>

void *increment_and_sleep(void *arg);

void costly_addition(int num)
{
    // TODO: Implement this function and remove this comment.
    // Create num threads that will each run increment_and_sleep
    pthread_t threads[num];
    for (int i = 0; i < num; i++) {
        pthread_create(&threads[i], NULL, increment_and_sleep, NULL);
    }

    for (int i = 0; i < num; i++) {
        pthread_join(threads[i], NULL);
    }

}
