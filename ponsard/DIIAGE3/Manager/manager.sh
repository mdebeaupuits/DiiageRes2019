#!/bin/bash
filename="data.txt"

function testexist(){
	test=$(awk "/hostname=$hostname/ {print}" $filename)
	if [ "x$test" = "x" ]
	then
		exist=0
	else
		exist=1
	fi
}

function add(){
	echo "ip="$ip":hostname="$hostname":user="$user":password="$password":os="$os":distribution="$distribution":role="$role":environnement="$environnement  >>$filename
}

function edit(){
	echo ""
}

function remove(){
	sed -i "/hostname=$hostname/d" srvs
}


if [ $1 = "add" ]
then
	read -p "Saisir le nom d'hôte : " hostname
	testexist
	if [ $exist -eq 1 ]
	then
		echo "L'hote existe déjà"
		exit
	else
		read -p "Saisir l'adresse IP : " ip
		read -p "Saisir le nom d'utilisateur : " user
		read -p "Saisir le mot de passe : " password
		read -p "Saisir l'OS du serveur : " os
		read -p "Saisir la distribution : " distribution
		read -p "Saisir le rôle : " role
		read -p "Saisir l'environnement : " environnement
		add
	fi
fi
if [ $1 = "remove" ]
then
	read -p "Saisir le nom de l'hôte à modifier : " hostname
	testexist
	if [ $exist -eq 1 ]
	then
		edit
	else
		echo "L'hôte n'existe pas"
		exit
	fi
fi
if [ $1 = "remove" ]
then
	read -p "Saisir le nom de l'hôte à supprimer : " hostname
	testexist
	if [ $exist -eq 1 ]
	then
		remove
	else
		echo "L'hôte n'existe pas"
		exit
	fi
fi
