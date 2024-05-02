main:
	# Locals:
	# - $t0: int n

	li 	$v0, 4		# syscall 4: print_string
	la 	$a0, enter_number_str
	syscall

	li 	$v0, 5
	syscall
	move 	$t0, $v0

	rem	$t1, $t0, 2	# n % 2
	bnez 	$t1, n_mod_2_neq_0

	li 	$v0, 4		# syscall 4: print_string
	la 	$a0, even_str
	syscall	

	b	epilogue

n_mod_2_neq_0:
	li 	$v0, 4		# syscall 4: print_string
	la 	$a0, odd_str
	syscall		

epilogue:
	li 	$v0, 0
	jr	$ra




	.data
enter_number_str:
	.asciiz "Enter a number: "
even_str:
	.asciiz "even\n"
odd_str:
	.asciiz "odd\n"