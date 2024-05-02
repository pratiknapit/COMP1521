# Reads 10 numbers into an array
# printing 0 if they are in non-decreasing order
# or 1 otherwise.
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 10

main:
	# Registers:
	#  - $t0: int i
	#  - $t1: temporary result
	#  - $t2: temporary result
	#  TODO: add your registers here

scan_loop__init:
	li	$t0, 0				# i = 0;
	li	$t5, 0				# int swapped = 0;

scan_loop__cond:
	bge	$t0, ARRAY_LEN, scan_loop__end	# while (i < ARRAY_LEN) {

scan_loop__body:
	li	$v0, 5				#   syscall 5: read_int
	syscall					#   
						#
	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1			#
	sw	$v0, ($t2)			#   scanf("%d", &numbers[i]);

	addi	$t0, $t0, 1			#   i++;
	j	scan_loop__cond			# }
scan_loop__end:


	# TODO: add your code here!
check_loop_init:
	li 	$t0, 1				# i = 1;
check_loop_cond:
	bge 	$t0, ARRAY_LEN, check_loop_end	# if (i >= ARRAY_LEN) goto end;

check_loop_body:
	mul 	$t1, $t0, 4
	la 	$t2, numbers
	add	$t2, $t2, $t1
	lw	$t3, ($t2)			# $t3: int x = numbers[i]

	# addi 	$t2, $t2, -4			
	lw	$t4, -4($t2)			# $t4: int y = numbers[i-1]

	bgeu 	$t3, $t4, check_loop_step	# if (x >= y) goto check_loop_step;

	li 	$t5, 1				# swapped = 1

	b	check_loop_end
	
check_loop_step:
	addi 	$t0, $t0, 1
	j 	check_loop_cond

check_loop_end:


print_swap:
	li	$v0, 1				# syscall 1: print_int
	move	$a0, $t5			#
	syscall					# printf("%d", swapped)

	li	$v0, 11				# syscall 11: print_char
	li	$a0, '\n'			#
	syscall					# printf("%c", '\n');

	li	$v0, 0
	jr	$ra				# return 0;

	.data
numbers:
	.word	0:ARRAY_LEN			# int numbers[ARRAY_LEN] = {0};
