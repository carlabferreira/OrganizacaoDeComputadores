.data

##### R1 START MODIFIQUE AQUI START #####
# Este espaço é para você definir as suas constantes e vetores auxiliares.
# Aluno: Carla Beatriz Ferreira (2022097470)

# a0: endereço de início do vetor
# a1: tamanho do vetor
# a2: inteiro que deve ser verificado (quantos múltiplos do mesmo existem) 

auxiliares: 

	addi a5, zero, 0 # V[i]
	addi a6, zero, 0 # offset = i * 4
	addi a7, zero, 0 # auxiliar do resto da divisao
	addi x28, zero, 0 # resultado
#

vetor: .word 1 2 3 4 5 6 7 8 9 10


##### R1 END MODIFIQUE AQUI END #####

.text
        add s0, zero, zero #Quantidade de testes em que seu programa passou
        la a0, vetor
        addi a1, zero, 10
        addi a2, zero, 2
        jal ra, multiplos
        addi t0, zero, 5
        bne a0,t0,teste2
        addi s0,s0,1
teste2: la a0, vetor
        addi a1, zero, 10
        addi a2, zero, 3
        jal ra, multiplos
        addi t0, zero, 3
        bne a0,t0, FIM
        addi s0,s0,1
        beq zero,zero,FIM

##### R2 START MODIFIQUE AQUI START #####
multiplos: 
    beq a1, a4, end_m    # fim do vetor
    add a6, a0, a6        # Calcula o endereço do elemento atual do vetor
    lw a5, 0(a6)          # Carrega o valor do vetor V[i] em a5
    rem a7, a5, a2        # Calcula o resto da divisão de V[i] (a5) por a2 e armazena em a7
    addi a4, a4, 1        # i = i + 1
    slli a6, a4, 2        # a6 = offset = i * 4
    bne a7, x0, multiplos # se nao for multiplo, proxima iteracao
    addi x28, x28, 1      # se multiplo adiciona um ao resultado
    beq x0, x0, multiplos

end_m: 
    addi a0, x28, 0       	# resultado no registrador certo
    
    addi x28, zero, 0 		# zera o auxiliar de resultado
    addi a4, zero, 0 		# zera i - contador de repeticoes ate o tamanho e offset
    addi a6, zero, 0 		# zera offset = i * 4
    
    jalr zero, 0(ra)
##### R2 END MODIFIQUE AQUI END #####

FIM: addi t0, s0, 0

