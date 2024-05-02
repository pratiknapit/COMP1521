#  print the minimum of two integers
main:
	# - $t0 = int x
	# - $t1 = int y

	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0

	li	$v0, 5		# scanf("%d", &y);
	syscall			#
	move	$t1, $v0


print_x:
	bge 	$t0, $t1, print_y	# if (x >= y) goto end_loop
	move	$a0, $t0		# printf("%d\n", x);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	j 	end

print_y:
	move $a0, $t1
	li	$v0, 1
	syscall
	
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall


end:
	li	$v0, 0		# return 0
	jr	$ra
