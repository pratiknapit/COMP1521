#include <pthread.h>
#include "thread_chain.h"

int thread_counter = 0;

void *my_thread(void *data) {
    thread_counter++;
    thread_hello();
    if (thread_counter == 50) {
        return NULL;
    }
    pthread_t new_thread;
    pthread_create(&new_thread, NULL, my_thread, NULL);
    pthread_join(new_thread, NULL);
    
    return NULL;
}

void my_main(void) {
    pthread_t thread_handle;
    pthread_create(&thread_handle, NULL, my_thread, NULL);

    pthread_join(thread_handle, NULL);
}
