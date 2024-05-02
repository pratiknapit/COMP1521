################################################################################
# COMP1521 24T1 -- Assignment 1 -- Railroad Runners!
#
#
# !!! IMPORTANT !!!
# Before starting work on the assignment, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
# Instructions to configure your text editor can be found here:
#   https://cgi.cse.unsw.edu.au/~cs1521/24T1/resources/mips-editors.html
# !!! IMPORTANT !!!
#
#
# This program was written by PRATIK-NAPIT (z5311922)
# on 15/03/2024.
#
# Version 1.0 (2024-02-27): Team COMP1521 <cs1521@cse.unsw.edu.au>
#
################################################################################

#![tabsize(8)]

# ------------------------------------------------------------------------------
#                                   Constants
# ------------------------------------------------------------------------------

# -------------------------------- C Constants ---------------------------------
TRUE = 1
FALSE = 0

JUMP_KEY = 'w'
LEFT_KEY = 'a'
CROUCH_KEY = 's'
RIGHT_KEY = 'd'
TICK_KEY = '\''
QUIT_KEY = 'q'

ACTION_DURATION = 3
CHUNK_DURATION = 10

SCROLL_SCORE_BONUS = 1
TRAIN_SCORE_BONUS = 1
BARRIER_SCORE_BONUS = 2
CASH_SCORE_BONUS = 3

MAP_HEIGHT = 20
MAP_WIDTH = 5
PLAYER_ROW = 1

PLAYER_RUNNING = 0
PLAYER_CROUCHING = 1
PLAYER_JUMPING = 2

STARTING_COLUMN = MAP_WIDTH / 2

TRAIN_CHAR = 't'
BARRIER_CHAR = 'b'
CASH_CHAR = 'c'
EMPTY_CHAR = ' '
WALL_CHAR = 'w'
RAIL_EDGE = '|'

SAFE_CHUNK_INDEX = 0
NUM_CHUNKS = 14

# --------------------- Useful Offset and Size Constants -----------------------

# struct BlockSpawner offsets
BLOCK_SPAWNER_NEXT_BLOCK_OFFSET = 0
BLOCK_SPAWNER_SAFE_COLUMN_OFFSET = 20
BLOCK_SPAWNER_SIZE = 24

# struct Player offsets
PLAYER_COLUMN_OFFSET = 0
PLAYER_STATE_OFFSET = 4
PLAYER_ACTION_TICKS_LEFT_OFFSET = 8
PLAYER_ON_TRAIN_OFFSET = 12
PLAYER_SCORE_OFFSET = 16
PLAYER_SIZE = 20

SIZEOF_PTR = 4


# ------------------------------------------------------------------------------
#                                 Data Segment
# ------------------------------------------------------------------------------
	.data

# !!! DO NOT ADD, REMOVE, OR MODIFY ANY OF THESE DEFINITIONS !!!

# ----------------------------- String Constants -------------------------------

print_welcome__msg_1:
	.asciiz "Welcome to Railroad Runners!\n"
print_welcome__msg_2_1:
	.asciiz "Use the following keys to control your character: ("
print_welcome__msg_2_2:
	.asciiz "):\n"
print_welcome__msg_3:
	.asciiz ": Move left\n"
print_welcome__msg_4:
	.asciiz ": Move right\n"
print_welcome__msg_5_1:
	.asciiz ": Crouch ("
print_welcome__msg_5_2:
	.asciiz ")\n"
print_welcome__msg_6_1:
	.asciiz ": Jump ("
print_welcome__msg_6_2:
	.asciiz ")\n"
print_welcome__msg_7_1:
	.asciiz "or press "
print_welcome__msg_7_2:
	.asciiz " to continue moving forward.\n"
print_welcome__msg_8_1:
	.asciiz "You must crouch under barriers ("
print_welcome__msg_8_2:
	.asciiz ")\n"
print_welcome__msg_9_1:
	.asciiz "and jump over trains ("
print_welcome__msg_9_2:
	.asciiz ").\n"
print_welcome__msg_10_1:
	.asciiz "You should avoid walls ("
print_welcome__msg_10_2:
	.asciiz ") and collect cash ("
print_welcome__msg_10_3:
	.asciiz ").\n"
print_welcome__msg_11:
	.asciiz "On top of collecting cash, running on trains and going under barriers will get you extra points.\n"
print_welcome__msg_12_1:
	.asciiz "When you've had enough, press "
print_welcome__msg_12_2:
	.asciiz " to quit. Have fun!\n"

get_command__invalid_input_msg:
	.asciiz "Invalid input!\n"

main__game_over_msg:
	.asciiz "Game over, thanks for playing 😊!\n"

display_game__score_msg:
	.asciiz "Score: "

handle_collision__barrier_msg:
	.asciiz "💥 You ran into a barrier! 😵\n"
handle_collision__train_msg:
	.asciiz "💥 You ran into a train! 😵\n"
handle_collision__wall_msg:
	.asciiz "💥 You ran into a wall! 😵\n"

maybe_pick_new_chunk__column_msg_1:
	.asciiz "Column "
maybe_pick_new_chunk__column_msg_2:
	.asciiz ": "
maybe_pick_new_chunk__safe_msg:
	.asciiz "New safe column: "

get_seed__prompt_msg:
	.asciiz "Enter a non-zero number for the seed: "
get_seed__prompt_invalid_msg:
	.asciiz "Invalid seed!\n"
get_seed__set_msg:
	.asciiz "Seed set to "

TRAIN_SPRITE:
	.asciiz "🚆"
BARRIER_SPRITE:
	.asciiz "🚧"
CASH_SPRITE:
	.asciiz "💵"
EMPTY_SPRITE:
	.asciiz "  "
WALL_SPRITE:
	.asciiz "🧱"

PLAYER_RUNNING_SPRITE:
	.asciiz "🏃"
PLAYER_CROUCHING_SPRITE:
	.asciiz "🧎"
