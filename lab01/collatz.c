#include <stdio.h>
#include <stdlib.h>

void collatz(int num);

int main(int argc, char *argv[])
{
	collatz(atoi(argv[1]));
	return EXIT_SUCCESS;
}
 
void collatz(int num) {
	printf("%d\n", num);
	if (num == 1) {
		return;
	}

	if (num % 2 == 0) {
		num = num/2;
	} else {
		num = 3*num + 1;
	}

	return collatz(num);
}

