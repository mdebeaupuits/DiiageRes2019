#!/bin/bash

function add()
{
	echo "hostname="$1":ip="$2":user="$3":mdp="$4":os="$5":role="$6>>data.txt
}

function del()
{
	sed -i "/$hostname/d" data.txt
}

function mod()
{
	data=$(awk /"$1"/ data.txt | awk -F":" '{print $1}')
	echo "data" $data
	echo "2" $2
	echo "3" $3
	sed -i 's/"$data"/"$2"="$3"/g' data.txt
}

echo "Enter add, del or mod" ; read choose

if [ $choose = "add" ]
then
	echo "type hostname, ip, user, mdp, os, role"
	read hostname ip user mdp os role
	search=$(awk /"$hostname"/ data.txt)
	if [ "x$search" != "x" ]
	then
		echo "hostname exist"
	else
		add $hostname $ip $user $mdp $os $role
	fi
elif [ $choose = "del" ]
then
	read hostname
	del $hostname
	echo "type hostname"
elif [ $choose = "mod" ]
then
	cat data.txt
	echo "type hostname type and value"
	read host typ value
	mod $host $typ $value
else
	echo "Ajouter,supprimer ou modifier n a pas ete entré"
fi

echo "contenu du fichier fic : "
cat data.txt
