main:
	li 	$t0, 17		# t0 = 17
	la	$t1, x		# load address x into $t1
	sw	$t0, ($t1) 	# store word at $t0 into address $t1
				# I.e. x = 17
	
	li 	$t0, 25
	la	$t1, y
	sw	$t0, ($t1)

	la	$t0, x		# load address x at $t0
	lw	$t1, ($t0)	# load word from address $t0 into $t1
	la 	$t0, y
	lw	$t2, ($t0)
	add	$t3, $t1, $t2
	la	$t0, z
	sw	$t3, 0($t0)	# z = x + y

	li	$v0, 1
	la 	$t0, z
	lw	$a0, 0($t0)
	syscall			# printf("%d", z);

	li	$v0, 11		# syscall 11: print_char
	li	$a0, '\n'	#
	syscall			# putchar('\n');

	li	$v0, 0		
	jr	$ra		# return 0;




	.data
x:
	.space	4		# int x;
y:	
	.space	4
z:
	.space	4


