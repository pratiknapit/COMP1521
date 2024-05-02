# PRATIK NAPIT, 09/03/2024

########################################################################
# .DATA
# Here are some handy strings for use in your code.

	.data
prompt_str:
	.asciiz "Enter a random seed: "
result_str:
	.asciiz "The random result is: "
random:
	.asciiz "0xFFFF"

########################################################################
# .TEXT <main>
	.text
main:

	# Args: void
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - main
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

main__prologue:
	begin

	# TODO: add code to set up your stack frame here 
	push	$ra			# save $ra onto the stack

main__body:
	# TODO: complete your function body here

	la	$a0, prompt_str		# printf("Enter a random seed: ");
	li	$v0, 4
	syscall

	li	$v0, 5			# scanf("%d", &random_seed);
	syscall

	move	$a0, $v0		# random_seed
	jal	seed_rand		# seed_rand(random_seed);

	li	$a0, 100		# int value = rand(100);
	jal	rand					

	# move	$a0, $v0		# move return value to $a0
	# jal	add_rand		# add_rand(value)

	

	# move 	$a0, $v0		
	# jal	sub_rand		# sub_rand(value)

	# move	$a0, $v0
	# jal	seq_rand		# seq_rand(value)

	move 	$t0, $v0		# store final value in $t0

	la	$a0, result_str		# printf("The random result is: ");
	li	$v0, 4
	syscall

	move 	$a0, $t0		# get final value
	li	$v0, 1			# print final value
	syscall

	li	$a0, '\n'		# putchar('\n');
	li	$v0, 11
	syscall


main__epilogue:
	# TODO: add code to clean up stack frame here

	pop	$ra
	end

	li	$v0, 0
	jr	$ra				# return 0;

########################################################################
# .TEXT <add_rand>
	.text
add_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - add_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

add_rand__prologue:
	begin

	# TODO: add code to set up your stack frame here
	push 	$ra
	push	$s0		# by pushing $s0 onto the stack, I know that later if I call another function, 
				# by convention of adding $s registers onto the stack that the value of $s0 will be maintained in the scope on this function.


add_rand__body:

	# TODO: complete your function body here

	move 	$s0, $a0	# store passed in value
	li	$a0, 0xFFFF
	jal 	rand		# rand(0xFFFF)
	add	$v0, $v0, $s0	# $v0 = return = value + rand(value)

add_rand__epilogue:
	
	# TODO: add code to clean up stack frame here
	pop	$s0
	pop	$ra
	end

	jr	$ra


########################################################################
# .TEXT <sub_rand>
	.text
sub_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - sub_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

sub_rand__prologue:
	begin

	# TODO: add code to set up your stack frame here
	push	$ra
	push	$s0

sub_rand__body:

	# TODO: complete your function body here
	move 	$s0, $a0	# store passed in value
	jal 	rand		# rand(value)
	sub	$v0, $v0, $s0	# $v0 = return = value - rand(value)


sub_rand__epilogue:
	
	# TODO: add code to clean up stack frame here

	pop	$s0
	pop	$ra
	end

	jr	$ra

########################################################################
# .TEXT <seq_rand>
	.text
seq_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - seq_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

seq_rand__prologue:
	begin

	# TODO: add code to set up your stack frame here
	push 	$ra
	push	$s0

seq_rand__body:

	# TODO: complete your function body here

	move	$s0, $a0		# save input value into $s0
	li	$a0, 100		
	jal	rand			# rand(100);
	move 	$t0, $v0		# store limit in $t0
	
	li	$t1, 0			# int i = 0;

if_start:
	bge	$t1, $t0, if_end	# if (i >= limit) goto if_end
	move 	$a0, $s0
	jal	add_rand
	move	$s0, $v0		# value = add_rand(value);
	addi	$t1, $t1, 1		# i++;
	j	if_start

if_end:
	move 	$v0, $s0		# return value


seq_rand__epilogue:
	
	# TODO: add code to clean up stack frame here

	pop	$s0
	pop	$ra
	end
	
	jr	$ra



##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following,
## but you may find it useful to read through.
## You'll be calling these functions from your code.
##

OFFLINE_SEED = 0x7F10FB5B

########################################################################
# .DATA
	.data
	
# int random_seed;
	.align 2
random_seed:
	.space 4


########################################################################
# .TEXT <seed_rand>
	.text
seed_rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int seed
	# Returns: void
	#
	# Frame:	[]
	# Uses:		[$a0, $t0]
	# Clobbers:	[$t0]
	#
	# Locals:
	#   - $t0: offline_seed
	#
	# Structure:
	#   - seed_rand

	li	$t0, OFFLINE_SEED		# const unsigned int offline_seed = OFFLINE_SEED;
	xor	$t0, $a0			# random_seed = seed ^ offline_seed;
	sw	$t0, random_seed

	jr	$ra				# return;

########################################################################
# .TEXT <rand>
	.text
rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int n
	# Returns:
	#   - $v0: int
	#
	# Frame:    []
	# Uses:     [$a0, $v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#   - $t0: int rand
	#
	# Structure:
	#   - rand

	lw	$t0, random_seed 		# unsigned int rand = random_seed;
	multu	$t0, 0x5bd1e995  		# rand *= 0x5bd1e995;
	mflo	$t0
	addiu	$t0, 12345       		# rand += 12345;
	sw	$t0, random_seed 		# random_seed = rand;

	remu	$v0, $t0, $a0    
	jr	$ra              		# return rand % n;
