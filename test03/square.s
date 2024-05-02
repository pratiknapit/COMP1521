main:
	# - $t0: int x
	# - $t1: int i
	# - $t2: int j 

	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0

	li	$t1, 0		# int i = 0;

outer_loop_cond:
	bge	$t1, $t0, outer_loop_end	# if (i >= x) goto outer_loop_end;
	li	$t2, 0

inner_loop_cond:
	bge	$t2, $t0, outer_loop_step

	li	$a0, star			# printf("*");
	li	$v0, 4
	syscall

	addi	$t2, $t2, 1
	j	inner_loop_cond

outer_loop_step:
	addi	$t1, $t1, 1

	li	$a0, '\n'			# printf("%c", '\n');
	li	$v0, 11
	syscall	
	j	outer_loop_cond

outer_loop_end:

end:
	li	$v0, 0		# return 0
	jr	$ra

	.data
star:
	.asciiz	"*"