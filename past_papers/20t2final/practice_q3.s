# this code reads 1 integer and prints it
# add code so that prints 1 iff
# the least significant (bottom) byte of the number read
# is equal to the 2nd least significant byte
# and it prints 0 otherwise

main:
	# $t0 : value
	# $t1 : mask

	li	$v0, 5
	syscall
	move	$t0, $v0

	sll	$t1, 1, 8
	sub	$t1, $t1, 1

	and	$t2, $t0, $t1	# $t2 = value & mask

	sra	$t3, $t0, 8
	and	$t4, $t3, $t1	# $t4 = value >> 8 & mask

	beq 	$t2, $t4, equal
	li	$a0, 0
	j	print

equal:
	li	$a0, 1

print:
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

	li	$v0, 0
	jr	$ra
