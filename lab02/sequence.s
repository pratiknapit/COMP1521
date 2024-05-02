# Read three numbers `start`, `stop`, `step`
# Print the integers bwtween `start` and `stop` moving in increments of size `step`
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:				# int main(void)

	# Local variables:
	# -$t0: int start
	# -$t1: int stop
	# -$t2: int step
	# -$t3: int i

	la	$a0, prompt1	# printf("Enter the starting number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", start);
	syscall
	move 	$t0, $v0	# $t0 = start

	la	$a0, prompt2	# printf("Enter the stopping number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", stop );
	syscall
	move 	$t1, $v0

	la	$a0, prompt3	# printf("Enter the step size: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", step);
	syscall
	move 	$t2, $v0


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

loop_cond_1:
	bgt 	$t1, $t0, loop_cond_2	# if (stop > start) goto loop_cond_2
	bgtz 	$t2, loop_cond_2 	# if (step > 0) goto loop_cond_2;

	move	$t3, $t0		# i = start; 

loop_cond_for_loop:
	blt 	$t3, $t1, end 		# if (i < stop) goto end;

print_num:
	move 	$a0, $t3		# printf("%d", i);
	li 	$v0, 1
	syscall

	li	$a0, '\n'		# putchar('\n');
	li	$v0, 11
	syscall

loop_step:
	add 	$t3, $t3, $t2		# i = i + step;
	b 	loop_cond_for_loop 	# goto loop_cond_for_loop;


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

loop_cond_2:
	blt 	$t1, $t0, end		# if (stop < start) goto end;
	bltz 	$t2, end		# if (step < 0) goto end;

	move 	$t3, $t0		# i = start; 

loop_cond_for_loop_2:
	bgt 	$t3, $t1, end		# if (i > stop) goto end;

print_num_2:
	move 	$a0, $t3		# printf("%d", i);
	li 	$v0, 1
	syscall

	li	$a0, '\n'		# putchar('\n');
	li	$v0, 11
	syscall

loop_step_2:
	add 	$t3, $t3, $t2		# i = i + step;
	b 	loop_cond_for_loop_2	# goto loop_cond_for_loop_2;


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt1:
	.asciiz "Enter the starting number: "
prompt2:
	.asciiz "Enter the stopping number: "
prompt3:
	.asciiz "Enter the step size: "
stupid:
	.asciiz "Check"