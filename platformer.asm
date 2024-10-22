.eqv BASE_ADDRESS 0x10008000
.data

keyboardAddress: .word 0xffff0000

bgColour: .word 0xd3e3e0
playerShirt: .word 0xf25811
purple: .word 0x781aa3
green: .word 0x0acc0a
red: .word 0xcc0a21
gold: .word 0xffff03 
black: .word 0x00000
actuallyBlack: .word 0x00000
wallHeight: .word 4
wallLocation: .word 7800
p1Length: .word 16
p1Location: .word 5848
p2Length: .word 30
p2Location: .word 3868
p3Length: .word 22
p3Location: .word 2812
doorLength: .word 5
doorHeight: .word 10
doorLocation: .word 2556 # p3 - 256

.text
main:
	li $t0, BASE_ADDRESS # $t0 stores the base address for display

	# Load stuff for background
	lw $t1, bgColour
	li $t2, 0
	li $t3, 2048
	li $t4, BASE_ADDRESS
	
fillBg:
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, fillBg 
	
	# Load stuff for health bar top
	lw $t0, green
	lw $t1, black
	li $t2, 0
	li $t3, 13
	li $t4, BASE_ADDRESS
	
	# Draw dividers
	sw $t1, 256($t4)
	sw $t1, 272($t4)
	sw $t1, 288($t4)
	sw $t1, 304($t4)
	
drawHealthBarTop:
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, drawHealthBarTop
	
	# Load stuff for health bar bottom
	li $t2, 0
	li $t3, 13
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 512

drawHealthBarBottom:
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, drawHealthBarBottom
	
	# Load stuff for fill health
	li $t2, 0
	li $t3, 3
	li $t5, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 260
	
fillHealth:
	sw $t0, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, fillHealth
	addi $t5, $t5, 1
	addi $t4, $t4, 4
	addi $t2, $zero, 0
	bne $t5, $t3, fillHealth
	
	# Load stuff for floor
	li $t2, 0
	li $t3, 64
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 7936
	
drawFloor:
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, drawFloor
	
	# Load stuff for platform1
	li $t2, 0
	lw $t3, p1Length
	li $t4, BASE_ADDRESS
	lw $t0, p1Location
	add $t4, $t4, $t0

# 15 long
drawPlatform1:
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	addi $t2, $t2, 1
	bne $t2, $t3, drawPlatform1 
	
	# Load stuff for platform2
	li $t2, 0
	lw $t3, p2Length
	li $t4, BASE_ADDRESS
	lw $t0, p2Location
	add $t4, $t4, $t0

drawPlatform2:
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, drawPlatform2
	
	# Load stuff for platform3
	li $t2, 0
	lw $t3, p3Length
	li $t4, BASE_ADDRESS
	lw $t0, p3Location 
	add $t4, $t4, $t0

drawPlatform3:
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	addi $t2, $t2, 1
	bne $t2, $t3, drawPlatform3
	
	# Load stuff for heart
	lw $t1, red
	lw $t3, p1Location
	addi $t3, $t3, -260
	li $t4, BASE_ADDRESS
	add $t4, $t4, $t3
	
	
drawHeart:
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, 8
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -8
	sw $t1, 0($t4)
	
	# Load stuff for door
	lw $t0, doorLocation 
	lw $t1, gold
	li $t2, 0
	lw $t3, doorLength
	li $t4, BASE_ADDRESS
	li $t5, 0
	lw $t6, doorHeight
	add $t4, $t4, $t0
	

drawDoor:
	sw $t1, 0($t4)
	addi, $t4, $t4, -4
	addi, $t2, $t2, 1
	sw $t1, 0($t4)
	bne $t2, $t3, drawDoor
	add $t2, $zero, $zero
	addi $t5, $t5, 1	
	addi $t4, $t4, -236
	bne $t5, $t6, drawDoor

	# Load stuff for enemy1
	lw $t0, wallLocation 
	lw $t1, purple
	li $t2, 0
	li $t3, 4
	li $t4, BASE_ADDRESS
	add $t4, $t4, $t0
	addi $t4, $t4, 28
	
enemy1: 
	# body
	sw $t1, 0($t4)
	addi $t2, $t2, 1
	addi $t4, $t4, -256
	bne $t3, $t2, enemy1
	
	# arms
	addi $t4, $t4, 516
	sw $t1, 0($t4)
	addi $t4, $t4, -8
	sw $t1, 0($t4)
	
	# Load stuff for enemy2
	lw $t0, p2Location 
	li $t2, 0
	li $t3, 4
	li $t4, BASE_ADDRESS
	add $t4, $t4, $t0
	addi $t4, $t4, -240
	
	
