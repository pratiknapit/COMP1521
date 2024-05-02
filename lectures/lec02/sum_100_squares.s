	.text
main:
	# - $t0: int sum
	# - $t1: int i
	# - $t2: int i * i

	li 	$t0, 0			# int sum = 0;

loop__init:
	li 	$t1, 1			# int i = 1;

loop__cond:
	bgt 	$t1, 100, loop_end 	# if (i > 100) goto loop_end;

loop__body:
	mul	$t2, $t1, $t1		# int square = i * i;
	add	$t0, $t0, $t2		# sum += square;

loop__step:
	addi	$t1, $t1, 1		# i++;
	b	loop__cond		# unconditional jump

loop_end:
	li 	$v0, 1			# syscall 1: print_int
	move	$a0, $t0
	syscall

	li	$v0, 11
	li 	$a0, '\n'
	syscall

	li	$v0, 0		# return 0
	jr	$ra