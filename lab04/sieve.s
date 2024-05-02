# Sieve of Eratosthenes
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 1000

main:
	# - $t0: int i
	# - $t1: int j

	# TODO: add your code here
loop_init:
	li	$t0, 2				# int i = 2
loop_cond:
	bge	$t0, ARRAY_LEN, loop_end	# if (i >= ARRAY_LEN): goto loop_end
	la 	$t2, prime
	add	$t3, $t2, $t0
	lb	$t4, ($t3) 
	bne	$t4, 1, loop_step		# if (prime[i] != 1): goto loop_step
loop_body:
	li	$v0, 1				# printf("%d\n", i)
	move	$a0, $t0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

inner_loop_init:
	li	$t1, 0				# int j = 2 * i
	mul	$t1, 2, $t0
inner_loop_cond:
	bge	$t1, ARRAY_LEN, loop_step	# if (j >= ARRAY_LEN) goto loop_step
inner_loop_body:
	la 	$t2, prime			# $t2 = &prime[0]
	add	$t3, $t2, $t1			# $t3 = &prime[0] + j bytes = &prime[j]
	li	$t4, 0
	sb	$t4, ($t3)			# $t4 = prime[j]
inner_loop_step:
	add	$t1, $t1, $t0			# j = j + i
	j	inner_loop_cond

loop_step:
	add	$t0, $t0, 1			# i++
	j	loop_cond

loop_end:
	li	$v0, 0
	jr	$ra			# return 0;

	.data
prime:
	.byte	1:ARRAY_LEN		# uint8_t prime[ARRAY_LEN] = {1, 1, ...};
