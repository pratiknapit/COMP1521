#include <stdio.h>

int main(int argc, char *argv[]) {

    FILE *file = fopen(argv[1], "r");

    int num_set = 0;
    int c;
    while ((c = fgetc(file)) != EOF) {
        for (int i = 0; i < 8; i++) {
            if (((c >> i) & 1) == 1) {
                num_set++;
            }
        }
    }

    fclose(file);

    printf("%s has %d bits set\n", argv[1], num_set);
    
    return 0;
}