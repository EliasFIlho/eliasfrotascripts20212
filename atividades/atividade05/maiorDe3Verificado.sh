#!/bin/bash
# Correção: 0,5
primeiro=${1}
segundo=${2}
terceiro=${3}

if expr ${primeiro} + 1 &> /dev/null
then
	if expr ${segundo} + 1 &> /dev/null
	then
		if expr ${terceiro} + 1 &> /dev/null
		then
			if [ \( ${primeiro} -gt ${segundo} \) -a \( ${primeiro} -gt ${terceiro} \) ]
			then
				echo ${primeiro}
			elif [ \( ${segundo} -gt ${primeiro} \) -a \( ${segundo} -gt ${terceiro} \) ]
			then
				echo ${segundo}
			elif [ \( ${terceiro} -gt ${segundo} \) -a \( ${terceiro} -gt ${primeiro}  \) ]
			then
				echo ${terceiro}
			fi
		else
			echo "Opa! ! ! ${terceiro} não é número."
		fi
	else
		echo "Opa! ! ! ${segundo} não é número."
	fi

else
	echo "Opa! ! ! ${primeiro} não é número."

fi
