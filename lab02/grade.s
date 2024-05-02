# read a mark and print the corresponding UNSW grade
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# Pratik Napit, 26/02/2023

#![tabsize(8)]

main:
	# Locals:
	# - $t0: int mark

	la	$a0, prompt		# printf("Enter a mark: ");
	li	$v0, 4
	syscall

	li	$v0, 5			# scanf("%d", mark);
	syscall
	move 	$t0, $v0 		# scanf("%d", &mark);

	blt	$t0, 50, print_fl 	# if (mark < 50) goto print_fl;
	blt	$t0, 65, print_ps 	# if (mark < 65) goto print_ps;
	blt	$t0, 75, print_cr 	# if (mark < 75) goto print_cr;
	blt	$t0, 85, print_dn 	# if (mark < 85) goto print_dn;
	b	print_hd		# else print HD

print_fl:	
	la	$a0, fl
	li	$v0, 4
	syscall	
	b epilogue

print_ps:	
	la	$a0, ps
	li	$v0, 4
	syscall	
	b epilogue

print_cr:	
	la	$a0, cr
	li	$v0, 4
	syscall	
	b epilogue

print_dn:	
	la	$a0, dn
	li	$v0, 4
	syscall	
	b epilogue

print_hd:	
	la	$a0, hd
	li	$v0, 4
	syscall	
	b epilogue
	
epilogue:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter a mark: "
fl:
	.asciiz "FL\n"
ps:
	.asciiz "PS\n"
cr:
	.asciiz "CR\n"
dn:
	.asciiz "DN\n"
hd:
	.asciiz "HD\n"