enemy2:
	# body
	sw $t1, 0($t4)
	addi $t2, $t2, 1
	addi $t4, $t4, -256
	bne $t3, $t2, enemy2
	
	# arms
	addi $t4, $t4, 516
	sw $t1, 0($t4)
	addi $t4, $t4, -8
	sw $t1, 0($t4)
	
	# Load stuff for player
	lw $t1, playerShirt
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 7180
	
	# Draw player
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)
	
# ********************** INITIAL LOCATIONS  **********************  #

# s0 = Player location
li $s0, BASE_ADDRESS
addi $s0, $s0, 7180

# s1 = Heart location
lw $t3, p1Location
addi $t3, $t3, -260
li $t4, BASE_ADDRESS
add $s1, $t4, $t3

# s2 = Move direction (1 = left for heart, right for e1 | -1 = right for heart, left for e1)
li $s2, 1

# s3 = Enemy 1 location 
lw $t0, wallLocation 
li $t4, BASE_ADDRESS
add $t4, $t4, $t0
addi $s3, $t4, 28

# s4 = right bullet location
lw $t0, p2Location 
li $t4, BASE_ADDRESS
add $t4, $t4, $t0
addi $t4, $t4, -240
addi $s4, $t4, -504
# Draw bullet
lw $t1, red
sw $t1, 0($s4)

#s5 = double jump counter (0: no jumps used, 1: jumped from ground, 2: double jump used)
li $s5, 0

# s6 = 0 if hp not collected, 1 if hp has been collected
addi $s6, $zero, 0

# s7 = Number of lives
li $t0, 3
addi $s7, $t0, 0

# ********************** MAIN LOOP **********************  #
gameLoop:

	# sleep
	li $v0, 32
	li $a0, 115	
	syscall
	
	# Game mechanics
	jal keyPress
	jal checkHealth
	jal moveHp
	jal moveEnemy1
	jal rightBullet
	jal checkPlayerShot
	jal checkHitEnemy1
	jal checkHitEnemy2
	jal healthCollide
	jal playerGravity
	jal checkResetDoubleJump
	jal reachFinish
	
	j gameLoop

checkResetDoubleJump:
	# Check if player is on a platform
	move $t0, $s0
	addi $t0, $t0, 772
	
	# Load stuff for floor
	li $t2, 0
	li $t3, 64
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 7932
	
floorReset:
	# PLAYER = T0, FLOOR = T4
	beq $t0, $t4, resetDoubleJump
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, floorReset
	
	# Load stuff for platform1
	li $t2, 0
	lw $t3, p1Length
	li $t4, BASE_ADDRESS
	lw $t0, p1Location
	add $t4, $t4, $t0

checkP1J:
	move $t7, $s0
	addi $t7, $t7, 768
	addi $t6, $t7, 8
	beq $t7, $t4, resetDoubleJump
	beq $t6, $t4, resetDoubleJump
	addi $t4, $t4, -4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP1J 
	
	# Load P2
	li $t2, 0
	lw $t3, p2Length
	li $t4, BASE_ADDRESS
	lw $t0, p2Location
	add $t4, $t4, $t0

checkP2J:
	move $t7, $s0
	addi $t7, $t7, 768
	addi $t6, $t7, 8
	beq $t7, $t4, resetDoubleJump
	beq $t6, $t4, resetDoubleJump
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP2J
	
	# Load P3
	li $t2, 0
	lw $t3, p3Length
	li $t4, BASE_ADDRESS
	lw $t0, p3Location 
	add $t4, $t4, $t0

checkP3J:
	move $t7, $s0
	addi $t7, $t7, 768
	addi $t6, $t7, 8
	beq $t7, $t4, resetDoubleJump
	beq $t6, $t4, resetDoubleJump
	addi $t4, $t4, -4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP3J

	jr $ra
	
resetDoubleJump:
	li $s5, 0
	jr $ra