PLAYER_JUMPING_SPRITE:
	.asciiz "🤸"

# ------------------------------- Chunk Layouts --------------------------------

SAFE_CHUNK: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, '\0',
CHUNK_1: # char[]
	.byte EMPTY_CHAR, CASH_CHAR, EMPTY_CHAR, WALL_CHAR, CASH_CHAR, CASH_CHAR, CASH_CHAR, BARRIER_CHAR, '\0',
CHUNK_2: # char[]
	.byte CASH_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, BARRIER_CHAR, EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, CASH_CHAR, '\0',
CHUNK_3: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, '\0',
CHUNK_4: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, EMPTY_CHAR, CASH_CHAR, '\0',
CHUNK_5: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, CASH_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, EMPTY_CHAR, TRAIN_CHAR, EMPTY_CHAR, EMPTY_CHAR, '\0',
CHUNK_6: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, CASH_CHAR, BARRIER_CHAR, EMPTY_CHAR, EMPTY_CHAR, CASH_CHAR, CASH_CHAR, EMPTY_CHAR, BARRIER_CHAR, '\0'
CHUNK_7: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, WALL_CHAR, WALL_CHAR, WALL_CHAR, WALL_CHAR, WALL_CHAR, WALL_CHAR, WALL_CHAR, '\0',
CHUNK_8: # char[]
	.byte CASH_CHAR, EMPTY_CHAR, CASH_CHAR, EMPTY_CHAR, CASH_CHAR, EMPTY_CHAR, CASH_CHAR, EMPTY_CHAR, CASH_CHAR, EMPTY_CHAR, '\0',
CHUNK_9: # char[]
	.byte CASH_CHAR, EMPTY_CHAR, EMPTY_CHAR, WALL_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, '\0',
CHUNK_10: # char[]
	.byte CASH_CHAR, CASH_CHAR, CASH_CHAR, CASH_CHAR, CASH_CHAR, CASH_CHAR, CASH_CHAR, CASH_CHAR, CASH_CHAR, CASH_CHAR, '\0',
CHUNK_11: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, CASH_CHAR, WALL_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, TRAIN_CHAR, '\0',
CHUNK_12: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, CASH_CHAR, '\0',
CHUNK_13: # char[]
	.byte EMPTY_CHAR, EMPTY_CHAR, EMPTY_CHAR, WALL_CHAR, WALL_CHAR, '\0',

CHUNKS:	# char*[]
	.word SAFE_CHUNK, CHUNK_1, CHUNK_2, CHUNK_3, CHUNK_4, CHUNK_5, CHUNK_6, CHUNK_7, CHUNK_8, CHUNK_9, CHUNK_10, CHUNK_11, CHUNK_12, CHUNK_13

# ----------------------------- Global Variables -------------------------------

g_block_spawner: # struct BlockSpawner
	# char *next_block[MAP_WIDTH], offset 0
	.word 0, 0, 0, 0, 0
	# int safe_column, offset 20
	.word STARTING_COLUMN

g_map: # char[MAP_HEIGHT][MAP_WIDTH]
	.space MAP_HEIGHT * MAP_WIDTH

g_player: # struct Player
	# int column, offset 0
	.word STARTING_COLUMN
	# int state, offset 4
	.word PLAYER_RUNNING
	# int action_ticks_left, offset 8
	.word 0
	# int on_train, offset 12
	.word FALSE
	# int score, offset 16
	.word 0

g_rng_state: # unsigned
	.word 1

# !!! Reminder to not not add to or modify any of the above !!!
# !!! strings or any other part of the data segment.        !!!

# ------------------------------------------------------------------------------
#                                 Text Segment
# ------------------------------------------------------------------------------
	.text

############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################

################################################################################
#
# Implement the following functions,
# and check these boxes as you finish implementing each function.
#
#  SUBSET 0
#  - [x] print_welcome
#  SUBSET 1
#  - [x] get_command
#  - [x] main
#  - [x] init_map
#  SUBSET 2
#  - [x] run_game
#  - [x] display_game
#  - [x] maybe_print_player
#  - [x] handle_command
#  SUBSET 3
#  - [x] handle_collision
#  - [ ] maybe_pick_new_chunk
#  - [ ] do_tick
#  PROVIDED
#  - [X] get_seed
#  - [X] rng
#  - [X] read_char
################################################################################

################################################################################
# .TEXT <print_welcome>
print_welcome:
	# Subset:   0
	#
	# Args:     void
	#
	# Returns:  void
	#
	# Frame:    []
	# Uses:     [$v0, $a0]
	# Clobbers: [$v0, $a0]
	#
	# Locals:
	#   - 
	#
	# Structure:
	#   print_welcome
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

