# Alunos:
# Matheus Lima Machado
# rga: 201519060068

.data
num:.asciiz "Digite n: \n"
espaco: .asciiz " "
quebra: .asciiz "\n"

.text
main:	li $v0 4
	la $a0 num
	syscall
	li $v0 5
	syscall

	move $t0 $v0	
	
	#limpando os registradores:
	add $t1, $zero, $zero #l=0
	add $t2, $zero, $zero #c=0
	add $t3, $zero, $zero #x=0
	add $t4, $zero, $zero #y=0
	
	add $t4, $t0, $zero
	
	while1: bgt $t1, $t0, fimWhile1
		
		while2:	bgt $t3, $t4, fimWhile2
			li $v0 4
			la $a0 espaco
			syscall
			addi $t3, $t3, 1
			j while2
		fimWhile2:
		
		while3: bgt $t2, $t1, fimWhile3
			
			move $a0, $t1		#fat(l)
			jal fat
			move $s1, $v0
			
			move $a0, $t2		#fat(c)
			jal fat
			move $s2, $v0
			
			sub $t7, $t1, $t2	#fat(l-c)
			move $a0, $t7
			jal fat
			move $s3, $v0
			
			mul $s4, $s2, $s3	# op=fat(l)/(fat(c)*fat(l-c);
			div $s1, $s4
			mflo $t5
			
			move $a0, $t5
			li $v0 1
			syscall
			li $v0 4
			la $a0 espaco
			syscall
			
			addi $t2, $t2, 1
			j while3
		fimWhile3:
		
		li $v0 4
		la $a0 quebra
		syscall
		
		addi $t1, $t1, 1
		add $t2, $zero, $zero
		addi $t4, $t4, -1
		add $t3, $zero, $zero
		add $t3, $zero, $zero
		j while1
		
	fimWhile1:
		
		li $v0 10	# Fim do programa
		syscall
		
	fat:    addi $sp, $sp, -8
		sw $ra, 4 ($sp) 				
		sw $a0, 0 ($sp)	
		slti $s0, $a0, 1
		beq $s0, $zero, else
		addi $v0, $zero, 1
		addi $sp, $sp, 8
		jr $ra
			
	else:   addi $a0, $a0, -1
		jal fat
		lw $a0, 0 ($sp)
		lw $ra, 4 ($sp)
		addi $sp, $sp, 8
		mul $v0, $a0, $v0
		jr $ra 