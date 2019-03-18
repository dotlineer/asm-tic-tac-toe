.text
main:
li $s7, 0 # game not over
li $s4, 0 # player won
li $s5, 0 # computer won
li $s6, 0 # draw
li $s3, 0 # number of rounds played
li $s2, 0 # number of rounds to play


# FUNCTION - MAIN

addi $v0, $zero, 4
la $a0, msg5
syscall

addi $v0, $zero, 5
syscall
move $s2, $v0


jal printState

jal play


# Exit
li $v0, 10
syscall



# ENDFUNCTION - Main

# FUNCTION printState
printState:
addi $sp, $sp, -4
sw $ra, 0($sp)

addi $v0, $zero, 4
la $a0, msg3
syscall

addi $v0, $zero, 1
move $a0, $s4
syscall

addi $v0, $zero, 4
la $a0, msg4
syscall

addi $v0, $zero, 1
move $a0, $s5
syscall

addi $v0, $zero, 4
la $a0, msg4
syscall

addi $v0, $zero, 1
move $a0, $s6
syscall



addi $v0, $zero, 4
la $a0, nl
syscall

lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endPrintState:
# ENDFUNCTION


# FUNCTION - exitProgram
exitProgram:
addi $sp, $sp, -4
sw $ra, 0($sp)

jal printState

li $v0, 10
syscall

lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endExitProgram:
# ENDFUNCTION - exitProgram


# FUNCTIO - newGame
newGame:
addi $sp, $sp, -4
sw $ra, 0($sp)

li $s7, 0

li $t0, 0
li $t1, 9
la $t2, board
li $t4, 95 # underscore

loop3:
beq $t0, $t1, endLoop3

add $t3, $t2, $t0
sb $t4, 0($t3)

addi $t0, $t0, 1
j loop3
endLoop3:

lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endNewGame:

# FUNCTION - print that game is over
gameIsOver:
addi $sp, $sp, -4
sw $ra, 0($sp)

li $t5, 120 # x
li $t6, 111 # o

div $t7, $t5
mfhi $t4
bne $t4, $zero, playerWon
compWon:
addi $s5, $s5, 1
j endPlayerWon
playerWon:
addi $s4, $s4, 1
endPlayerWon:
addi $s3, $s3, 1

li $s7, 1 # game is over - info for main program


jal printState


 addi $v0, $zero, 4
 la $a0, msg0
 syscall

lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endGameIsOver:
# ENDFUNCTION - gameIsOver


# FUNCTION - checkGameOver
# $v1 - 0 if not game over, 1 if game over
checkGameOver:
addi $sp, $sp, -4
sw $ra, 0($sp)

li $t0, 0 # 0 if not game over, 1 if game over
li $t1, 0 # 0 if not three same in a row
la $t2, board
li $t3, 0 # store loaded value
li $t4, 0 # sum of values for current row
li $t5, 120 # x
li $t6, 111 # o
# li $v1, 0 # default game is not over
# $t7 - value modulo


move0check:
li $t4, 0
lb $t3, 3($t2)
add $t4, $t4, $t3
lb $t3, 4($t2)
add $t4, $t4, $t3
lb $t3, 5($t2)
add $t4, $t4, $t3

div $t4, $t5
mfhi $t7
beq $t7, $zero, gameIsOver
div $t4, $t6
mfhi $t7
beq $t7, $zero, gameIsOver


move1check:
li $t4, 0
lb $t3, 1($t2)
add $t4, $t4, $t3
lb $t3, 4($t2)
add $t4, $t4, $t3
lb $t3, 7($t2)
add $t4, $t4, $t3

div $t4, $t5
mfhi $t7
beq $t7, $zero, gameIsOver
div $t4, $t6
mfhi $t7
beq $t7, $zero, gameIsOver


move2check:
li $t4, 0
lb $t3, 0($t2)
add $t4, $t4, $t3
lb $t3, 1($t2)
add $t4, $t4, $t3
lb $t3, 2($t2)
add $t4, $t4, $t3

div $t4, $t5
mfhi $t7
beq $t7, $zero, gameIsOver
div $t4, $t6
mfhi $t7
beq $t7, $zero, gameIsOver

