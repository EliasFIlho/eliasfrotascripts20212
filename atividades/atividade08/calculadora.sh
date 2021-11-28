#!/bin/bash

TECLA=
VISOR=

until [ "$TECLA" = "q" ]
do
	clear
	tput cup 0 10
	printf "TELA: $VISOR " 
	tput cup 1 10
	printf "%d %d %d" 1 2 3	
	tput cup 2 10
	printf "%d %d %d" 4 5 6	
	tput cup 3 10
	printf "%d %d %d" 7 8 9	
	tput cup 4 10
	printf "%c %c %c %c" + - \* /
	tput cup 5 10
	
	read TECLA
	
	if [[ $VISOR =~ .*=.* ]]
	then
		VISOR=
	fi
	
	if [[ $TECLA =~ [0-9]+ ]]
	then
		if [ ! "$VISOR" ]
		then
			VISOR=$TECLA
		else
			if [[ $VISOR =~ [0-9]+[[:blank:]][*/\+\-] ]]
			then
				VISOR="$VISOR $TELCA =  $(echo "scale=2; $VISOR $TECLA" |bc )"  
			fi
		fi
	else
		if [[ $TECLA =~ [*/\+\-] ]]
		then
			VISOR="$VISOR $TECLA"
		fi
	fi
done
		
		
		
		
		
		
		
		
		
		
