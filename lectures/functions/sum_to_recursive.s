.text
main:
main__prolog:
	push 	$ra
	push	$s0		# we want to restrore these for other functions in case.
main_body:

	li	$s0, 10		# int max = 10;
	move 	$a0, $s0	# need to use $s0 to save the value because this value may get destroyed during the function
	jal 	sum_to		# int result = sum_to(max) -- result = $v0
	move	$t1, $v0	# $t1 = result


	li	$v0, 4		# printf("Sum 1 ... ")
	la	$a0, msg_sum1
	syscall

	li	$v0, 1		# printf("%d", max)
	move 	$a0, $s0
	syscall 
	
	li	$v0, 4		# printf(" = ")
	la	$a0, msg_sum2
	syscall

	li	$v0, 1		# printf("%d", result)
	move 	$a0, $t1
	syscall 

	li	$v0, 11		# putchar('\n')
	li	$a0, '\n'		
	syscall

	li	$v0, 0
main__epilog:
	pop 	$s0
	pop	$ra
	jr	$ra

sum_to:
sum_to_prolog:
	push	$ra
	push	$s0			# we want to push so that we do not destroy $s0 when this function is finished
sum_to_body:
	move 	$s0, $a0		# n is saved to $s0

sum_to_if:
	bnez 	$a0, sum_to_else	# if (n == 0)
	li	$v0, 0			# return 0
	j	sum_to_epilog	

sum_to_else:
	sub	$a0, $s0, 1		# n - 1
	jal	sum_to			# int result = sum_to(n-1);
	add	$v0, $v0, $zero		# n + result

sum_to_if_end:


sum_to_epilog:
	pop	$s0
	pop	$ra
	jr	$ra















	.data
msg_sum1:
	.asciiz "Sum 1 ... "
msg_sum2:
	.asciiz " = "

