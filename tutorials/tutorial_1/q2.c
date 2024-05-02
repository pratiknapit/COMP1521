#include <stdio.h>

char *s1 = "abc";

int main(void) {
    char *s2 = "def";

    printf("%s, %s\n", s2, s1); // print character arrays
    printf("%p, %p\n", &s2, &s1); // pointer addresses

    printf("%c, %c\n", s2[0], s1[0]);

    return 0;
}