move3check:
li $t4, 0
lb $t3, 6($t2)
add $t4, $t4, $t3
lb $t3, 7($t2)
add $t4, $t4, $t3
lb $t3, 8($t2)
add $t4, $t4, $t3

div $t4, $t5
mfhi $t7
beq $t7, $zero, gameIsOver
div $t4, $t6
mfhi $t7
beq $t7, $zero, gameIsOver


move4check:
li $t4, 0
lb $t3, 0($t2)
add $t4, $t4, $t3
lb $t3, 3($t2)
add $t4, $t4, $t3
lb $t3, 6($t2)
add $t4, $t4, $t3

div $t4, $t5
mfhi $t7
beq $t7, $zero, gameIsOver
div $t4, $t6
mfhi $t7
beq $t7, $zero, gameIsOver

move5check:
li $t4, 0
lb $t3, 2($t2)
add $t4, $t4, $t3
lb $t3, 5($t2)
add $t4, $t4, $t3
lb $t3, 8($t2)
add $t4, $t4, $t3

div $t4, $t5
mfhi $t7
beq $t7, $zero, gameIsOver
div $t4, $t6
mfhi $t7
beq $t7, $zero, gameIsOver


move6check:
li $t4, 0
lb $t3, 0($t2)
add $t4, $t4, $t3
lb $t3, 4($t2)
add $t4, $t4, $t3
lb $t3, 8($t2)
add $t4, $t4, $t3

div $t4, $t5
mfhi $t7
beq $t7, $zero, gameIsOver
div $t4, $t6
mfhi $t7
beq $t7, $zero, gameIsOver



move7check:
li $t4, 0
lb $t3, 2($t2)
add $t4, $t4, $t3
lb $t3, 4($t2)
add $t4, $t4, $t3
lb $t3, 6($t2)
add $t4, $t4, $t3

div $t4, $t5
mfhi $t7
beq $t7, $zero, gameIsOver
div $t4, $t6
mfhi $t7
beq $t7, $zero, gameIsOver




addi $v0, $zero, 1
move $a0, $t4
syscall






lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endCheckGameOver:



# FUNCTION - play
play:
addi $sp, $sp, -4
sw $ra, 0($sp)

loop2:
beq $s3, $s2, exitProgram

jal moveInput
jal getNewMove
move $a1, $v1

bne $v1, -1, wasNotDraw
jal newGame
j loop2
wasNotDraw:


jal doMove
jal printBoard
jal checkGameOver

bne $s7, 1, notOver
 addi $v0, $zero, 4
 la $a0, msg1
 syscall
 
addi $v0, $zero, 5
syscall
move $t7, $v0

beq $t7, 0, exitProgram
beq $t7, 1, newGame

notOver:

j loop2

endLoop2:


lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endPlay:
# ENDFUNCTION - play


# FUNCTION - moveInput - user inputs a move
moveInput:
addi $sp, $sp, -4
sw $ra, 0($sp)

la $t2, board

addi $v0, $zero, 4
la $a0, prompt
syscall

addi $v0, $zero, 5
syscall
move $t0, $v0

li $t3, 120 # load 'o'
add $t4, $t2, $t0
sb $t3, 0($t4)

lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endMoveInput:
# ENDFUNCTION - moveInput


# FUNCTION - printBoard
printBoard:
addi $sp, $sp, -4
sw $ra, 0($sp)

li $t0, 0
li $t1, 9

la $t2, board
la $t5, nl
lb $t5 0($t5)
li $t6, 3

addi $v0, $zero, 11
move $a0, $t5
syscall

loop1:
beq $t0, $t1, endLoop1



add $t3, $t2, $t0
lb $t4, 0($t3)

div $t0, $t6
mfhi $t7
bne $t7, $zero, notNewLine


addi $v0, $zero, 11
move $a0, $t5
syscall

notNewLine:

addi $v0, $zero, 11
move $a0, $t4
syscall	
	
addi $t0, $t0, 1
j loop1
endLoop1:

addi $v0, $zero, 11
move $a0, $t5
syscall
syscall

lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
# ENDFUNCTION - printBoard



