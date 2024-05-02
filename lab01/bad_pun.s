	.text
main:
	li	$v0, 4		# syscall 4: print_string
	la	$a0, message_1	
	syscall

	li	$v0, 0		# return 0
	jr	$ra

	.data
message_1:
	.asciiz "Well, this was a MIPStake!\n"
	