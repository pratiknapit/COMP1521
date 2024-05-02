	.text
main:
	addi 	$sp, $sp, -4	# $sp = stack pointer
	sw	$ra, ($sp) 	# store address $ra at address $sp

	jal 	f		# call function f
	jal 	f		# call function f

	lw	$ra, ($sp) 
	addi 	$sp, $sp, 4	# restore stack pointer to original value

	li 	$v0, 0		# return 0 from function main
	jr 	$ra


f:
	la 	$a0, string0
	li 	$v0, 4
	syscall
	jr	$ra



	.data
string0:
	.asciiz "hello Andrew\n"