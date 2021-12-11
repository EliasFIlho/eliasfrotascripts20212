#!/bin/bash

action=0
host="vazio"
proc="vazio"
ip="vazio"



adicionar(){

	echo "$1 $2" | tee -a hosts.db


}


remover(){

	hostn=$1
	sed -i "/$hostn/d" hosts.db
}

listar(){

	cat hosts.db

}

procurar(){

	grep "${1}" hosts.db

}



while getopts "a:i:dl" OPTVAR
do
	if [ "$OPTVAR" == "a" ]
	then
		host=$OPTARG
		action=1
	fi
	
	if [ "$OPTVAR" == "i" ]
	then
		ip=$OPTARG
	fi
	
	
	if [ "$OPTVAR" == "d" ]
	then
		host=$OPTARG
		action=2
	fi
	
	if [ "$OPTVAR" == "l" ]
	then
		action=3
	fi
done


case $action in
	"1")
		adicionar $host $ip
	;;
	"2")
		remover $host
	;;
	"3")
		listar
	;;
		
	"0")
		procurar $host
	;;
	*)
		echo "Deu ruim na escolha ai camarada"
	;;



esac




