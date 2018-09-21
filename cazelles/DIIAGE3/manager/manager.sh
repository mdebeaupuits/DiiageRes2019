#!/bin/bash
txt=./data.txt
function add(){
	echo "IP=$ip:Hostname=$host:User=$user:Password=$password:OS=$os:Distrib=$distrib:Role=$role:VLAN=$vlan:Env=$environnement" >> $txt
	return $?
	echo "serveur déjà existant"
}
function remove(){
	sed -i "/Hostname=$hostrm/d" $txt
	return $?
}

if [ $# -eq 0 ]
then
	exit
fi
if [ $1 = "add" ]
then
	read -p "@ IP:" ip
	if ! [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]];
	then
		echo "Entrez une adresse IPV4"
		exit
	fi
	read -p "Hostname:" host
	check=$(cat $txt | grep "Hostname=$host")
        if [[ "t$check" != "t" || $host = "" ]];
        then
		echo "Le serveur est déjà présent dans le fichier ou vous n'avez pas entré de nom"
		exit
	fi
	read -p "User:" user
	read -p "Password:" password
	read -p "OS:" os
	read -p "Distrib :" distrib
	read -p "Rôle :" role
	read -p "VLAN :" vlan
	read -p "Environnement :" environnement
	add
fi
if [ $1 = "remove" ]
then
	read -p "Quelles machine supprimer:" hostrm
	remove
fi
if [ $1 = "edit" ]
then
	echo "lol"
fi