print_welcome__prologue:
print_welcome__body:
	# TODO: implement `print_welcome` here!

	li	$v0, 4
	la	$a0, print_welcome__msg_1	# printf("Welcome to Railroad Runners!\n");
	syscall

	li	$v0, 4
	la	$a0, print_welcome__msg_2_1 	# printf("Use the following keys to control your character: (%s):\n", PLAYER_RUNNING_SPRITE);
	syscall

	li	$v0, 4
	la	$a0, PLAYER_RUNNING_SPRITE	
	syscall

	li	$v0, 4				
	la	$a0, print_welcome__msg_2_2
	syscall

	li	$v0, 11				# printf("%c: Move left\n", LEFT_KEY);
	la	$a0, LEFT_KEY
	syscall

	li	$v0, 4
	la	$a0, print_welcome__msg_3
	syscall

	li	$v0, 11				# printf("%c: Move right\n", RIGHT_KEY);
	la	$a0, RIGHT_KEY
	syscall

	li	$v0, 4
	la	$a0, print_welcome__msg_4
	syscall

	li	$v0, 11				# printf("%c: Crouch (%s)\n", CROUCH_KEY, PLAYER_CROUCHING_SPRITE);
	la	$a0, CROUCH_KEY
	syscall

	li	$v0, 4
	la	$a0, print_welcome__msg_5_1
	syscall

	li	$v0, 4				
	la	$a0, PLAYER_CROUCHING_SPRITE
	syscall

	li	$v0, 4
	la	$a0, print_welcome__msg_5_2
	syscall

	li	$v0, 11				# printf("%c: Jump (%s)\n", JUMP_KEY, PLAYER_JUMPING_SPRITE);
	la	$a0, JUMP_KEY
	syscall

	li	$v0, 4
	la	$a0, print_welcome__msg_6_1
	syscall

	li	$v0, 4				
	la	$a0, PLAYER_JUMPING_SPRITE
	syscall

	li	$v0, 4
	la	$a0, print_welcome__msg_6_2
	syscall

	li	$v0, 4				# printf("or press %c to continue moving forward.\n", TICK_KEY);
	la	$a0, print_welcome__msg_7_1
	syscall

	li	$v0, 11					
	la	$a0, TICK_KEY
	syscall

	li	$v0, 4				
	la	$a0, print_welcome__msg_7_2
	syscall

	li	$v0, 4					# printf("You must crouch under barriers (%s)\n", BARRIER_SPRITE);
	la	$a0, print_welcome__msg_8_1
	syscall

	li	$v0, 4					
	la	$a0, BARRIER_SPRITE
	syscall

	li	$v0, 4				
	la	$a0, print_welcome__msg_8_2
	syscall

	li	$v0, 4					# printf("and jump over trains (%s).\n", TRAIN_SPRITE);
	la	$a0, print_welcome__msg_9_1
	syscall

	li	$v0, 4					
	la	$a0, TRAIN_SPRITE
	syscall

	li	$v0, 4				
	la	$a0, print_welcome__msg_9_2
	syscall

	li	$v0, 4					#     printf("You should avoid walls (%s) and collect cash (%s).\n", WALL_SPRITE, CASH_SPRITE);
	la	$a0, print_welcome__msg_10_1
	syscall

	li	$v0, 4					
	la	$a0, WALL_SPRITE
	syscall

	li	$v0, 4				
	la	$a0, print_welcome__msg_10_2
	syscall

	li	$v0, 4					
	la	$a0, CASH_SPRITE
	syscall

	li	$v0, 4				
	la	$a0, print_welcome__msg_10_3
	syscall

	li	$v0, 4					# printf(
        						# "On top of collecting cash, running on trains and going under barriers "
        						# "will get you extra points.\n");
	la	$a0, print_welcome__msg_11
	syscall

	# printf("When you've had enough, press %c to quit. Have fun!\n", QUIT_KEY);

	li	$v0, 4				
	la	$a0, print_welcome__msg_12_1
	syscall	

	li	$v0, 11					
	la	$a0, QUIT_KEY
	syscall

	li	$v0, 4				
	la	$a0, print_welcome__msg_12_2
	syscall	

print_welcome__epilogue:
	jr	$ra


################################################################################
# .TEXT <get_command>
	.text
get_command:
	# Subset:   1
	#
	# Args:     void
	#
	# Returns:  $v0: char
	#
	# Frame:    [$ra]
	# Uses:     [$v0, $a0, $t0]
	# Clobbers: [$v0, $a0, $t0]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   get_command
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

get_command__prologue:
	begin
	push $ra

get_command__body:

	jal	read_char			# char input = read_char();
	move	$t0, $v0

	# if (input == QUIT_KEY || input == JUMP_KEY || input == LEFT_KEY ||
        #     input == CROUCH_KEY || input == RIGHT_KEY || input == TICK_KEY) {
        #     return input;
        # }
quit:
	bne	$t0, QUIT_KEY, jump
	move	$v0, $t0
	j 	get_command__epilogue
jump:
	bne	$t0, JUMP_KEY, left
	move	$v0, $t0
	j 	get_command__epilogue
left:
	bne	$t0, LEFT_KEY, crouch
	move	$v0, $t0
	j 	get_command__epilogue

crouch:
	bne	$t0, CROUCH_KEY, right
	move	$v0, $t0
	j 	get_command__epilogue
right:
	bne	$t0, RIGHT_KEY, tick
	move	$v0, $t0
	j 	get_command__epilogue
tick:
	bne	$t0, TICK_KEY, end_if
	move	$v0, $t0
	j 	get_command__epilogue

end_if:
	li	$v0, 4				# printf("Invalid input!\n");
	la	$a0, get_command__invalid_input_msg
	syscall	

	j	get_command__body

get_command__epilogue:

	pop $ra
	end

	jr	$ra


################################################################################
# .TEXT <main>
	.text
main:
	# Subset:   1
	#
	# Args:     void
	#
	# Returns:  $v0: int
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $v0, $a1, $a2, $a3]
	# Clobbers: [$a0, $v0, $a1, $a2, $a3]
	#
	# Locals:
	#   - 
	#
	# Structure:
	#   main
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

main__prologue:
	begin
	push 	$ra
main__body:
	jal	print_welcome			# print_welcome();
	jal	get_seed			# get_seed();

	la	$a0, g_map			# init_map(g_map);
	jal	init_map


do_loop:
	la	$a0, g_map			# display_game(g_map, &g_player);	
	la	$a1, g_player
	jal	display_game

	jal	get_command			# get_command()
	move	$a3, $v0

	la	$a0, g_map			# g_map, &g_player, &g_block_spawner
	la	$a1, g_player
	la	$a2, g_block_spawner

	jal	run_game			# run_game(g_map, &g_player, &g_block_spawner, get_command())

	beq 	$v0, 0, print_end_game
	j 	do_loop

print_end_game:
	li	$v0, 4				# printf("Game over, thanks for playing 😊!\n");
	la	$a0, main__game_over_msg
	syscall	

main__epilogue:
	pop	$ra
	end

	li	$v0, 0				# return 0
	jr	$ra


################################################################################
# .TEXT <init_map>
	.text
