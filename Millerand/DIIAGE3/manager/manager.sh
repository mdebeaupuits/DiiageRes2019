#!/bin/bash
FileName="/root/DiiageRes2019/cazelles/DIIAGE3/manager/data.txt"
function CheckHost() {
	NbrHost=$(awk '/Hostname='$Host'/{x+=1}END{print x}' $FileName)
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
	CheckHost
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
			AddFile
		else
		echo "Le serveur existe déja"
	
		fi

}

##Permet d'ajouter un fichier
function AddFile() {
	CheckVar $Host
	CheckVar $Ip

	#TestSSH $2 $3
	
	#Ajout dans le fichier
	if [ $varvide = 1 ]
	then
		echo "Une variable est vide"
	else
		CheckIP $Ip
		if [ $varip = 1 ]
			then
				echo "Ce n'est pas une adresse IP"
			else
				echo "IP=$Ip:Hostname=$Host:User=$Login:Auth=$Password:OS=$Os:Role=$Role:VLAN=$Vlan:Environnement=$Env" >> $FileName
		fi
	fi
}

##Permet de savoir si le paramètre Host est saisi
function CheckVar() {
	if [ -z "$Host" ];
	then
		varvide="1"
	else
		varvide="0"
	fi
}

##Fonction aidant a supprimer une entrée par rapport au nom
function DeleteFile() {
	sed -i "/Hostname=$Hostname/d" $FileName
}

#function TestSSH()
#	{
#		ssh $2@$1
#		return $?
#	}

function CheckIP()
{
	echo $Ip
    # Return true if $1 is a valid IP
    if [[ $Ip =~ ^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$ ]]
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
#Pas de demande à l'utilisateur
read -p "Saisir le nom de la machine à supprimer:" Hostname
DeleteFile 
fi 


if [ $1 = "edit" ] 
then
FunModifier 
fi


   
