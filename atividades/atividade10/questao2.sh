#!/bin/bash


lista=${1}
ping_number=10

for i in $(cat ${lista} | wc -l)
do
	echo $(sed -n "$i p" $lista | xargs ping -c ${ping_number} | grep -v "PING") >> pings.txt

done

awk '{split($4,a,":")}{split($7,b,"tempo=")}{print a[1] " " b[2] $8}' pings.txt

