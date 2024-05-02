# this code reads 1 integer and prints it
# change it to read integers until their sum is >= 42
# and then print theintgers read in reverse order

main:
	# $t0 : i
	# $t1 : sum
	# $t2 : x
	li	$t0, 0
	li	$t1, 0
start_loop:
	bge	$t1, 42, end_loop

	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t2, $v0	# int x;

	la	$t3, numbers
	mul	$t4, $t0, 4	# $t4 = offset memory for integers which take 4 bytes
	add	$t3, $t3, $t4	# $t3 = &numbers[i] 
	sw	$t2, ($t3)	# numbers[i] = x;

	addi	$t0, 1		# i++;

	add	$t1, $t1, $t2	# sum += x;
	j	start_loop

end_loop:

start_loop2:
	ble	$t0, 0, end_loop2	# while (i > 0)
	addi	$t0, -1 		# i--

	la	$t3, numbers
	mul	$t4, $t0, 4	# $t4 = offset memory for integers which take 4 bytes
	add	$t3, $t3, $t4	# $t3 = &numbers[i] 
	lw	$t2, ($t3)	# numbers[i] = x;

	move	$a0, $t2	# printf("%d\n", x);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	j 	start_loop2

end_loop2:

	li	$v0, 0		# return 0
	jr	$ra

	.data
numbers:
	.space	4*1000	