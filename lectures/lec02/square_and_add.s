	.text
main:
	#Locals:
	# - $t0: int a
	# - $t1: int b

	li          $v0, 4                  # syscall 4: print_string
	la          $a0, prompt1_msg        # load address 
	syscall                             # printf("Enter a number: ")

	li          $v0, 5                  # sycall 5: read_int
	syscall
	move        $t0, $v0                # scanf("%d", &a)

	li          $v0, 4                  # syscall 4: print_string
	la          $a0, prompt2_msg        # 
	syscall                             # printf("Enter another number: ")

	li          $v0, 5                  # sycall 5: read_int
	syscall
	move        $t1, $v0                # scanf("%d", &b)

	li          $v0, 4                  # syscall 4: print_string
	la          $a0, result_msg_1       # 
	syscall                             # printf("The sum of the squares of ")

	li          $v0, 1                  # syscall 1: print_int
	move        $a0, $t0                #
	syscall                             # printf("%d", a); 

	li	    $v0, 4			        # syscall 4: print_string
	la	    $a0, result_msg_2	    # 
	syscall				                # printf(" and ");

	li	    $v0, 1			        # syscall 1: print_int
	move	    $a0, $t1		        #
	syscall				                # printf("%d", b);

	li	    $v0, 4			        # syscall 4: print_string
	la	    $a0, result_msg_3	    #
	syscall				                # printf(" is ");

	mul	    $t0, $t0, $t0		    # a = a * a;
	mul	    $t1, $t1, $t1		    # b = b * b;

	li	    $v0, 1			        # syscall 1: print_int
	add	    $a0, $t0, $t1		    # 
	syscall				                # printf("%d", a + b);

	li	    $v0, 11			        # syscall 11: print_char
	la	    $a0, '\n'		        # 
	syscall				                # putchar('\n');


	li	    $v0, 0
	jr	    $ra			            # return 0;



	.data
prompt1_msg:
	.asciiz	"Enter a number: "
prompt2_msg:
	.asciiz	"Enter another number: "
result_msg_1:
    .asciiz	"The sum of the squares of "
result_msg_2:
	.asciiz	" and "
result_msg_3:
	.asciiz	" is "