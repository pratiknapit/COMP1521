	.text
main:
	# - $t0: int n
	# - $t1: int n % 2
	# - $t2: int n % 3
	
	li 	$v0, 4
	la 	$a0, enter_number
	syscall

	li 	$v0, 5 
	syscall
	move 	$t0, $v0		#scanf("%d", &n);

	rem	$t1, $t0, 2		#n % 2
	bnez	$t1, epilogue		#goto epilogue

	rem 	$t2, $t0, 3		#n % 3
	bnez 	$t2, epilogue 		#goto epilogue

	li 	$v0, 4
	la 	$a0, six_ish		#  printf("six-ish\n");
	syscall

	li 	$v0, 11
	li 	$a0, '\n'		# putchar("\n")
	syscall
	
epilogue:
	li	$v0, 0		# return 0
	jr	$ra	

	.data
enter_number:
	.asciiz "Enter a number: " 
six_ish:
	.asciiz "six-ish"