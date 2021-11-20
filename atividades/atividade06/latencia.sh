#!/bin/bash
# Correção: 0,5. Se são vários IPs, você deveria ir anexando para depois tratar.

lista=${1}
ping_number=10

for i in $(cat ${lista} | wc -l)
do

	sed -n "$i p" $lista | xargs ping -c ${ping_number} | cut -f7 -d' '| sed "s/data.\|time=\|tempo=//g" | sed "/^$/d" > ms.txt
	
	#sed -i "s/perda\|lost//g" ms.txt | sed "/^$/d"	
	
	SUM=$(paste -sd+ ms.txt | bc)	
	echo " $(sed -n "$i p" $lista) $(${SUM}/${ping_number} | bc) "
	rm ms.txt
done
