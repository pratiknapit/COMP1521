# COMP1521 22T2 ... final exam, question 2

main:
	# $t0 : x
	# $t1 : count
	# $t2 : i
	li	$v0, 5		# syscall 5: read_int
	syscall
	move	$t0, $v0	# read integer into $t0


	# THESE LINES JUST PRINT 42\n
	# REPLACE THE LINES BELOW WITH YOUR CODE

	li	$t1, 0
	li	$t2, 0

start_loop:
	bge	$t2, 32, end_loop

if_state:
	srav 	$t3, $t0, $t2		# $t3 = x >> i
	and	$t3, $t3, 1		# $t3 = (x >> i) & 1

	bne	$t3, 0, end_if
	addi	$t1, 1			# count++


end_if:
	addi	$t2, 1
	j	start_loop


end_loop:

	li	$v0, 1		# syscall 1: print_int
	move	$a0, $t1
	syscall			# printf("42");

	li	$v0, 11		# syscall 11: print_char
	li	$a0, '\n'
	syscall			# printf("\n");
	# REPLACE THE LINES ABOVE WITH YOUR CODE

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
