	.text
main:
	li 	$t0, 42		# $t0 = 42
	la 	$t1, answer	# store answer address at $t1
	sb 	$t0, 0($t1)	# store 42 in byte at address labelled answer

	lb	$a0, 0($t1)	# load $a0 from same address
	li	$v0, 1		# syscall 1: print int
	syscall

	li 	$a0, '\n'	# putchar('\n')
	li 	$v0, 11
	syscall

end:
	li 	$v0, 0		# return 0
	jr 	$ra

	.data
answer:
	.space 1		# set aside 1 byte and associate label answer with its address