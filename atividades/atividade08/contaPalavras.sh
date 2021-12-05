#!/bin/bash
# Correção: 0,1. Não executa por um erro de sintaxe na inicialização de uma variável. Mesmo fazendo a alteração, continua sem funcionar.

arq=$1


vet=($(cat ${arq}))
axu=
cont=	0
for i in $(cat ${arq} | wc -w )
do
	aux=${vet[i]}
	for j in $(cat ${arq} | wc -w )
	do
		if [ ${aux} = ${vet[j]} ]
		then
			cont="$(expr ${cont} + 1)"
		fi		
	done
	echo "${aux}: ${cont}"
	cont=0
done
