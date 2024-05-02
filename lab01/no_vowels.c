#include <stdio.h>
#include <string.h>

char *isVowel(char ch);
// void readChar_print(void);


int main(void) {


	char ch;
	int c = scanf("%c", &ch);
	while (c > 0) {
		if (isVowel(ch) == NULL) {
			printf("%c", ch);
		}
		c = scanf("%c", &ch);
	}

	return 0;
}

/*
void readChar_print(void) { 
	int readChar;
	readChar = getchar();
	while (readChar != EOF) {
		if (isVowel(readChar) == NULL) {
			printf("%c", readChar); 
		}
		readChar = getchar();
	}

}
*/

char *isVowel(char ch) {
	char vowels[] = "aeiouAEIOU";
	char *ret;
	ret = strchr(vowels, ch);
	return ret;
}


