#!/bin/bash
FileName="data.txt"
function CheckFile() {
	NbrHost=$(awk '/HOST='$1'/{x+=1}END{print x}' $FileName)
	if [ $NbrHost > 0 ]
	then
		exist="1"
	else
		exist="0"
	fi
}
function ReadHost() {
	#Interaction utilisateur
	echo "Nom d'hote"
	read Host
	if [ "$Host" = "" ]
		then
		echo "Il faut au moins rentrer un hote!"
		exit
fi
	CheckFile $Host
	if [ $exist = "0" ]
	then
		echo "Adresse IP"
		read Ip
		if [ "$Ip" = "" ]
			then
			echo "Il faut au moins rentrer une IP!"
			exit
		fi
		#echo $Ip
		if [[ $Ip =~  "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$" ]]
			then
				echo "Ce n est pas une adresse IP valable !"
				exit
			else
		echo "Compte utilisateur a utiliser"
		read Login
		echo "Mot de passe du compte"
		read Password
		echo "OS"
		read Os
		echo "Role de ce serveur"
		read Role
		echo "Vlan"
		read Vlan
		echo "Environnement (Production / Recette / Developpement)"
		read Env
		AddFile $Host $Ip $Login $Password $Os $Role $Vlan $Env 
		fi
	else
		echo "Le serveur existe déja"
	fi
}

##Permet d'ajouter un fichier
function AddFile() {
	CheckVar $1
	CheckVar $2
	#Ajout dans le fichier
	if [ $varvide = 1 ]
	then
		echo "Une variable est vide"
	else
		echo "HOST=$1:IP=$2:UTIL=$3:MDP=$4:OS=$5:ROLE=$6:VLAN=$7:ENV=$8" >> $FileName
	fi
}

##Permet de savoir si le paramètre Nom est saisi
function CheckVar() {
	if [ -z "$1" ];
	then
		varvide="1"
	else
		varvide="0"
	fi
}

##Fonction aidant a supprimer une entrée par rapport au nom
function DeleteFile() {
	sed -i "/HOST=$Hostname/d" $FileName
}

#Fonction check Ip

function CheckIP() {
if [ "$1" = "" ]
	then
	ipempty="1"
	echo "Veuillez mettre une IP valable"
	exit
	else
	ipempty="0"

	if [[ $1 =~ "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$" ]]
		then
		ipok="1"
		else
		ipok="0"
	fi
if
}

##Permet de selectionner les options

if [ $1 = "add" ] 
then
ReadHost 
fi 

if [ $1 = "del" ] 
then
read Hostname
DeleteFile 
fi 


if [ $1 = "edit" ] 
then
FunModifier 
fi
