###################### DATA SECTION ##############################
	.data		# marks the beginning of the data segment
			# declare space for variables and buffers here
			# declare constant strings here
			# do not put any actual instructions here - only assembler directives
			# choices include .word, .byte, .space, .asciiz, .ascii

testA: 			.word 0xDEADBEEF
testB:			.word 0xBEEBEAD0
negativeOne:	.word -1

###################### CODE SECTION ##############################			
	.text		# marks the beginning of the code portion
			# put all code in this section
			# do not use any assembler directives other than labels and comments
			# remember to tab or space over unless the line starts with a label 

			# entry point - when you execute the program in SPIM, it starts
			# at main:
main:

####### CALL myNand
			
			# store the values into registers
			lw $a0, testA($0)	# load A into $t0
			lw $a1, testB($0)	# load B into $t1

			addi $sp, $sp, -4	# decrement stack pointer by 4
			sw $ra, 0($sp)		# push RA on stack

			jal myNAND			# call function

			lw $ra, 0($sp)		# pop RA off stack
			addi $sp, $sp, 4	# increment stack pointer by 4

####### CALL myNOT
			
			# store the values into registers
			lw $a0, testA($0)	# load A into $t0
			lw $a1, testB($0)	# load B into $t1

			addi $sp, $sp, -4	# decrement stack pointer by 4
			sw $ra, 0($sp)		# push RA on stack

			jal myNOT			# call function

			lw $ra, 0($sp)		# pop RA off stack
			addi $sp, $sp, 4	# increment stack pointer by 4

####### CALL myOR
			
			# store the values into registers
			lw $a0, testA($0)	# load A into $t0
			lw $a1, testB($0)	# load B into $t1

			addi $sp, $sp, -4	# decrement stack pointer by 4
			sw $ra, 0($sp)		# push RA on stack

			jal myOR			# call function

			lw $ra, 0($sp)		# pop RA off stack
			addi $sp, $sp, 4	# increment stack pointer by 4

####### CALL myAND
			
			# store the values into registers
			lw $a0, testA($0)	# load A into $t0
			lw $a1, testB($0)	# load B into $t1

			addi $sp, $sp, -4	# decrement stack pointer by 4
			sw $ra, 0($sp)		# push RA on stack

			jal myAND			# call function

			lw $ra, 0($sp)		# pop RA off stack
			addi $sp, $sp, 4	# increment stack pointer by 4

####### CALL myXOR
			
			# store the values into registers
			lw $a0, testA($0)	# load A into $t0
			lw $a1, testB($0)	# load B into $t1

			addi $sp, $sp, -4	# decrement stack pointer by 4
			sw $ra, 0($sp)		# push RA on stack

			jal myXOR			# call function

			lw $ra, 0($sp)		# pop RA off stack
			addi $sp, $sp, 4	# increment stack pointer by 4

####### END PROGRAM

			li	$v0,10			# code for exit
			syscall				# exit program

###################### FUNCTIONS ##############################	

myNAND:	
		and $s7, $a0, $a1	# bit-wise AND on registers $a0, $a1

		lw $s6, negativeOne($0)	# place -1 into $a1 (argument 2)
		xor $v0, $s7, $s6		# NOT function on $v0

		jr $ra 				# return to program

myNOT:
		addi $a1, $a0, 0	# set both parameters to for the myNAND function to be $a0

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		jr $ra 				# return to program

myOR:	
		addi $s0, $a0, 0 	# move $a0 to $s0
		addi $s1, $a1, 0 	# move $a1 to $s1

		addi $a1, $s0, 0  	# set both parameters to A

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		addi $s2, $v0, 0 	# save result into $s2

		addi $a0, $s1, 0  	# set parameter 1 to B
		addi $a1, $s1, 0  	# set parameter 2 to B

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		addi $s3, $v0, 0 	# save result into $s3

		addi $a0, $s2, 0  	# set parameter 1 to $s2
		addi $a1, $s3, 0  	# set parameter 2 to $s3

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		jr $ra 			# return to program

myAND:	
		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		addi $a0, $v0, 0  	# set parameter 1 to $v0
		addi $a1, $v0, 0  	# set parameter 2 to $v0

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		jr $ra 			# return to program

myXOR:	
		addi $s0, $a0, 0 	# move $a0 to $s0
		addi $s1, $a1, 0 	# move $a1 to $s1

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		addi $s2, $v0, 0 	# save result into $s2

		addi $a1, $s2, 0  	# set parameter 2 to $s2

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		addi $s3, $v0, 0 	# save result into $s3

		addi $a0, $s1, 0  	# set parameter 1 to B

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		addi $s4, $v0, 0 	# save result into $s4

		addi $a0, $s3, 0  	# set parameter 1 to $s3
		addi $a1, $s4, 0  	# set parameter 2 to $s4

		addi $sp, $sp, -4	# decrement stack pointer by 4
		sw $ra, 0($sp)		# push RA on stack

		jal myNAND			# call function

		lw $ra, 0($sp)		# pop RA off stack
		addi $sp, $sp, 4	# increment stack pointer by 4

		jr $ra 				# return to program