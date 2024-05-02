# Read a number and print positive multiples of 7 or 11 < n
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:				# int main(void) {
	# Local variables
	# $t0 : int number
	# $t1 : int i 
	# $t2 : int i % 7 & int i % 11

	la	$a0, prompt	# printf("Enter a number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall
	move	$t0, $v0	# $t0 = number

loop_int:
	li	$t1, 1		# int i = 1

loop_cond:
	bge	$t1, $t0, end 	# if (i >= number) goto loop_end;

loop_body:
	rem	$t2, $t1, 7 	# (i % 7 == 0)
	beqz	$t2, print_num	# goto print_num;
	rem 	$t2, $t1, 11	# (i % 11 == 0)
	beqz	$t2, print_num  # goto print_num;
	b	loop_step 	# goto loop_step;

print_num:

	move	$a0, $t1	# printf("%d", i);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

loop_step:
	addi	$t1, $t1, 1
	b	loop_cond

end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter a number: "