checkHitEnemy1:
	move $t0, $s0
	addi $t0, $t0, 8
	move $t1, $s3
	addi $t1, $t1, -516		
	beq $t0, $t1, hitEnemy1
	addi $t0, $t0, -8
	beq $t0, $t1, hitEnemy1	
	addi $t1, $t1, 8
	beq $t0, $t1, hitEnemy1
	addi $t0, $t0, 260
	beq $t0, $t1, hitEnemy1
	addi $t1, $t1, 252
	beq $t0, $t1, hitEnemy1
	addi $t1, $t1, -512	
	beq $t0, $t1, hitEnemy1
	addi $t0, $t0, 256
	beq $t0, $t1, hitEnemy1	
	jr $ra

hitEnemy1:
	addi $s7, $s7, -1
	jr $ra
		
checkHitEnemy2:
	lw $t7, gold
	move $t0, $s0
	addi $t0, $t0, 8

	# Load stuff for enemy2
	lw $t3, p2Location 
	li $t4, BASE_ADDRESS
	add $t4, $t4, $t3
	addi $t4, $t4, -240
	beq $t0, $t4, hitEnemy2
	addi $t4, $t4, -256
	beq $t0, $t4, hitEnemy2
	addi $t4, $t4, -252
	beq $t0, $t4, hitEnemy2
	addi $t4, $t4, -8
	beq $t0, $t4, hitEnemy2
	addi $t4, $t4, -252
	beq $t0, $t4, hitEnemy2
	addi $t0, $t0, -8
	beq $t0, $t4, hitEnemy2
	addi $t0, $t0, 260
	beq $t0, $t4, hitEnemy2
	addi $t0, $t0, 256
	beq $t0, $t4, hitEnemy2		
	jr $ra
	
hitEnemy2:
	addi $s7, $s7, -1
	# KEEP E2 visible
	
	jr $ra			
	
rightBullet:
	move $t0, $s4
	lw $t1, bgColour
	lw $t2, red
	
	lw $t5, p2Location 
	li $t4, BASE_ADDRESS
	add $t4, $t4, $t5
	addi $t4, $t4, -240
	addi $t3, $t4, -400

	# Move
	sw $t1, 0($t0)	
	addi $t0, $t0, 4
	sw $t2, 0($t0)

	# Reset location
	beq $t0, $t3, resetBullet
	move $s4, $t0
	jr $ra

resetBullet:
	sw $t1, 0($t0)	
	lw $t0, p2Location 
	li $t4, BASE_ADDRESS
	add $t4, $t4, $t0
	addi $t4, $t4, -240
	addi $s4, $t4, -504
	jr $ra
	
checkPlayerShot:
	move $t0, $s0
	move $t1, $s4
	beq $t0, $t1, shot
	addi $t0, $t0, 260
	beq $t0, $t1, shot
	addi $t0, $t0, 256
	beq $t0, $t1, shot
	addi $t0, $t0, -512
	beq $t0, $t1, shot
	addi $t0, $t0, -256
	beq $t0, $t1, shot
	jr $ra
shot:
	addi $s7, $s7, -1
	j resetBullet
	jr $ra
	
reachFinish:
	move $t0, $s0
	addi $t0, $t0, 8
	lw $t1, doorLocation
	li $t2, BASE_ADDRESS
	add $t1, $t1, $t2
	addi $t1, $t1, -20
	beq $t0, $t1, winner
	addi $t1, $t1, -256
	beq $t0, $t1, winner
	addi $t1, $t1, -256
	beq $t0, $t1, winner
	addi $t1, $t1, -256
	beq $t0, $t1, winner
	addi $t1, $t1, -256
	beq $t0, $t1, winner
	addi $t1, $t1, -256
	beq $t0, $t1, winner
	addi $t1, $t1, -256
	beq $t0, $t1, winner
	addi $t1, $t1, -256
	beq $t0, $t1, winner
	addi $t1, $t1, -256
	beq $t0, $t1, winner
	jr $ra

healthCollide:
	lw $t0, gold
	
	move $t4, $s0
	addi $t4, $t4, 8
	move $t5, $s1
	addi $t5, $t5, -256
	beq $t4, $t5, pickupHp
	addi $t5, $t5, -4
	beq $t4, $t5, pickupHp
	addi $t5, $t5, -256
	beq $t4, $t5, pickupHp
	addi $t5, $t5, 8
	beq $t4, $t5, pickupHp
	addi $t5, $t5, 256
	beq $t4, $t5, pickupHp
	addi $t4, $t4, 252
	beq $t4, $t5, pickupHp
	addi $t4, $t4, 256
	beq $t4, $t5, pickupHp
	addi $t4, $t4, -516
	beq $t4, $t5, pickupHp
	jr $ra
	
