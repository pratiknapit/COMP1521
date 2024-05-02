// COMP1521 22T2 ... final exam, question 5

#include <stdio.h>

void print_bytes(FILE *file, long n) {
	// TODO
	if (n >= 0) {
		int c;
		int i = 0;
		while ((c = fgetc(file)) != EOF && i < n) {
			printf("%c", c);
			i++;
		}
		putchar('\n');
		return;
	}
}
