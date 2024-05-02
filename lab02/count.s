# read a number n and print the integers 1..n one per line
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:                 			# int main(void)
	# Local variables:
	# - $t0: int number
	# - $t1: int i

	la	$a0, prompt		# printf("Enter a number: ");
	li	$v0, 4
	syscall

	li	$v0, 5			# scanf("%d", number);
	syscall
	move 	$t0, $v0

loop_int:
	li	$t1, 1			# i = 1

loop_condition:
	bgt	$t1, $t0, loop_end 	# if (i > number) goto loop_end

loop_body:
	li	$v0, 1
	move	$a0, $t1		# printf("%d", i);
	syscall

	li	$v0, 11	
	li	$a0, '\n'		# putchar('\n');
	syscall

loop_step:
	addi	$t1, $t1, 1		# i = i + 1;
	b 	loop_condition		# goto loop_top

loop_end:
	li	$v0, 0
	jr	$ra		# return 0


	.data
prompt:
	.asciiz "Enter a number: "