pickupHp:
	li $t0, 1
	beq $s6, $t0, pickedUp 
	# Get location of heart
	li $t0, 1
	move $t4, $s1
	beq $s6, $t0, updateHealthLoc
	
	# Delete
	lw $t1, bgColour
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, 8
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -8
	sw $t1, 0($t4)
	li $t6, 3
	addi $s7, $t6, 0
	addi $s6, $zero, 1
	jr $ra
pickedUp:
	jr $ra

checkHealth:
	li $t0, 3
	li $t1, 2
	li $t2, 1
	li $t3, 0
	beq $s7, $t0, full	# 3 lives
	beq $s7, $t1, mid	# 2 live	
	beq $s7, $t2, low	# 1 life
	beq $s7, $t3, dead	# 0 life
	
full:
	# Load stuff for fill health
	lw $t0, green
	li $t2, 0
	li $t3, 3
	li $t5, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 260
	
fillHealthFull:
	sw $t0, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, fillHealthFull
	addi $t5, $t5, 1
	addi $t4, $t4, 4
	addi $t2, $zero, 0
	bne $t5, $t3, fillHealthFull	
	jr $ra

mid:
	# Load stuff for fill health
	lw $t0, green
	lw $t1, red
	li $t2, 0
	li $t3, 3
	li $t5, 0
	li $t6, 2
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 260
	
fillHealthMid:
	sw $t0, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, fillHealthMid
	addi $t5, $t5, 1
	addi $t4, $t4, 4
	addi $t2, $zero, 0
	bne $t5, $t6, fillHealthMid
	
	# Delete health bar
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	jr $ra

low:
	# Load stuff for fill health
	lw $t0, green
	lw $t1, red
	li $t2, 0
	li $t3, 3
	li $t5, 0
	li $t6, 1
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 260
	
fillHealthlow:
	sw $t0, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, fillHealthlow
	
	addi $t5, $t5, 1
	addi $t4, $t4, 4
	addi $t2, $zero, 0
	bne $t5, $t6, fillHealthlow
	
	# Delete health bar
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 8
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	jr $ra
dead:
	j quit

	
moveHp:
	# Get location of heart
	li $t0, 1
	move $t4, $s1
	beq $s6, $t0, updateHealthLoc
	
	# Delete
	lw $t1, bgColour
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, 8
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -8
	sw $t1, 0($t4)
	
	# Update location
updateHealthLoc:
	move $t4, $s1
	beq $s2, -1, moveHpRight
	beq $s2, 1, moveHpLeft
	
moveHpLeft:
	addi $t4, $t4, -4
	move $s1, $t4
	lw $t3, p1Location
	addi $t3, $t3, -260
	li $t5, BASE_ADDRESS
	add $t3, $t3, $t5
	addi $t3, $t3, -48
	beq $t4, $t3, changeDirection
	j newHp

moveHpRight:
	addi $t4, $t4, 4
	move $s1, $t4
	lw $t3, p1Location
	addi $t3, $t3, -260
	li $t5, BASE_ADDRESS
	add $t3, $t3, $t5	
	beq $t4, $t3, changeDirection
	j newHp
	
changeDirection:
	li $t7, -1      
	mult $s2, $t7
	mflo $s2        
	j newHp         
	
newHp:
	li $t5, 1
	beq $s6, $t5, doneHp
	# Redraw
	lw $t1, red
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, 8
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -8
	sw $t1, 0($t4)
	jr $ra
doneHp:
	#li $t0, BASE_ADDRESS
	#move $s1, $t0
	jr $ra


moveEnemy1:
	# Get location of e1
	move $t4, $s3
	li $t2, 0
	li $t3, 4
deleteE1:
	# Delete
	lw $t1, bgColour
	sw $t1, 0($t4)
	addi $t2, $t2, 1
	addi $t4, $t4, -256
	bne $t3, $t2, deleteE1
	addi $t4, $t4, 516
	sw $t1, 0($t4)
	addi $t4, $t4, -8
	sw $t1, 0($t4)
	
	# Update location
	move $t4, $s3
	beq $s2, 1, moveE1right
	beq $s2, -1, moveE1left
	
moveE1left:
	addi $t4, $t4, -4
	move $s3, $t4
	j newE1

moveE1right:
	addi $t4, $t4, 4
	move $s3, $t4
	j newE1
	
