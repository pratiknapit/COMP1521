main:
	li	$t0, 3
	mul	$t0, $t0, 4
	la	$t1, x		
	add	$t2, $t1, $t0	# $t2 = &x[3] (by adding 12 bytes to the address of x)

	li 	$t3, 17
	sw	$t3, ($t2)


	.data
x:
	.space 	4*10		# int x[10];