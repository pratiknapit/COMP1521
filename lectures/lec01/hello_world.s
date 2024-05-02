main: 
        li      $v0, 4                  # syscall 4: print_string
	
        li      $a0, hello_world_str    # refers to hello_world_str variable	
	
	    syscall
        
        jr      $ra 		            # return: 0
        
        .data
hello_world_str: 
        .asciiz "Hello Everyone\n"      # 