init_map:
	# Subset:   1
	#
	# Args:
	#   - $a0: char map[MAP_HEIGHT][MAP_WIDTH]
	#
	# Returns:  None
	#
	# Frame:    [$ra]
	# Uses:     [$t0, $t1, $t2, $t3, $t4, $t5]
	# Clobbers: [$t0, $t1, $t2, $t3, $t4, $t5]
	#
	# Locals:
	#   - $t0, $t1, $t2, $t3, $t4, $t5
	#
	# Structure:
	#   init_map
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

init_map__prologue:
	begin
	push	$ra


init_map__body:

outer_loop_init:
	li	$t0, 0				# int i = 0;
outer_loop_cond:
	bge	$t0, MAP_HEIGHT, outer_loop_end
outer_loop_body:

inner_loop_init:
	li	$t1, 0				# int j = 0;
inner_loop_cond:
	bge	$t1, MAP_WIDTH, inner_loop_end
inner_loop_body:
	mul	$t2, $t0, MAP_WIDTH
	add	$t3, $t2, $t1
	add	$t4, $t3, $a0			# $t4 = map[i][j]
	li	$t5, EMPTY_CHAR
	sb	$t5, ($t4)			# map[i][j] = EMPTY_CHAR

inner_loop_iter:
	addi	$t1, $t1, 1
	j	inner_loop_cond
inner_loop_end:
	addi	$t0, $t0, 1
	j	outer_loop_cond
outer_loop_end:	
	li	$t0, 6				#  map[6][0] = WALL_CHAR;
	mul	$t1, $t0, MAP_WIDTH 
	addi	$t2, $t1, 0
	add	$t3, $t2, $a0
	li	$t4, WALL_CHAR
	sb	$t4, ($t3)		

	li	$t0, 6				#  map[6][1] = TRAIN_CHAR;
	mul	$t1, $t0, MAP_WIDTH 
	addi	$t2, $t1, 1
	add	$t3, $t2, $a0
	li	$t4, TRAIN_CHAR
	sb	$t4, ($t3)	

	li	$t0, 6				#  map[6][2] = CASH_CHAR;
	mul	$t1, $t0, MAP_WIDTH 
	addi	$t2, $t1, 2
	add	$t3, $t2, $a0
	li	$t4, CASH_CHAR
	sb	$t4, ($t3)		

	li	$t0, 8				#  map[8][2] = BARRIER_CHAR;
	mul	$t1, $t0, MAP_WIDTH 
	addi	$t2, $t1, 2
	add	$t3, $t2, $a0
	li	$t4, BARRIER_CHAR
	sb	$t4, ($t3)	


init_map__epilogue:
	pop	$ra
	end

	jr	$ra


################################################################################
# .TEXT <run_game>
	.text
run_game:
	# Subset:   2
	#
	# Args:
	#   - $a0: char map[MAP_HEIGHT][MAP_WIDTH]
	#   - $a1: struct Player *player
	#   - $a2: struct BlockSpawner *block_spawner
	#   - $a3: char input
	#
	# Returns:  $v0: int
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$s0, $s1, $a0, $a1, $a3]
	# Clobbers: [$a0, $a1]
	#
	# Locals:
	#   - 
	#
	# Structure:
	#   run_game
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

run_game__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
run_game__body:

	bne	$a3, QUIT_KEY, end_run_game_if
	li	$v0, 0
	j	run_game__epilogue

end_run_game_if:

	move	$s0, $a0		# Save map and player inputs in case they get changed
	move	$s1, $a1		# in the handle_command function
	jal	handle_command

	move	$a0, $s0
	move	$a1, $s1
	jal	handle_collision

run_game__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	end

	jr	$ra


################################################################################
# .TEXT <display_game>
	.text
display_game:
	# Subset:   2
	#
	# Args:
	#   - $a0: char map[MAP_HEIGHT][MAP_WIDTH]
	#   - $a1: struct Player *player
	#
	# Returns:  None
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3]
	# Uses:     [$s0, $s1, $s2, $s3, $a0, $a1, $v0]
	# Clobbers: [$t0, $t1, $t2, $t3, $t4, $t5, $a0, $a1, $v0]
	#
	# Locals:
	#   - $t0 : MAP_HRIGHT - 1
        #   - $t1 - $t5
	#
	# Structure:
	#   display_game
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

display_game__prologue:
	begin
	push	$ra
	push	$s0 				# $a0
	push	$s1				# $a1
	push	$s2				# $t0
	push	$s3				# $t1

display_game__body:
	move	$s0, $a0			# $s0 = &map
	move	$s1, $a1			# $s1 = &player

for_loop_1_init:

	li	$s2, MAP_HEIGHT			# $s2 = int i = 19
	addi	$s2, $s2, -1

for_loop_1_cond:

	blt	$s2, 0, for_loop_end		# if (i < 0) goto for_loop_end

for_loop_1_body:

for_loop_2_init:

	li	$s3, 0				# int j = 0;

for_loop_2_cond:

	bge	$s3, MAP_WIDTH, for_loop_1_iter # if (j >= MAP_WIDTH) goto for_loop_1_iter

for_loop_2_body:

	li	$v0, 11				# putchar(RAIL_EDGE);
	la	$a0, RAIL_EDGE
	syscall

	move	$a0, $s1			# restore original inputs in case they have been changed by putchar()
	move	$a1, $s2
	move	$a2, $s3
	jal	maybe_print_player
	beq	$v0, 1, if_print_end		# if return of maybe_print_player == 1 then goto end

	mul	$t2, $s2, MAP_WIDTH
	add	$t3, $t2, $s3			# $t3 will contain the required offset			
	add	$t4, $t3, $s0			# $t4 = &map[i][j]

	lb	$t5, ($t4)			# $t5 : char map_char = map[i][j];

empty:
	bne	$t5, EMPTY_CHAR, barrier	# mapchar != EMPTY_CHAR goto next if check
	li	$v0, 4
	la	$a0, EMPTY_SPRITE
	syscall

