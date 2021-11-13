#!/bin/bash


mkdir cinco

for i in $(seq 1 5)
do

	mkdir cinco/dir${i}
	
	for j in $(seq 4)
	do
		
		
		for l in $(seq ${j})
		do
			
			echo "${j}" >> cinco/dir${i}/arq${j}.txt
			
		done
		
	done
	


done
