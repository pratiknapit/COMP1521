# Reads 10 numbers into an array and prints numbers which are
# larger than the final number read.

# Constants
ARRAY_LEN = 10

main:
	# Registers:
	#  - $t0: int i
	#  - $t1: temporary result
	#  - $t2: temporary result
	#  TODO: add your registers here
	#  - $t4: int final_number

	# TODO: modify the code below to behave like
	# the provided C program.


scan_loop__init:
	li	$t0, 0							# i = 0;
scan_loop__cond:
	bge	$t0, ARRAY_LEN, scan_loop__end	# while (i < ARRAY_LEN) 

scan_loop__body:
	li	$v0, 5							#   syscall 5: read_int
	syscall								#   
										#	
	mul	$t1, $t0, 4						#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers					#
	add	$t2, $t2, $t1					#
	sw	$v0, ($t2)						#   scanf("%d", &numbers[i]);

	addi	$t0, $t0, 1					#   i++;
	j	scan_loop__cond					# 
scan_loop__end:
	move 	$t4, $v0					# final_number = numbers[i] when i = 9;

print_loop__init:
	li	$t0, 0							# i = 0
print_loop__cond:
	bge	$t0, ARRAY_LEN, print_loop__end # while (i < ARRAY_LEN) {

print_loop__body:
	mul	$t1, $t0, 4						#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers					#
	add	$t2, $t2, $t1					#	offset $t1 by $t0 (i) * 4 == $t2 such that &numbers[i] = $t2
	lw	$t3, ($t2)						#	load numbers[i] to $t3

	blt	$t3, $t4, print_loop_step		# 	if (numbers[i] < final_number) goto print_loop_step

	move 	$a0, $t3						# 	
	li	$v0, 1							#   syscall 1: print_int
	syscall								#   printf("%d", numbers[i]);

	li	$v0, 11							#   syscall 11: print_char
	li	$a0, '\n'						#
	syscall								#   printf("%c", '\n');

print_loop_step:

	addi	$t0, $t0, 1					#   i++;
	j	print_loop__cond				# }


print_loop__end:

	li	$v0, 0				
	jr	$ra								# return 0;

	.data
numbers:
	.word	0:ARRAY_LEN					# int numbers[ARRAY_LEN] = {0};
