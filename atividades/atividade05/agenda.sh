#!/bin/bash

op=${1}
name=${3}
email=${2}

case ${op} in 
	adicionar)
	
		if [ -e agenda.db ]
		then
			echo " ${name}:${email}" >> agenda.db
			echo "Usuario ${name} adicionado"
		else
			echo " ${name}: ${email}" >> agenda.db
			echo "Arquivo criado! ! !"
			echo "Usuario ${name} adicionado"
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
		if grep ${email} agenda.db &> /dev/null
		then
			grep ${email} agenda.db &>/dev/null | sed '/$email/d' 
			grep ${email} agenda.db &>/dev/null | sed '/^$/d'
			 
		else
			echo "Usuario não encontrado"
		fi
		;;
	*)
		echo "erro"
esac
