main:
	# - $t0 : int x
	# - $t1 : int y
	# - $t2 : int i

	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0

	li	$v0, 5		# scanf("%d", &y);
	syscall			#
	move	$t1, $v0

loop_init:
	addi 	$t2, $t0, 1			# int i = x + 1
loop_cond:
	bge	$t2, $t1, end			# if (i >= y) goto loop_step;
	beq 	$t2, 13, loop_step		# if (i == 13) goto loop_step;

	move	$a0, $t2			# printf("%d\n", 42);
	li	$v0, 1
	syscall	

	li	$a0, '\n'			# printf("%c", '\n');
	li	$v0, 11
	syscall	

loop_step:
	addi	$t2, $t2, 1			# i = i + 1	
	j 	loop_cond

end:
	li	$v0, 0         			# return 0
	jr	$ra
