#!/bin/bash
FileName="data.txt"
function CheckHost() {
	NbrHost=$(awk '/HOST='$1':IP='$2'/{x+=1}END{print x}' $FileName)
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
	CheckHost $Host
		if [ $exist = "0" ]
		then
			echo "Adresse IP"
			read Ip
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
		else
		echo "Le serveur existe déja"
	
		fi

}

##Permet d'ajouter un fichier
function AddFile() {
	CheckVar $1
	CheckVar $2

	#TestSSH $2 $3
	
	#Ajout dans le fichier
	if [ $varvide = 1 ]
	then
		echo "Une variable est vide"
	else
		CheckIP $2
		if [ $varip = 1 ]
			then
				echo "Ce n'est pas une adresse IP"
			else
				echo "HOST=$1:IP=$2:UTIL=$3:MDP=$4:OS=$5:ROLE=$6:VLAN=$7:ENV=$8" >> $FileName
		fi
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

#function TestSSH()
#	{
#		ssh $2@$1
#		return $?
#	}

function CheckIP()
{
	echo $1
    # Return true if $1 is a valid IP
    if [[ $1 =~ ^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$ ]]
	then
		varip="0"
	else
		varip="1"
	fi
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


   