newE1:
	lw $t1, purple
	li $t2, 0
	li $t3, 4
redrawE1:
	sw $t1, 0($t4)
	addi $t2, $t2, 1
	addi $t4, $t4, -256
	bne $t3, $t2, redrawE1
	addi $t4, $t4, 516
	sw $t1, 0($t4)
	addi $t4, $t4, -8
	sw $t1, 0($t4)
	jr $ra
	
keyPress:
	# Keyboard address
	lw $t7, keyboardAddress
	lw $t6, 0($t7)
	
    	# Branch if key is pressed
    	beq $t6, 1, keyPressTrue
	
	# No keypress
	jr $ra

keyPressTrue:
	li $t0, 0
	lw $t6, 4($t7)
	beq $t6, 100, moveRight	# D = move right
	beq $t6, 97, moveLeft	# A = move left
	beq $t6, 119, groundJump	# W = jump up
	beq $t6, 114, restart	# R = restart
	beq $t6, 113, quit # Q = quit
	beq $t6, 115, playerGravity      # S = move down
	jr $ra

moveRight:
# RIGHT WALL COLLISION
	# Player location 
	move $t0, $s0
	addi $t0, $t0, 12
	
	# Bottom right corner location (t2)
	lw $t1, gold
	li $t2, BASE_ADDRESS
	addi $t2, $t2, 8188
	li $t3, 28
	li $t4, 0
	
rightBarrier:
	beq $t0, $t2, endMoveRight
	addi $t4, $t4, 1
	addi $t2, $t2, -256
	bne $t3, $t4, rightBarrier
	# Load stuff for player
	lw $t1, bgColour
	move $t4, $s0

	# Delete player
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)
	
	# UPDATE LOCATION
	lw $t1, playerShirt
	move $t4, $s0
	addi $t4, $t4, 4
	
	# Draw player
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)

	move $t4, $s0
	addi $t4, $t4, 4
	move $s0, $t4
endMoveRight:
	jr $ra

moveLeft:
# LEFT WALL COLLISION
	# Player location 
	move $t0, $s0
	addi $t0, $t0, -4
	
	# Bottom corner location (t2)
	lw $t1, gold
	li $t2, BASE_ADDRESS
	addi $t2, $t2, 7936
	li $t3, 28
	li $t4, 0
	
leftBarrier:
	beq $t0, $t2, endMoveLeft
	addi $t4, $t4, 1
	addi $t2, $t2, -256
	bne $t3, $t4, leftBarrier
	
	# Load stuff for player
	lw $t1, bgColour
	move $t4, $s0

	# Delete player
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)
	
	# UPDATE LOCATION
	lw $t1, playerShirt
	move $t4, $s0
	addi $t4, $t4, -4
	
	# Draw player
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)
	
	move $t4, $s0
	addi $t4, $t4, -4
	move $s0, $t4
	
endMoveLeft:
	jr $ra

groundJump:
	# Check if jump is available
	bge $s5, 2, finishJump
	# Add 1 to jump counter
	addi $s5, $s5, 1
	
groundJumpLoop:
	# Load stuff for player
	lw $t1, bgColour
	move $t4, $s0

	# DELETE
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)
	
	# UPDATE LOCATION
	lw $t1, playerShirt
	move $t4, $s0
	addi $t4, $t4, -256
	
	# Draw player
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)
	
	move $t4, $s0
	addi $t4, $t4, -256
	move $s0, $t4
	
	# t6 = top left, t7 = top right 
	move $t6, $s0
	addi $t6, $t6, -512
	addi $t7, $t6, 8
	
	# Load P1
	li $t2, 0
	lw $t3, p1Length
	li $t4, BASE_ADDRESS
	lw $t5, p1Location
	add $t4, $t4, $t5

checkP1Head:
	beq $t7, $t4, finishJump
	beq $t6, $t4, finishJump
	addi $t4, $t4, -4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP1Head 
	
	# Load P2
	li $t2, 0
	lw $t3, p2Length
	li $t4, BASE_ADDRESS
	lw $t5, p2Location
	add $t4, $t4, $t5

checkP2Head:
	beq $t7, $t4, finishJump
	beq $t6, $t4, finishJump
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP2Head
	
	# Load P3
	li $t2, 0
	lw $t3, p3Length
	li $t4, BASE_ADDRESS
	lw $t5, p3Location 
	add $t4, $t4, $t5

