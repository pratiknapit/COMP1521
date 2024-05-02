#include <stdio.h>
#include <stdlib.h>

int is_vowel(char ch) {
    return (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u' ||
            ch == 'A' || ch == 'E' || ch == 'I' || ch == 'O' || ch == 'U');
}

int main(int argc, char *argv[]) {

    FILE *fd = fopen(argv[1], "r");
    int ch;

    int count = 0;
    while ((ch = fgetc(fd)) != EOF) {
        if (is_vowel(ch)) {
            count++;
        }
    }

    fclose(fd);
    printf("%d\n", count);
    
    return 0;
}