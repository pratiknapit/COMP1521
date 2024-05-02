# COMP1521 20T3 final exam Q4 starter code

# This code reads 1 integer and prints it

# Change it to read integers until low is greater or equal to high
# then print their difference

main:
	li 	$t0, 0			# int low = 0;
	li	$t1, 100		# int high = 100;

loop:
	bgt 	$t0, $t1, loop_end	# while (low < high) {

	li	$v0, 5			# scanf("%d", &x);
	syscall 	

	move	$t3, $v0		# int x;

	add	$t0, $t0, $t3		# low = low + x;
	sub	$t1, $t1, $t3		# high = high - x;

	j 	loop

loop_end:

	sub	$t4, $t0, $t1		# low - high

	move	$a0, $t4		# printf("%d\n", x);
	li	$v0, 1
	syscall

	li	$a0, '\n'		# printf("%c", '\n');
	li	$v0, 11
	syscall

	li	$v0, 0		#	 return 0
	jr	$ra
