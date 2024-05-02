#include <stdio.h>
#include <string.h>

#define MAX 1024

int main(void) {

	char str[MAX];
	
	while (fgets(str, MAX, stdin) != NULL) {
		int modstr = strlen(str) - 1;
		if (modstr % 2 != 0) {
			fputs(str, stdout);
		}
	}

	return 0;
}