# FUNCTION - checkEmpty - check if a square is empty
checkEmpty:
addi $sp, $sp, -4
sw $ra, 0($sp)

bne $t2, 95, notEmpty
li $t6, 1

notEmpty:

lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endCheckEmpty:
# ENDFUNCTION - checkEmpty



# FUNCTION - getNewMove # Get new move for the computer
# $t3 - best row
# $t4 - best score
# $t5 - result of comparison
# $t6 - 1 if there is an empty square in current row, 0 if not
# returns - $v1 - number of best move
getNewMove:
addi $sp, $sp, -4
sw $ra, 0($sp)


li $t0, 0
la $t1, board
li $t6, 0

li $t3, -1
li $t4, -1

move $t0, $zero
move $t6, $zero
lb $t2, 3($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 4($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 5($t1)
jal checkEmpty
add $t0, $t0, $t2
move $t5, $zero
sub $t5, $t4, $t0

beq $t6, 0, rowFull0
bgez $t5, notUpdateBestMove0
li $t3, 0
move $t4, $t0
notUpdateBestMove0:
rowFull0:
li $t6, 0



move $t0, $zero
lb $t2, 1($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 4($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 7($t1)
jal checkEmpty
add $t0, $t0, $t2
move $t5, $zero
sub $t5, $t4, $t0

beq $t6, 0, rowFull1
bgez $t5, notUpdateBestMove
li $t3, 1
move $t4, $t0
notUpdateBestMove:
rowFull1:
li $t6, 0


move $t0, $zero
lb $t2, 0($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 1($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 2($t1)
jal checkEmpty
add $t0, $t0, $t2
move $t5, $zero
sub $t5, $t4, $t0

beq $t6, 0, rowFull2
bgez $t5, notUpdateBestMove2
li $t3, 2
move $t4, $t0
notUpdateBestMove2:
rowFull2:
li $t6, 0


move $t0, $zero
lb $t2, 6($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 7($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 8($t1)
jal checkEmpty
add $t0, $t0, $t2
move $t5, $zero
sub $t5, $t4, $t0

beq $t6, 0, rowFull3
bgez $t5, notUpdateBestMove3
li $t3, 3
move $t4, $t0
notUpdateBestMove3:
rowFull3:
li $t6, 0


move $t0, $zero
lb $t2, 0($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 3($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 6($t1)
jal checkEmpty
add $t0, $t0, $t2
move $t5, $zero
sub $t5, $t4, $t0

beq $t6, 0, rowFull4
bgez $t5, notUpdateBestMove4
li $t3, 4
move $t4, $t0
notUpdateBestMove4:
rowFull4:
li $t6, 0


move $t0, $zero
lb $t2, 2($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 5($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 8($t1)
jal checkEmpty
add $t0, $t0, $t2
move $t5, $zero
sub $t5, $t4, $t0

beq $t6, 0, rowFull5
bgez $t5, notUpdateBestMove5
li $t3, 5
move $t4, $t0
notUpdateBestMove5:
rowFull5:
li $t6, 0


move $t0, $zero
lb $t2, 0($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 4($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 8($t1)
jal checkEmpty
add $t0, $t0, $t2
move $t5, $zero
sub $t5, $t4, $t0

beq $t6, 0, rowFull6
bgez $t5, notUpdateBestMove6
li $t3, 6
move $t4, $t0
notUpdateBestMove6:
rowFull6:
li $t6, 0


move $t0, $zero
lb $t2, 2($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 4($t1)
jal checkEmpty
add $t0, $t0, $t2
lb $t2, 6($t1)
jal checkEmpty
add $t0, $t0, $t2
move $t5, $zero
sub $t5, $t4, $t0

beq $t6, 0, rowFull7
bgez $t5, notUpdateBestMove7
li $t3, 7
move $t4, $t0
notUpdateBestMove7:
rowFull7:
li $t6, 0



# No move to make
move $v1, $t3


bne $t3, -1, notDraw
bne $t4, -1, notDraw
 addi $v0, $zero, 4
 la $a0, msg2
 syscall
 # add $
 add $s6, $s6, 1
 add $s3, $s3, 1
 li $v1, -1

notDraw:



lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
# ENDFUNCTION - getNewMove



# FUNCTION - doMove
# arguments - $a1 - number of move to make

doMove:
addi $sp, $sp, -4
sw $ra, 0($sp)

# addi $v0, $zero, 1
# move $a0, $a1
# syscall

move $t0, $a1
la $t1, board

beq $t0, 0, move0
beq $t0, 1, move1
beq $t0, 2, move2
beq $t0, 3, move3
beq $t0, 4, move4
beq $t0, 5, move5
beq $t0, 6, move6
beq $t0, 7, move7





move0:
move00:
lb $t2, 3($t1)
beq $t2, 120, move01
beq $t2, 111, move01
li $v1, 3
j afterMove

move01:
lb $t2, 4($t1)
beq $t2, 120, move02
beq $t2, 111, move02
li $v1, 4
j afterMove

move02:
li $v1, 5
j afterMove



move1:
move10:
lb $t2, 1($t1)
beq $t2, 120, move11
beq $t2, 111, move11
li $v1, 1
j afterMove

move11:
lb $t2, 4($t1)
beq $t2, 120, move12
beq $t2, 111, move12
li $v1, 4
j afterMove

move12:
li $v1, 7
j afterMove



move2:
move20:
lb $t2, 0($t1)
beq $t2, 120, move21
beq $t2, 111, move21
li $v1, 0
j afterMove

move21:
lb $t2, 1($t1)
beq $t2, 120, move22
beq $t2, 111, move22
li $v1, 1
j afterMove

move22:
li $v1, 2
j afterMove



move3:
move30:
lb $t2, 6($t1)
beq $t2, 120, move31
beq $t2, 111, move31
li $v1, 6
j afterMove

move31:
lb $t2, 7($t1)
beq $t2, 120, move32
beq $t2, 111, move32
li $v1, 7
j afterMove

move32:
li $v1, 8
j afterMove




move4:
move40:
lb $t2, 0($t1)
beq $t2, 120, move41
beq $t2, 111, move41
li $v1, 0
j afterMove

move41:
lb $t2, 3($t1)
beq $t2, 120, move42
beq $t2, 111, move42
li $v1, 3
j afterMove

move42:
li $v1, 6
j afterMove


move5:
move50:
lb $t2, 2($t1)
beq $t2, 120, move51
beq $t2, 111, move51
li $v1, 2
j afterMove

move51:
lb $t2, 5($t1)
beq $t2, 120, move52
beq $t2, 111, move52
li $v1, 5
j afterMove

move52:
li $v1, 8
j afterMove





move6:
move60:
lb $t2, 0($t1)
beq $t2, 120, move61
beq $t2, 111, move61
li $v1, 0
j afterMove

move61:
lb $t2, 4($t1)
beq $t2, 120, move62
beq $t2, 111, move62
li $v1, 4
j afterMove

move62:
li $v1, 8
j afterMove


move7:
move70:
lb $t2, 2($t1)
beq $t2, 120, move71
beq $t2, 111, move71
li $v1, 2
j afterMove

move71:
lb $t2, 4($t1)
beq $t2, 120, move72
beq $t2, 111, move72
li $v1, 4
j afterMove

move72:
li $v1, 6
j afterMove





afterMove:


# addi $v0, $zero, 1
# move $a0, $v1
# syscall

li $t3, 111 # load 'o'
add $t4, $t1, $v1
sb $t3, 0($t4)


lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
endDoMove:
# ENDFUNCTION - doMove




.data

# board:  .asciiz "___ox____"
# board:  .asciiz "___xxx___"
board:  .asciiz "_________"
# board:  .asciiz "012345x78"
# board:  .asciiz "912395679"
nl: .asciiz "\n"
prompt: .asciiz "Please enter a square [0-8]. \n"
msg0: .asciiz "Game is over. \n"
msg1: .asciiz "Would you like to play again? Input 0 for no, 1 for yes. \n"
msg2: .asciiz "Draw! \n"
msg3: .asciiz "Game state is: \n"
msg4: .asciiz ", "
msg5: .asciiz "How many rounds to play? \n"
