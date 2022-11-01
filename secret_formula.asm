.data

krabby: .word 1 2 3 4 5 6 7 8 9 10

carray: .word 0:10

marray: .word 0:10

encrypted: .asciiz "Encrypted: "
decrypted: .asciiz "Decrypted: "
newline: .asciiz "\n"
comma: .asciiz ", "
.text
main:
	la $s0,krabby
	li $s1,10

	la $s2,carray
	la $s3,marray
	
	#fill in your loop here
	#feel free to use 2 loops if you need to
    li $a0 3
    li $a1 11
    li $t6 0
    loop: 
    bge $t6 $s1 loopexit
    lw $a2 0($s0)
    jal secret_formula_apply
    sw $v0 0($s2)
    move $a2 $v0
    jal secret_formula_remove
    sw $v0 0($s3)
    addi $t6 $t6 1
    addiu $s0 $s0 4
    addiu $s2 $s2 4
    addiu $s3 $s3 4
    j loop
    loopexit:
    li $t6 0
    la $a0 encrypted
    li $v0 4
    syscall
    li $t6 0
    addiu $s2 $s2 -40
    addiu $s3 $s3 -40
    printc:
    beq $t6 9 cexit
    lw $a0 0($s2)
    li $v0 1
    syscall
    la $a0 comma
    li $v0 4
    syscall
    addiu $s2 $s2 4
    addi $t6 $t6 1
    j printc
    cexit:
    lw $a0 0($s2)
    li $v0 1
    syscall
    la $a0 newline
    li $v0 4
    syscall
    la $a0 decrypted
    li $v0 4
    syscall
    li $t6 0
    printm:
    beq $t6 9 mexit
    lw $a0 0($s3)
    li $v0 1
    syscall
    la $a0 comma
    li $v0 4
    syscall
    addiu $s3 $s3 4
    addi $t6 $t6 1
    j printm
    mexit:
    lw $a0 0($s3)
    li $v0 1
    syscall

	j exit

secret_formula_apply:
#fill stuff here thanks
   addiu $sp $sp -4
   sw $ra 0($sp)
   li $t0 7
   mult $a0 $a1
   mflo $t1
   move $t2 $a2
   loop1:
   beq $t0 1 loopexit1
   mult $t2 $a2
   mflo $t2
   sub $t0 $t0 1
   j loop1
   loopexit1:
   div $t2 $t1
   mfhi $v0
   lw $ra 0($sp)
   addiu $sp $sp 4
   jr $ra
secret_formula_remove:
#fill more stuff here thanks
    addiu $sp $sp -4
    sw $ra 0($sp)
    li $t0 3
    mult $a0 $a1
    mflo $t1
    move $t2 $a2
    loop2:
    beq $t0 1 loopexit2
    mult $t2 $a2
    mflo $t2
    sub $t0 $t0 1
    j loop2
    loopexit2:
    div $t2 $t1
    mfhi $v0
    lw $ra 0($sp)
    addiu $sp $sp 4
    jr $ra
exit:
	li $v0, 10
	syscall
