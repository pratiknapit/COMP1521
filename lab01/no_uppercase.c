#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main(void) {
	int readChar;
	readChar = getchar();
	while (readChar != EOF) {
		if (isupper(readChar) > 0) {
			readChar = tolower(readChar);
		}
		putchar(readChar);
		readChar = getchar();
	}
	return 0;
}
