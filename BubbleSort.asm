# Faculdade de Computacao
# Universidade Federal de Mato Grosso do Sul
# Arquitetura de Computadores I
# Prof. Liana Duenha

# Código de montagem do algoritmo de ordenação Bubble Sort.
# Acadêmicos: Aryslene Santos Bitencourt e Matheus Lima Machado

# Código em java:

#    public class BubbleSort {
#	public static void main (String[] args){
#	
#	File file = new File("arquivo.txt");
#	Scanner leitor = new Scanner(System.in);
#	int x, y, z=-1;
# 
#	x = leitor.nextInt();
#	int v[] = new int[x];
#	for(int i = 0; i < v.length; i++){
#		v[i] = leitor.nextInt();
#	}
#	while(z != 0){
#	    z = 0;
#		for(int i = 0; i < v.length-1; i++){
#			if(v[i] > v[i+1]){
#				y = v[i+1];
#				v[i+1] = v[i];
#				v[i] = y;
#				z++;
#			}
#		}
#	}
#	for(int i = 0; i < v.length; i++){
#		System.out.print(v[i] + " ");
#	}
#	
#     	}
#    }


# Código em mips:

.data
vetor:.word 3, 0, 1, 4, 2

.text
	addi $s7, $zero, 0     # i = 0
	add $s2, $zero, $zero  # aux = 0
	addi $s3, $zero, -1    # z = -1
	addi $s4, $zero, 4     # length = 3-1
	addi $t3, $zero, 0
	addi $t8, $zero, 0     # variavel que auxilia na seleção da proxima posicao do vetor.
	la $s6, vetor
	
while:  beq $s3, $zero, fimWhile # (z == 0) ?
	addi $s3, $zero, 0    # z = 0
	addi $s7, $zero, 0    # i = 0
	addi $t8, $zero, 0    # $t8 = 0
	
for:    beq $s7, $s4, fimFor # (i == vetor.length-1)?
	bgt $s7, $s4, fimFor # (i > vetor.length-1)?
	
if:     
	add $t1, $t8, $s6
	lw $t4,  ($t1)
	addi $t0, $s6, 4
	add $t0, $t8, $t0
	lw $t5, 0 ($t0)
	bgt $t5, $t4, fimIf  # (vetor[i+1] > vetor[i])?
	beq $t5 $t4, fimIf   # (vetor[i+1] == vetor[i])?
	add $s2, $zero, $t5  # aux = vetor[i+1]
	add $t5, $zero, $t4  # vetor[i+1] = vetor[i]
	add $t4, $zero, $s2  # vetor[i] = aux
	#atualizacao do vetor:
	sw $t4, vetor($t8)
	addi $t8, $t8, 4
	sw $t5, vetor($t8)
	subi $t8, $t8, 4
	#
	addi $s3, $s3, 1     # z++
fimIf:  addi $s7, $s7, 1     # i++ (incremento do for)
	addi $t8, $t8, 4     # $t8 + 4
	j for

fimFor: j while

fimWhile: 
	addi $t1, $zero, 0   # $t1 =0
   printWhile: 
   	beq $t1, 20, exit  # constante == length*4
	lw $t3, vetor($t1)
	addi $t1, $t1, 4
	li $v0, 1
	move $a0, $t3
	syscall
	j printWhile
exit:
	li $v0, 10
	syscall
