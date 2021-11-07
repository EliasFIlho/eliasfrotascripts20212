#!/bin/bash

op=${1}
p1=${2}
p2=${3}

case ${op} in 
	adicionar)
	
		if [ -e agenda.db ]
		then
			echo " ${p1}:${p2}" >> agenda.db
			echo "Usuario ${p1} adicionado"
		else
			echo " ${p1}: ${p2}" >> agenda.db
			echo "Arquivo criado! ! !"
			echo "Usuario ${p1} adicionado"
		fi
		;;
	listar)
		if [ -e agenda.db ]
        	then
               	 cat agenda.db
            	else
                	echo "Arquivo vazio ! ! !"
            	fi
		;;
	remover)
		if grep ${p1} agenda.db &> /dev/null
		then
			sed "/$p1/d" agenda.db &>/dev/null

			 
		else
			echo "Usuario não encontrado"
		fi
		;;
	*)
		echo "erro"
esac