barrier:
	bne	$t5, BARRIER_CHAR, train	
	li	$v0, 4
	la	$a0, BARRIER_SPRITE
	syscall

train:
	bne	$t5, TRAIN_CHAR, cash	
	li	$v0, 4
	la	$a0, TRAIN_SPRITE
	syscall

cash:
	bne	$t5, CASH_CHAR, wall	
	li	$v0, 4
	la	$a0, CASH_SPRITE
	syscall

wall:
	bne	$t5, WALL_CHAR, if_print_end	
	li	$v0, 4
	la	$a0, WALL_SPRITE
	syscall

if_print_end:

	li	$v0, 11				# putchar(RAIL_EDGE);
	la	$a0, RAIL_EDGE
	syscall

for_loop_2_iter:

	addi	$s3, $s3, 1
	j	for_loop_2_cond

for_loop_1_iter:

	li	$v0, 11				# putchar('\n');
	li	$a0, '\n'
	syscall

	addi	$s2, $s2, -1
	j	for_loop_1_cond

for_loop_end:	

	li	$v0, 4
	la	$a0, display_game__score_msg
	syscall


	# get player-->score
	
	lw	$t1, 16($s1)			# $t2 : int player-->score
	
	li	$v0, 1
	move	$a0, $t1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall


display_game__epilogue:

	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra


################################################################################
# .TEXT <maybe_print_player>
	.text
maybe_print_player:
	# Subset:   2
	#
	# Args:
	#   - $a0: struct Player *player
	#   - $a1: int row
	#   - $a2: int column
	#
	# Returns:  $v0: int
	#
	# Frame:    [...]
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   maybe_print_player
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

maybe_print_player__prologue:
	push	$ra

maybe_print_player__body:

if_print_cond:
	bne	$a1, PLAYER_ROW, end_if_statement	# if $a1 != PLAYER_ROW, goto end_if_statement
	
	lw	$t1, PLAYER_COLUMN_OFFSET($a0)
	bne	$a2, $t1, end_if_statement

if_print_body:

running:

	lw	$t1, PLAYER_STATE_OFFSET($a0)
	bne	$t1, PLAYER_RUNNING, crouching

	li	$v0, 4
	li	$a0, PLAYER_RUNNING_SPRITE
	syscall

	j	end_ifs

crouching:

	bne	$t1, PLAYER_CROUCHING, jumping

	li	$v0, 4
	li	$a0, PLAYER_CROUCHING_SPRITE
	syscall

	j	end_ifs

jumping:

	bne	$t1, PLAYER_JUMPING, end_ifs

	li	$v0, 4
	li	$a0, PLAYER_JUMPING_SPRITE
	syscall

	j	end_ifs

end_ifs:
	li	$v0, 1 				# return TRUE = 1
	j	maybe_print_player__epilogue

end_if_statement:
	li	$v0, 0

maybe_print_player__epilogue:
	pop	$ra
	jr	$ra


################################################################################
# .TEXT <handle_command>
	.text
handle_command:
	# Subset:   2
	#
	# Args:
	#   - $a0: char map[MAP_HEIGHT][MAP_WIDTH]
	#   - $a1: struct Player *player
	#   - $a2: struct BlockSpawner *block_spawner
	#   - $a3: char input
	#
	# Returns:  None
	#
	# Frame:    [$ra]
	# Uses:     [$a0, $a1, $a2, $a3]
	# Clobbers: [$t0, $t1]
	#
	# Locals:
	#   - $t0, $t1
	#
	# Structure:
	#   handle_command
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

handle_command__prologue:
	begin
	push	$ra

	# $a0 - char map[MAP_HEIGHT][MAP_WIDTH]
	# $a1 - struct Player *player
	# $a2 - struct BlockSpawner *block_spawner
	# $a3 - char input 
handle_command__body:

left_key:

	bne 	$a3, LEFT_KEY, right_key			# if input != left_key --> goto right_key
	lw	$t0, PLAYER_COLUMN_OFFSET($a1)			# load in player->column into $t0
	ble	$t0, 0, right_key				# if player-->column <= 0 --> goto right_key
	addi	$t0, $t0, -1					# --player-->column
	sw	$t0, PLAYER_COLUMN_OFFSET($a1)			# store word (int) into player->column
	j	end_handle

right_key:

	bne 	$a3, RIGHT_KEY, jump_key			
	lw	$t0, PLAYER_COLUMN_OFFSET($a1)			
	bge	$t0, MAP_WIDTH-1, jump_key			
	addi	$t0, $t0, 1					
	sw	$t0, PLAYER_COLUMN_OFFSET($a1)	
	j	end_handle

jump_key:

	bne 	$a3, JUMP_KEY, crouch_key			# else if (input == JUMP_KEY) {

	lw	$t0, PLAYER_STATE_OFFSET($a1)			# if (player->state == PLAYER_RUNNING) {
	bne	$t0, PLAYER_RUNNING, crouch_key	

	li	$t0, PLAYER_JUMPING				# player->state = PLAYER_JUMPING;
	sw	$t0, PLAYER_STATE_OFFSET($a1)

	li	$t1, ACTION_DURATION				# player->action_ticks_left = ACTION_DURATION;
	sw	$t1, PLAYER_ACTION_TICKS_LEFT_OFFSET($a1)	
	j	end_handle
	

crouch_key:

	bne 	$a3, CROUCH_KEY, tick_key			# else if (input == JUMP_KEY) {

	lw	$t0, PLAYER_STATE_OFFSET($a1)			# if (player->state == PLAYER_RUNNING) {
	bne	$t0, PLAYER_RUNNING, tick_key	

	li	$t0, PLAYER_CROUCHING				# player->state = PLAYER_JUMPING;
	sw	$t0, PLAYER_STATE_OFFSET($a1)

	li	$t1, ACTION_DURATION				# player->action_ticks_left = ACTION_DURATION;
	sw	$t1, PLAYER_ACTION_TICKS_LEFT_OFFSET($a1)	
	j	end_handle

