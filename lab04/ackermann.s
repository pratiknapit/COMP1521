########################################################################
# .DATA
# Here are some handy strings for use in your code.
	.data
prompt_m_str:	.asciiz	"Enter m: "
prompt_n_str:	.asciiz	"Enter n: "
result_str_1:	.asciiz	"Ackermann("
result_str_2:	.asciiz	", "
result_str_3:	.asciiz	") = "

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

	# TODO: set up your stack frame
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	

main__body:

	# TODO: add your function body here
	li	$v0, 4
	la	$a0, prompt_m_str
	syscall

	li	$v0, 5
	syscall
	move	$s0, $v0

	li	$v0, 4
	la	$a0, prompt_n_str
	syscall

	li	$v0, 5
	syscall
	move	$s1, $v0

	move	$a0, $s0
	move	$a1, $s1
	jal	ackermann

	move	$s2, $v0

	li	$v0, 4
	la	$a0, result_str_1
	syscall

	li	$v0, 1
	move	$a0, $s0
	syscall

	li	$v0, 4
	la	$a0, result_str_2
	syscall

	li	$v0, 1
	move	$a0, $s1
	syscall

	li	$v0, 4
	la	$a0, result_str_3
	syscall

	li	$v0, 1
	move	$a0, $s2
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

main__epilogue:

	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end

	li	$v0, 0
	jr	$ra			# return 0;

########################################################################
# .TEXT <ackermann>
	.text
ackermann:

	# Args:
	#   - $a0: int m
	#   - $a1: int n
	# Returns: int
	#
	# Frame:	[]
	# Uses: 	[]
	# Clobbers:	[]
	#
	# Locals:
	#   - .
	#
	# Structure:
	#   - ackermann
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

ackermann__prologue:

	begin
	push	$ra
	push	$s0

ackermann__body:

	move	$s0, $a0
	
	bnez	$s0, ackermann_m_ne_0
	addi	$v0, $a1, 1
	b	ackermann__epilogue

ackermann_m_ne_0:
	bnez	$a1, ackermann_n_ne_0
	
	addi	$a0, $a0, -1
	li	$a1, 1
	jal	ackermann
	b	ackermann__epilogue

ackermann_n_ne_0:

	addi	$a1, $a1, -1		# ackermann(m, n - 1)
	jal	ackermann

	addi	$a0, $s0, -1
	move	$a1, $v0
	jal	ackermann

ackermann__epilogue:

	pop	$s0
	pop	$ra
	end
	jr	$ra
