#!/bin/bash
filename="data.txt"

function testexist(){
	testhost=$(awk "/hostname=$hostname/ {print}" $filename)
	if [ "x$testhost" = "x" ]
	then
		exist=0
	else
		exist=1
	fi
}

function testinteg(){
	#Verification du format des adresses IP
	ip2=$ip
    	stat=1
    	if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
	then
        	OIFS=$IFS
        	IFS='.'
        	ip2=($ip)
        	IFS=$OIFS
        	[[ ${ip2[0]} -le 255 && ${ip2[1]} -le 255 && ${ip2[2]} -le 255 && ${ip2[3]} -le 255 ]]
        	result=$?
    	fi
    	return $result
}

function testssh(){
	#Verification des serveur via test SSH
	ssh $user@$ip
	return $?
}

function add(){
	#Ecriture du fichier
	echo "ip="$ip":hostname="$hostname":user="$user":password="$password":os="$os":distribution="$distribution":role="$role":environnement="$environnement  >>$filename
}

function edit(){
	echo ""
}

function remove(){
	#Suppression d un element dans le fichier data
	sed -i "/hostname=$hostname/d" $filename
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
            read -p "Saisir le nom d'utilisateur : " user
	    read -p "Saisir le mot de passe : " password
	    read -p "Saisir l'adresse IP : " ip
	    testinteg
	    if [ $? -eq 1 ]
            then
            	echo "Adresse IP incorrecte"
                exit
            else
		testssh
		if [ $? -eq 1]
		then
		   echo "Impossible de contacter l'hote"
		   exit
		else
    		    read -p "Saisir l'OS du serveur : " os
		    read -p "Saisir la distribution : " distribution
		    read -p "Saisir le rôle : " role
		    read -p "Saisir l'environnement : " environnement
		    add
                fi
	    fi
    fi
fi

if [ $1 = "edit" ]
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
