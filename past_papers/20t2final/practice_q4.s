# this code reads 1 integer and prints it
# change it to read integers until their sum is >= 42
# and then print their sum

main:
	# $t0 : int sum
	li	$s0, 0
start_loop:
	bge	$s0, 42, end_loop

	li	$v0, 5		# scanf("%d", &x);
	syscall			#

	add	$s0, $s0, $v0
	j	start_loop

end_loop:
	move	$a0, $s0	# printf("%d\n", x);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	li	$v0, 0		# return 0
	jr	$ra
