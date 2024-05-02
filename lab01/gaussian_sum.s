# A simple MIPS program that calculates the Gaussian sum between two numbers

# int main(void)
# {
#   int number1, number2;
#
#   printf("Enter first number: ");
#   scanf("%d", &number1);
#
#   printf("Enter second number: ");
#   scanf("%d", &number2);
#
#   int gaussian_sum = ((number2 - number1 + 1) * (number1 + number2)) / 2;
#
#   printf("The sum of all numbers between %d and %d (inclusive) is: %d\n", number1, number2, gaussian_sum);
#
#   return 0;
# }
	.text
main:
	# Locals:
	# - $t0: int number1
	# - $t1: int number2
	# - $t2: number1 + number2
	# - $t3: number2 - number1
	# - $t3: number2 - number1 + 1
	# - $t3: t3 * t2
	# - $t3: int gaussian_sum

	li 	$v0, 4 		# syscall 4: print_string
	la 	$a0, prompt1	
	syscall			# print prompt 1

	li 	$v0, 5		# syscall 5: read_int
	syscall
	move	$t0, $v0	# scanf("%d", &number1)

	li 	$v0, 4 		# syscall 4: print_string
	la 	$a0, prompt2	
	syscall			# print prompt 2

	li 	$v0, 5		# syscall 5: read_int
	syscall
	move	$t1, $v0	# scanf("%d", &number2)

	add 	$t2, $t0, $t1	# number 1 + number 2
	sub 	$t3, $t1, $t0 	# number 2 - number 1
	add 	$t3, $t3, 1	# number2 - number1 + 1
	mul 	$t3, $t3, $t2 	# (number2 - number1 + 1) * (number 1 + number 2)
	div 	$t3, $t3, 2	# ((number2 - number1 + 1) * (number1 + number2)) / 2

	li 	$v0, 4 		# syscall 4: print_string
	la 	$a0, answer1	# print answer1
	syscall

	li 	$v0, 1 		# syscall 1: print_int
	move 	$a0, $t0	
	syscall			# print number1

	li 	$v0, 4 		# syscall 4: print_string
	la 	$a0, answer2	# print answer2
	syscall

	li 	$v0, 1 		# syscall 1: print_int
	move 	$a0, $t1	
	syscall			# print number2

	li 	$v0, 4 		# syscall 4: print_string
	la 	$a0, answer3	# print answer3
	syscall

	li 	$v0, 1 		# syscall 1: print_int
	move 	$a0, $t3	
	syscall			# print gaussian_sum

	li	$v0, 11			# syscall 11: print_char
	la	$a0, '\n'		# 
	syscall				# putchar('\n');

	li	$v0, 0
	jr	$ra          	# return


	.data
prompt1: .asciiz "Enter first number: "
prompt2: .asciiz "Enter second number: "

answer1: .asciiz "The sum of all numbers between "
answer2: .asciiz " and "
answer3: .asciiz " (inclusive) is: "
