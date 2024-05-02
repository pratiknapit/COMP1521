	.text
main:
# Locals:
	# - $t0: int *global_counter

	# Method 1: Implicitly load from the 
	# address of global_counter.
	# mipsy will automatically load the address
	# into a register behind the scenes by
	# generating multiple real instructions.
	lw	$t1, global_counter
	addi	$t1, $t1, 1
	sw	$t1, global_counter	# global_counter = global_counter + 1;

	# Method 2: Explicitly load the address of
	# global_counter into a register.
	li	$v0, 1			# syscall 1: print_int
	la	$t0, global_counter	# store address global_counter at $t0
	lw	$a0, ($t0)
	syscall				# printf("%d", global_counter);

	li	$v0, 11			# syscall 11: print_char
	li	$a0, '\n'
	syscall				# putchar('\n');

	li	$v0, 0
	jr	$ra			# return 0;

	.data
global_counter:
	.word	0			# int global_counter = 0;