tick_key:

	bne 	$a3, TICK_KEY, end_handle			# else if (input == JUMP_KEY) {

	jal	do_tick

end_handle:


handle_command__epilogue:
	pop	$ra
	end
	jr	$ra


################################################################################
# .TEXT <handle_collision>
	.text
handle_collision:
	# Subset:   3
	#
	# Args:
	#   - $a0: char map[MAP_HEIGHT][MAP_WIDTH]
	#   - $a1: struct Player *player
	#
	# Returns:  $v0: int
	#
	# Frame:    [$ra, $s0, $s1, $s2, $s3]
	# Uses:     [$s0, $s1, $s2, $s3, $a0, $a1]
	# Clobbers: [$a0, $a1, $t0, $t1, $t2, $t3]
	#
	# Locals:
	#   - $t0, $t1, $t2, $t3
	#
	# Structure:
	#   handle_collision
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

handle_collision__prologue:

	begin
	push	$ra
	push	$s0					# $a0 - char map[][]
	push 	$s1					# $a1 - struct Player *player
	push	$s2					# $s2 - *map_char
	push 	$s3


handle_collision__body:

	move	$s0, $a0				# $s0 - char map[MAP_HEIGHT][MAP_WIDTH]
	move	$s1, $a1				# $s1 - struct PLayer *player

	lw	$t0, PLAYER_COLUMN_OFFSET($s1)		# $t0 - player->column
	
	li	$t1, PLAYER_ROW
	mul	$t1, $t1, MAP_WIDTH			# $t1 - required offset for map_char
	add	$t1, $t1, $t0
	add	$t1, $t1, $s0				# $t1 - &map[PLAYER_ROW][player->column];

	move 	$s3, $t1				# $s3 = &map[PLAYER_ROW][player->column]
	lb	$s2, ($t1)				# $s2 - *map_char
							
barrier_if:
	bne	$s2, BARRIER_CHAR, train_if		# if (*map_char != BARRIER_CHAR) -> goto train_if

	lw	$t3, PLAYER_STATE_OFFSET($s1)		# $t3 - player->state
	
	beq	$t3, PLAYER_CROUCHING, barrier_pass	# if (player->state == PLAYER_CROUCHING) --> goto barrier_pass

	li	$v0, 4					# printf("💥 You ran into a barrier! 😵\n");
	la	$a0, handle_collision__barrier_msg
	syscall

	li	$v0, 0					# return FALSE
	j	handle_collision__epilogue		
	

barrier_pass:

	lw 	$t1, PLAYER_SCORE_OFFSET($s1)
	add	$t1, $t1, BARRIER_SCORE_BONUS
	sw	$t1, PLAYER_SCORE_OFFSET($s1)

train_if:
	bne	$s2, TRAIN_CHAR, train_if_else		# if (*map_char != TRAIN_CHAR) -> goto train_if_else

	lw	$t0, PLAYER_STATE_OFFSET($s1)		# $t0 - player->state
	lw	$t1, PLAYER_ON_TRAIN_OFFSET($s1)	# $t1 - player->on_train

	beq 	$t0, PLAYER_JUMPING, on_train		# if player->state == PLAYER_JUMPING --> goto on_train
	beq	$t1, 1, on_train			# if player->on_train = 1 --> goto on_train

	li	$v0, 4					# printf("💥 You ran into a train! 😵\n");
	la	$a0, handle_collision__train_msg
	syscall

	li	$v0, 0					# return FALSE
	j	handle_collision__epilogue

on_train:	

	li	$t1, TRUE				# player->on_train = TRUE;
	sw	$t1, PLAYER_ON_TRAIN_OFFSET($s1)

bonus:

	lw	$t0, PLAYER_STATE_OFFSET($s1)		# $t0 - player->state
	lw	$t1, PLAYER_SCORE_OFFSET($s1)		# $t1 - player->score

	beq	$t0, PLAYER_JUMPING, wall_if		# if player->state == PLAYER_JUMPING -> goto wall_if

	add	$t1, $t1, TRAIN_SCORE_BONUS		# player->score += TRAIN_SCORE_BONUS;
	sw	$t1, PLAYER_SCORE_OFFSET($s1)

	j	wall_if

train_if_else:

	li	$t2, FALSE
	sw	$t2, PLAYER_ON_TRAIN_OFFSET($s1)	# player->on_train = FALSE;


wall_if:
	bne	$s2, WALL_CHAR, cash_if			# if *map_char != WALL_CHAR -> goto cash_char check

	li	$v0, 4					# printf("💥 You ran into a wall! 😵\n");
	la	$a0, handle_collision__wall_msg
	syscall
	li	$v0, 0					# return 0
	j	handle_collision__epilogue

cash_if:
	bne	$s2, CASH_CHAR, end_and_return_true	# if *mapchar != CASH_CHAR -> goto end_ifs
	lw	$t1, PLAYER_SCORE_OFFSET($s1)		# $t1 - player->score
	add	$t1, $t1, CASH_SCORE_BONUS		# player->score += CASH_SCORE_BONUS;
	sw	$t1, PLAYER_SCORE_OFFSET($s1)

	li	$t3, EMPTY_CHAR				# *map_char = EMPTY_CHAR;
	sb	$t3, ($s3)


end_and_return_true:
	li	$v0, 1					# return TRUE

handle_collision__epilogue:

	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra


################################################################################
# .TEXT <maybe_pick_new_chunk>
	.text
maybe_pick_new_chunk:
	# Subset:   3
	#
	# Args:
	#   - $a0: struct BlockSpawner *block_spawner
	#
	# Returns:  None
	#
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$s0, $s1]
	# Clobbers: [$a0, $t0]
	#
	# Locals:
	#   - $t0 : int new_safe_column_required
	#   
	#
	# Structure:
	#   maybe_pick_new_chunk
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

