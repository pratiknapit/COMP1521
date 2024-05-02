// Read three numbers `start`, `stop`, `step`
// Print the integers between `start` and `stop` moving in increments of size `step`

#include <stdio.h>

int main(void) {
    int start, stop, step, i;

    printf("Enter the starting number: ");
    scanf("%d", &start);

    printf("Enter the stopping number: ");
    scanf("%d", &stop);

    printf("Enter the step size: ");
    scanf("%d", &step);

loop_cond_1:
    if (stop > start) goto loop_cond_2; // if stop < start then go straight to loop_cond_2
    if (step > 0) goto loop_cond_2; // if we fail, go straight to loop_cond_2

    i = start;                  // start .... - step ... stop

loop_cond_for_loop:
    if (i < stop) goto end;

print_num:
    printf("%d\n", i);
    i = i + step;
    goto loop_cond_for_loop;


loop_cond_2: // start (2) ... + step (+4) ... stop (26)
    if (stop < start) goto end;
    if (step < 0) goto end;

    i = start; 

loop_cond_for_loop_2:
    if (i > stop) goto end;

print_num_2:
    printf("%d\n", i);
    i = i + step;
    goto loop_cond_for_loop_2;

end:

    return 0;
}
