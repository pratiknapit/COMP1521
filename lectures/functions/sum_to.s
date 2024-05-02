	.text
main:
main__prolog:
	push 	$ra
	push	$s0
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
sum_to_body:
	li	$t0, 0		# sum = 0
	li	$t1, 1		# i = 1

sum_to_while:
	bgt	$t1, $a0, sum_to_while_end			# while (i <= n)
	add	$t0, $t0, $t1					# sum = sum + i
	addi	$t1, $t1, 1					# i++
	j 	sum_to_while
sum_to_while_end:

	move 	$v0, $t0					# return sum
sum_to_epilog:
	jr	$ra















	.data
msg_sum1:
	.asciiz "Sum 1 ... "
msg_sum2:
	.asciiz " = "