maybe_pick_new_chunk__prologue:
	begin
	push	$ra
	push	$s0					# $a0 = block_spawner
	push	$s1		
	push	$s2		
maybe_pick_new_chunk__body:
	move 	$s0, $a0				# save block_spawner input into $s0
	li	$s2, FALSE				# int new_safe_column_required = FALSE;

for_loop_init_chunk:
	li	$s1, 0					# int column = 0;
for_loop_cond_chunk:
	bge	$s1, MAP_WIDTH, loop_end_new_chunk	# for (int column = 0; column < MAP_WIDTH; ++column)
for_loop_body_chunk:

	lw	$t0, ($s0)
			
	mul	$t1, $s1, SIZEOF_PTR			# $t1 = 4 (size of char const *) * column
	add	$t1, $s0, $t1				# $t1 = &block_spawner->next_block[column]
	lw	$t0, ($t1)				# $t0 = char const * = *next_block_ptr 

	beq	$t0, $zero, pointer_null 		# *next_block_ptr != NULL -> goto next iter
	lb	$t2, ($t0)				# $t2 = char const = **next_block_ptr

	#bne	$t0, $zero, loop_iter_new_chunk
	bne	$t2, '\0', loop_iter_new_chunk		# **next_block_ptr != '\0' -> goto next iteration

pointer_null:
	jal	rng					# rng()
	remu	$t2, $v0, NUM_CHUNKS			# $t2 : int chunk = rng() % NUM_CHUNKS

	li	$v0, 4					# printf("Column ");
	la	$a0, maybe_pick_new_chunk__column_msg_1
	syscall

	li	$v0, 1					# printf("%d", column);
	move	$a0, $s1
	syscall

	li	$v0, 4					# printf(": ");
	la	$a0, maybe_pick_new_chunk__column_msg_2
	syscall

	li	$v0, 1					# printf("%d", column);
	move	$a0, $t2
	syscall

	li	$v0, 11					# putchar('\n')
	li	$a0, '\n'
	syscall	

	la	$t3, CHUNKS				# $t3 : &CHUNKS[0] , CHUNKS = char* []
	
	mul	$t2, $t2, 4					# offset required to get to CHUNKS[chunks];
	add	$t3, $t3, $t2					# $t3 : &CHUNKS[chunk]
	lw	$t4, ($t3)					# $t4 = CHUNKS[chunk]
	sw	$t4, ($t1)					# *next_block_ptr = CHUNKS[chunk]

if_col_safe:
	lw	$t5, BLOCK_SPAWNER_SAFE_COLUMN_OFFSET($s0)	# $t5 : block_spawner->safe_column
	bne	$s1, $t5, end_if_col_safe			# if (column == block_spawner->safe_column) {

	li	$s2, TRUE					# new_safe_column_required = TRUE; }

end_if_col_safe:

loop_iter_new_chunk:
	addi	$s1, 1
	j	for_loop_cond_chunk

loop_end_new_chunk:
	bne	$s2, TRUE, maybe_pick_new_chunk__epilogue	# if (new_safe_column_required) {

	jal	rng
	remu	$t0, $v0, MAP_WIDTH				# int safe_column = rng() % MAP_WIDTH;

	li	$v0, 4						# printf("New safe column: ");
	la	$a0, maybe_pick_new_chunk__safe_msg
	syscall

	li	$v0, 1						# printf("%d", safe_column);
	move	$a0, $t0
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	sw	$t0, BLOCK_SPAWNER_SAFE_COLUMN_OFFSET($s0)	# block->safe_column = safe_column ($t0)

	mul	$t1, $t0, SIZEOF_PTR				# $t1 = next_block[safe_column] offset
	add	$t1, $t1, $s0					# $t1 = block_spawner->next_block[safe_column]

	la	$t2, CHUNKS					# block_spawner->next_block[safe_column] = CHUNKS[SAFE_CHUNK_INDEX];
	lw	$t3, SAFE_CHUNK_INDEX($t2)
	sw	$t3, ($t1)

maybe_pick_new_chunk__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra
	

################################################################################
# .TEXT <do_tick>
	.text
do_tick:
	# Subset:   3
	#
	# Args:
	#   - $a0: char map[MAP_HEIGHT][MAP_WIDTH]
	#   - $a1: struct Player *player
	#   - $a2: struct BlockSpawner *block_spawner
	#
	# Returns:  None
	#
	# Frame:    [$ra, $s0, $s1, $s2]
	# Uses:     [$s0, $s1, $s2, $a0]
	# Clobbers: [$a0, $a1, $t0, $t1, $t2, $t3, $t4, $t5]
	#
	# Locals:
	#   - $t0, $t1, $t2, $t3, $t4, $t5
	#
	# Structure:
	#   do_tick
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

do_tick__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
do_tick__body:
	move	$s0, $a0		# $s0 = char map[MAP_HEIGHT][MAP_WIDTH]
	move	$s1, $a1		# $s1 = struct Player *player
	move	$s2, $a2		# $s2 = struct BlockSpawner *block_spawner

if_tick_cond:
	lw	$t0, PLAYER_ACTION_TICKS_LEFT_OFFSET($s1)
	blez	$t0, else_tick_cond 				# if (player->action_ticks_left <= 0) goto else
	add	$t0, $t0, -1					# --player->action_ticks_left;
	sw	$t0, PLAYER_ACTION_TICKS_LEFT_OFFSET($s1)
else_tick_cond:
	li	$t0, PLAYER_RUNNING				# 
	sw	$t0, PLAYER_STATE_OFFSET($s1)			# player->state = PLAYER_RUNNING;

	lw	$t0, PLAYER_SCORE_OFFSET($s1)			# player->score += SCROLL_SCORE_BONUS;
	add	$t0, $t0, SCROLL_SCORE_BONUS
	sw	$t0, PLAYER_SCORE_OFFSET($s1)

	move	$a0, $s2
	jal	maybe_pick_new_chunk