checkP3Head:
	beq $t7, $t4, finishJump
	beq $t6, $t4, finishJump
	addi $t4, $t4, -4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP3Head
	
	# Health Bar
	li $t2, 0
	li $t3, 13
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 512

healthBarBottomCollision:
	beq $t7, $t4, finishJump
	beq $t6, $t4, finishJump
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, healthBarBottomCollision

	# Jump height = 8
	addi $t0, $t0, 1
	bne $t0, 7, groundJumpLoop

finishJump:
	jr $ra

playerGravity:
	# Get player location from s0, and modify
	move $t0, $s0
	addi $t0, $t0, 772	
	
	# Load stuff for floor
	lw $t1, gold
	lw $t7, red
	li $t2, 0
	li $t3, 64
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 7932
	
checkFloor:
	# PLAYER = T0, FLOOR = T4
	beq $t0, $t4, onPlatform
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, checkFloor
	
	# Load stuff for platform1
	li $t2, 0
	lw $t3, p1Length
	li $t4, BASE_ADDRESS
	lw $t0, p1Location
	add $t4, $t4, $t0

checkP1:
	move $t7, $s0
	addi $t7, $t7, 768
	addi $t6, $t7, 8
	beq $t7, $t4, onPlatform
	beq $t6, $t4, onPlatform
	addi $t4, $t4, -4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP1 
	
	# Load P2
	li $t2, 0
	lw $t3, p2Length
	li $t4, BASE_ADDRESS
	lw $t0, p2Location
	add $t4, $t4, $t0

checkP2:
	move $t7, $s0
	addi $t7, $t7, 768
	addi $t6, $t7, 8
	beq $t7, $t4, onPlatform
	beq $t6, $t4, onPlatform
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP2
	
	# Load P3
	li $t2, 0
	lw $t3, p3Length
	li $t4, BASE_ADDRESS
	lw $t0, p3Location 
	add $t4, $t4, $t0

checkP3:
	move $t7, $s0
	addi $t7, $t7, 768
	addi $t6, $t7, 8
	beq $t7, $t4, onPlatform
	beq $t6, $t4, onPlatform
	addi $t4, $t4, -4
	addi $t2, $t2, 1
	bne $t2, $t3, checkP3
		
pullDown:
	# Load stuff for player
	lw $t1, bgColour
 	li $t0, 0
	move $t4, $s0

	# DELETE
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)
    
	# UPDATE LOCATION
	lw $t1, playerShirt
	move $t4, $s0
	addi $t4, $t4, 256

    	# Draw player
   	sw $t1, 0($t4)
  	addi $t4, $t4, 4
    	sw $t1, 0($t4)
    	addi $t4, $t4, 4
   	sw $t1, 0($t4)
	addi $t4, $t4, 252
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -768
	sw $t1, 0($t4)
	move $t4, $s0
	addi $t4, $t4, 256	
	move $s0, $t4

onPlatform:
	jr $ra

restart:
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	li $t3, 0
	li $t4, 0
	li $t5, 0
	li $t6, 0
	li $t7, 0
	li $t8, 0
	li $t9, 0
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	li $s3, 0
	li $s4, 0
	li $s5, 0
	li $s6, 0
	li $s7, 0
	j main
	
quit:
	# Load stuff for background
	lw $t1, actuallyBlack
	li $t2, 0
	li $t3, 2048
	li $t4, BASE_ADDRESS
	
fillEndBg:
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, fillEndBg 
	
	# Load stuff for text
	lw $t1, bgColour
	li $t2, 0
	li $t3, 4
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2120
	li $t5, 0
	li $t6, 2
	
printYVert:
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	addi $t2, $t2, 1
	bne $t2, $t3, printYVert
	
	addi $t2, $zero, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2136
	addi $t5, $t5, 1
	bne $t5, $t6, printYVert

	# Print Y horizontal thing
	addi $t4, $t4, 764
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	
	# Print Y stem
	addi $t4, $t4, 260
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)

	# Load locations for O
	li $t2, 0
	li $t3, 6
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2660
	li $t5, 0
	li $t6, 2
	
printO:
	# Print vertical stuff for O
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	addi $t2, $t2, 1
	bne $t2, $t3, printO
	
	addi $t2, $zero, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2676
	addi $t5, $t5, 1
	bne $t5, $t6, printO
	addi $t5, $zero, 0
	addi $t4, $t4, 1276

	# Print horizontal stuff for O
