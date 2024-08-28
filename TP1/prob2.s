.data

##### R1 START MODIFIQUE AQUI START #####

#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
# auxiliares: 
	addi a4, zero, 0 # i
	addi a5, zero, 0 # V[i]
	addi a6, zero, 0 # offset = i * 4
    addi a7, zero, 0 # auxiliar para segundo vetor
	addi x28, zero, 0 # resultado
    
    addi x29, zero, 0 # aux resultado media v1
    addi x30, zero, 0 # aux resultado media v1
#

vetor1: .word 1 2 3 4 #Primeiro vetor
vetor2: .word 1 1 1 1 #Segundo vetor

##### R1 END MODIFIQUE AQUI END #####
      
.text    

        add s0, zero, zero
        la a0, vetor1
        addi a1, zero, 4
        jal ra, media
        addi t0, zero, 2
        bne a0,t0,teste2
        addi s0,s0,1
teste2: la a0, vetor2
        addi a1, zero, 4
        jal ra, media
        addi t0, zero, 1
        #bne a0,t0, FIM
        bne a0,t0, testeCov
        addi s0,s0,1
        #beq zero,zero, FIM

testeCov: 	la a0, vetor1 #Ponteiro Vetor 1
			la a1, vetor2 #Ponteiro Vetor 2
			addi a2, zero, 4        #Quantidade de elementos dos vetores
			jal ra, covariancia
			addi t0, zero, 0
			bne a0,t0, FIM
			addi s0,s0,2
			beq zero,zero, FIM

##### R2 START MODIFIQUE AQUI START #####

# Esse espaço é para você escrever o código dos procedimentos. 
# Por enquanto eles estão vazios

media: 
	beq a1, a4, end_m    # fim do vetor
    add a6, a0, a6       # Calcula o endereço do elemento atual do vetor
    lw a5, 0(a6)         # Carrega o valor do vetor V[i] em a5
  	add x28, x28, a5  	 # Soma += V[i]
    addi a4, a4, 1       # i = i + 1
    slli a6, a4, 2       # a6 = offset = i * 4
	beq x0, x0, media

end_m: 
	div x28, x28, a4 		# Resultado = soma/tam
    addi a0, x28, 0       	# resultado no registrador certo
    
    addi x28, zero, 0 		# zera o auxiliar de resultado
    addi a4, zero, 0 		# zera i - contador de repeticoes ate o tamanho e offset
    addi a6, zero, 0 		# zera offset = i * 4
    
    jalr zero, 0(ra)
    
covariancia: #os ponteiros para os vetores foram alterados para reutilizar a funcao media com o teste def. no enunciado inicial
	add a2, ra, zero     # salva o valor de ra em t3 = x28
    
    addi a1, zero, 4	# definicao do tamanho dos vetores
	la a0, vetor1 		# chamada de media para vetor 1
    jal ra, media
    add x29, zero, a0 	# x29 = aux resultado media v1
    la a0, vetor2 		# chamada de media para vetor 2
    jal ra, media
    add x30, zero, a0 	# x30 = aux resultado media v2
    addi x28, zero, 0 	# zera o x28 para ser usado como resultado da covariancia
    
    la t1, vetor1 	# carrega o endereço do inicio do vetor 1 no t1 = x6
    la t2, vetor2 	# carrega o endereço do inicio do vetor 2 no t2 = x7
    
    add ra, a2, zero     # restaura o valor de ra, t3 = x28
    addi a4, zero, 0 # OPICIONAL
    
LoopCov:
	beq a1, a4, end_c    # fim do vetor
    add a6, t1, a6       # Calcula o endereço do elemento atual do vetor1
	add a7, t2, a7       # Calcula o endereço do elemento atual do vetor2
    lw a5, 0(a6)         # Carrega o valor do vetor V1[i] em a5
    lw x31, 0(a7)		 # Carrega o valor do vetor V2[i] em x31
    sub a5, a5, x29  	 # a5 = V1[i] - media(V1) 
	sub x31, x31, x30	 # x31 = V2[i] - media(V2)
    mul a5, a5, x31		 # a5 = a5 * x31
    add x28, x28, a5 	 # Resultado += a5
    addi a4, a4, 1       # i = i + 1
    slli a6, a4, 2       # a6 = offset = i * 4
    slli a7, a4, 2		 # a7 = offset = i * 4
	beq x0, x0, LoopCov

end_c:
	addi a4, a4, -1			# Tamanho --
	div x28, x28, a4 		# Resultado = soma/tam-1
    add a0, zero, x28       # resultado no registrador certo (a0)
    
    addi x28, zero, 0 		# zera o auxiliar de resultado
    addi x29, zero, 0		# zera o auxiliar da media 1
    addi x30, zero, 0		# zera o auxiliar da media 2
    addi a4, zero, 0 		# zera i - contador de repeticoes ate o tamanho e offset
    addi a6, zero, 0 		# zera offset = i * 4
    addi a7, zero, 0 		# zera offset = i * 4
    
	jalr zero, 0(ra)

##### R2 END MODIFIQUE AQUI END #####

FIM: add t0, zero, s0