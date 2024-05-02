#include <stdio.h>
#include <stdlib.h>

int min(int a, int b);
int max(int a, int b);

int main(int argc, char *argv[]) {
	int argnum = argc - 1;
	int nums[argnum];

	for (int i = 0; i < argnum; i++) {
		int j = i+1;
		nums[i] = atoi(argv[j]);
	}

	int mini = (argnum > 0) ? nums[0] : 0;
	int maxi = (argnum > 0) ? nums[0] : 0;
	int sum = (argnum > 0) ? nums[0] : 0;
	int prod = (argnum > 0) ? nums[0] : 0;

	for (int i = 1; i < argnum; i++) {
		mini = min(nums[i], mini);
		maxi = max(nums[i], maxi);
		sum += nums[i];
		prod = prod * nums[i];
		
	}

	int mean = sum / (argc - 1);

	printf("MIN:  %d\n", mini);
	printf("MAX:  %d\n", maxi);
	printf("SUM:  %d\n", sum);
	printf("PROD: %d\n", prod);
	printf("MEAN: %d\n", mean);
	
	return 0;
}

int min(int a, int b) {
	if (a < b) {
		return a;
	} else {
		return b;
	}
}

int max(int a, int b) {
	if (a >= b) {
		return a;
	} else {
		return b;
	}
}