printOHoriz:
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t5, $t5, 1
	addi $t4, $t4, -1276
	bne $t5, $t6, printOHoriz
	addi $t4, $t4, 1288
	sw $t1, 0($t4)
	
	# Load locations for U	
	li $t2, 0
	li $t3, 6
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2688
	li $t5, 0
	li $t6, 2
printU:
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	addi $t2, $t2, 1
	bne $t2, $t3, printU
	
	addi $t2, $zero, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2704
	addi $t5, $t5, 1
	bne $t5, $t6, printU

	# Print U horizontal thing
	addi $t4, $t4, 1276
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	
loseScreen:
	# Load locations for L
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 4684
	
	# Print L - Vertical
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	
	# Print L horizontal
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)

	# Load locations for O
	li $t2, 0
	li $t3, 6
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2660
	li $t5, 0
	li $t6, 2
	
printLoseO:
	# Print vertical stuff for O
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	addi $t2, $t2, 1
	bne $t2, $t3, printLoseO
	
	addi $t2, $zero, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 4980
	addi $t5, $t5, 1
	bne $t5, $t6, printLoseO
	addi $t5, $zero, 0
	addi $t4, $t4, 1276

	# Print horizontal stuff for O
printLoseOHoriz:
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t5, $t5, 1
	addi $t4, $t4, -1276
	bne $t5, $t6, printLoseOHoriz
	addi $t4, $t4, 1288
	sw $t1, 0($t4)

	addi $t4, $t4, 244
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	
	# Load locations for S
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 5008
	
	# Print S
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)

	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)

	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	
	# Load location for E
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 5036
	
	# Print E
	sw $t1, 0($t4)
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	
	# Load location for E
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 5292
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	j end

winner:
	# Load stuff for background
	lw $t1, actuallyBlack
	li $t2, 0
	li $t3, 2048
	li $t4, BASE_ADDRESS
	
fillEndBgw:
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	addi $t2, $t2, 1
	bne $t2, $t3, fillEndBgw 
	
	# Load stuff for text
	lw $t1, bgColour
	li $t2, 0
	li $t3, 4
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2120
	li $t5, 0
	li $t6, 2
	
printYVertw:
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	addi $t2, $t2, 1
	bne $t2, $t3, printYVertw
	
	addi $t2, $zero, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2136
	addi $t5, $t5, 1
	bne $t5, $t6, printYVertw

	# Print Y horizontal thing
	addi $t4, $t4, 764
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	
	# Print Y stem
	addi $t4, $t4, 260
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)

	# Load locations for O
	li $t2, 0
	li $t3, 6
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2660
	li $t5, 0
	li $t6, 2
	
printOw:
	# Print vertical stuff for O
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	addi $t2, $t2, 1
	bne $t2, $t3, printOw
	
	addi $t2, $zero, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2676
	addi $t5, $t5, 1
	bne $t5, $t6, printOw
	addi $t5, $zero, 0
	addi $t4, $t4, 1276

	# Print horizontal stuff for O
printOHorizw:
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t5, $t5, 1
	addi $t4, $t4, -1276
	bne $t5, $t6, printOHorizw
	addi $t4, $t4, 1288
	sw $t1, 0($t4)
	
	# Load locations for U	
	li $t2, 0
	li $t3, 6
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2688
	li $t5, 0
	li $t6, 2
printUw:
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	addi $t2, $t2, 1
	bne $t2, $t3, printUw
	
	addi $t2, $zero, 0
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 2704
	addi $t5, $t5, 1
	bne $t5, $t6, printUw

	# Print U horizontal thing
	addi $t4, $t4, 1276
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	addi $t4, $t4, -4
	sw $t1, 0($t4)
	
	winScreen:
	li $t4, BASE_ADDRESS
	addi $t4, $t4, 4680
	
	# Print W
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4	
	sw $t1, 0($t4)
	
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, 772
	
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	
	# Load location for I 
	addi $t4, $t4, 268
	
	# Print I
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	
	# Load location for N
	addi $t4, $t4, 12
		
	# Print N
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	
	addi $t4, $t4, 260
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 4
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	addi $t4, $t4, 256
	sw $t1, 0($t4)
	
	# Print !
	addi $t4, $t4, 12
	sw $t1, 0($t4)
	addi $t4, $t4, -512
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	addi $t4, $t4, -256
	sw $t1, 0($t4)
	j end
	
end:
	# terminate the program gracefully
	li $v0, 10 
	syscall