move_row_loop_outer:
	li 	$t0, 0						# $t0 = int i
move_row_loop_outer_cond:
	bge 	$t0, MAP_HEIGHT-1, move_row_loop_outer_end
move_row_loop_inner:
	li	$t1, 0						# $t1 = int j
move_row_loop_inner_cond:
	bge	$t1, MAP_WIDTH, move_row_loop_inner_end
move_row_body:
	
	mul	$t2, $t0, MAP_WIDTH
	add	$t2, $t2, $t1					# calculate offset

	add	$t3, $t2, $s0					# $t3 : address = &map[i][j]
	lb	$t4, MAP_WIDTH($t3)				# $t4 : char =  map[i+1][j] 

	sb	$t4, ($t3)

move_row_loop_inner_iter:
	addi	$t1, 1
	j	move_row_loop_inner_cond

move_row_loop_inner_end:

move_row_loop_outer_iter:
	addi 	$t0, 1
	j	move_row_loop_outer_cond

move_row_loop_outer_end:

generator_next_row_loop:
	li	$t0, 0					# int column = 0
generator_next_row_loop_cond:	
	bge	$t0, MAP_WIDTH, generator_next_row_loop_end

	mul	$t1, $t0, SIZEOF_PTR			# $t1 = offset required for next_block[column]
	add	$t1, $t1, $s2				# $t1 = &block_spawner->next_block[column]
	lw	$t3, ($t1)				# $t3 = *next_block
	lb	$t4, ($t3)				# $t4 = **next_block

	li	$t2, MAP_HEIGHT-1			
	mul	$t2, $t2, MAP_WIDTH
	add	$t2, $t2, $t0				# $t2 = offset

	add	$t2, $t2, $s0				# $t2 = &map[MAP_HEIGHT - 1][column] 
	sb	$t4, ($t2)				# map[MAP_HEIGHT - 1][column] = **next_block;

	add	$t5, $t3, 1				# ++*next_block
	sw	$t5, ($t1) 

generator_next_row_loop_iter:
	addi	$t0, 1
	j	generator_next_row_loop_cond

generator_next_row_loop_end:



do_tick__epilogue:
	pop	$s2 
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra

################################################################################
################################################################################
###                   PROVIDED FUNCTIONS — DO NOT CHANGE                     ###
################################################################################
################################################################################

################################################################################
# .TEXT <get_seed>
get_seed:
	# Args:     None
	#
	# Returns:  None
	#
	# Frame:    []
	# Uses:     [$v0, $a0]
	# Clobbers: [$v0, $a0]
	#
	# Locals:
	#   - $v0: seed
	#
	# Structure:
	#   get_seed
	#   -> [prologue]
	#     -> body
	#       -> invalid_seed
	#       -> seed_ok
	#   -> [epilogue]

get_seed__prologue:
get_seed__body:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, get_seed__prompt_msg
	syscall					# printf("Enter a non-zero number for the seed: ")

	li	$v0, 5				# syscall 5: read_int
	syscall					# scanf("%d", &seed);
	sw	$v0, g_rng_state		# g_rng_state = seed;

	bnez	$v0, get_seed__seed_ok		# if (seed == 0) {
get_seed__invalid_seed:
	li	$v0, 4				#   syscall 4: print_string
	la	$a0, get_seed__prompt_invalid_msg
	syscall					#   printf("Invalid seed!\n");

	li	$v0, 10				#   syscall 10: exit
	li	$a0, 1
	syscall					#   exit(1);

get_seed__seed_ok:				# }
	li	$v0, 4				# sycall 4: print_string
	la	$a0, get_seed__set_msg
	syscall					# printf("Seed set to ");

	li	$v0, 1				# syscall 1: print_int
	lw	$a0, g_rng_state
	syscall					# printf("%d", g_rng_state);

	li	$v0, 11				# syscall 11: print_char
	la	$a0, '\n'
	syscall					# putchar('\n');

get_seed__epilogue:
	jr	$ra				# return;


################################################################################
# .TEXT <rng>
rng:
	# Args:     None
	#
	# Returns:  $v0: unsigned
	#
	# Frame:    []
	# Uses:     [$v0, $a0, $t0, $t1, $t2]
	# Clobbers: [$v0, $a0, $t0, $t1, $t2]
	#
	# Locals:
	#   - $t0 = copy of g_rng_state
	#   - $t1 = bit
	#   - $t2 = temporary register for bit operations
	#
	# Structure:
	#   rng
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

rng__prologue:
rng__body:
	lw	$t0, g_rng_state

	srl	$t1, $t0, 31		# g_rng_state >> 31
	srl	$t2, $t0, 30		# g_rng_state >> 30
	xor	$t1, $t2		# bit = (g_rng_state >> 31) ^ (g_rng_state >> 30)

	srl	$t2, $t0, 28		# g_rng_state >> 28
	xor	$t1, $t2		# bit ^= (g_rng_state >> 28)

	srl	$t2, $t0, 0		# g_rng_state >> 0
	xor	$t1, $t2		# bit ^= (g_rng_state >> 0)

	sll	$t1, 31			# bit << 31
	srl	$t0, 1			# g_rng_state >> 1
	or	$t0, $t1		# g_rng_state = (g_rng_state >> 1) | (bit << 31)

	sw	$t0, g_rng_state	# store g_rng_state

	move	$v0, $t0		# return g_rng_state

rng__epilogue:
	jr	$ra


################################################################################
# .TEXT <read_char>
read_char:
	# Args:     None
	#
	# Returns:  $v0: unsigned
	#
	# Frame:    []
	# Uses:     [$v0]
	# Clobbers: [$v0]
	#
	# Locals:   None
	#
	# Structure:
	#   read_char
	#   -> [prologue]
	#     -> body
	#   -> [epilogue]

read_char__prologue:
read_char__body:
	li	$v0, 12			# syscall 12: read_char
	syscall				# return getchar();

read_char__epilogue:
	jr	$ra
