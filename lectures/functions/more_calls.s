main:
	begin			# move frame pointer
	push 	$ra		# save $ra onto stack

	li	$a0, 10		# sum_product(10, 12);
	li	$a1, 12
	jal 	sum_product	# return z --> $v0

	move	$a0, $v0	# printf("%d", z);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# putchar('\n');
	li	$v0, 11
	syscall

	pop 	$ra		# recover $ra from stack
	end			# move frame pointer back

	li	$v0, 0
	jr 	$ra

sum_product:
	begin			# move frame pointer
	push	$ra		# save $ra onto stack
	push	$s0 		# save $s0 onto stack
	push 	$s1		# save $s1 onto stack

	move	$s0, $a0	# preserve $a0 for use after function call
	move 	$s1, $a1	# preserve $a1 for use after function call

	li	$a0, 6		# product(6, 7);
	li	$a1, 7
	jal	product

	add	$v0, $v0, $s0	# add a and b to value returned in $v0
	add	$v0, $v0, $s1	# and put result in $v0 to be returned

	pop 	$s1		# recover $s1 from stack
	pop	$s0		# recover $s0 from stack
	pop	$ra		# recover $ra from stack
	end			# move frame pointer back

	jr	$ra		# return from sum_product

product:			# product doesn't call other functions, so it doesnt need to save any registers

	mul	$v0, $a0, $a1	# return argument * argument 2
	jr	$ra


