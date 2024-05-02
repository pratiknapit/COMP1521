#include <stdio.h>

int global_counter = 0;

int main(void) {
    // Increment the global counter.
    // The following is the same as global_counter = global_counter + 1 (generally)
    global_counter++;
    
    printf("%d", global_counter);
    putchar('\n');
}