#!/bin/bash

TIME=$1
WAY=$2
aux=$(ls ${WAY} -la|grep -e "^-"|wc -l)




while true
do
	echo "$(ls ${WAY} -la|grep -e "^-"| cut -d" " -f12)" >> temp.txt
	#cont=$(ls ${WAY} | wc -l)
	cont=$(ls ${WAY} -la|grep -e "^-"|wc -l)
	if [ ${aux} -lt ${cont} ]
	then
		
		echo "$(ls ${WAY} -la|grep -e "^-"| cut -d" " -f12)" >> temp2.txt
		
		echo "$(date +%F\ %T) ${aux} -> ${cont}. Adicionados: $(diff temp.txt temp2.txt | cut -d":" -f2)" >> dirSensors.log
		
		rm temp2.txt
	
	elif [ ${aux} -gt ${cont} ]
	then
	
		echo "$(ls ${WAY} -la|grep -e "^-"| cut -d" " -f12)" >> temp2.txt
		
		echo "$(date +%F\ %T) ${aux} -> ${cont}. Removidos: $(diff temp.txt temp2.txt |sed "1d" | cut -d" " -f2)" >> dirSensors.log
		rm temp2.txt


	fi
	rm temp.txt
	aux=${cont}
	
	sleep ${TIME}
	
done
