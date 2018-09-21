#!/bin/bash
#Aucun commentaire dans le code pour expliquer les commandes !!

#Fonction permettant de verifier si un hote existe deja
function checkExist(){
	if [ -z $HOSTNAME ]
	then
		echo "Entrez un hostname !"
		exit
	fi
	checkHostname=$(awk "/Hostname=$HOSTNAME/ {print}" $config)
	if [ "x$checkHostname" != "x" ]
        then
		exist=1
	else
		exist=0
	fi
	return $exist
}
#Fonction permettant de verifier si une IP existe deja
function checkIP(){
	regex='^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}'
	regex+='0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))$'

	if ! [[ $IP =~ $regex ]]; then
		echo "Mauvaise format d'adresse ip ! "
		exit
	fi

	ssh -o ConnectTimeout=5 $IP echo "" > /dev/null 2>&1
    	if [ $? -ne 0 ]
    	then
		echo "L'hote ne répond pas !"
    		exit
    	fi
}

#Mettre des espaces pour affichage meilleur
#fonction permettant d'ajouter un hote au fichier
function add(){
	local IP=$1 HOSTNAME=$2 COMPTE=$3 AUTH=$4 OS=$5 ROLE=$6 VLAN=$7 ENVIRONNEMENT=$8
	echo "IP=$IP:Hostname=$HOSTNAME:Compte=$COMPTE:Auth=$AUTH:OS=$OS:Role=$ROLE:VLAN=$VLAN:Environnement=$ENVIRONNEMENT" >> $config 
	return $?
}
#Fonction permettant de supprimer un hote du fichier
function delete(){
	sed -i"$config" "/Hostname=$HOST/d" $config
	return $?
}
#Fonction permettant d'editer un hote du fichier
function edit(){
	ligne=$(grep $HOSTNAME $config)
	sed -i"$config" "s/$OPTION=.*:/$OPTION=$nvValeur:/g" $config
	return $?
}


#Declaration du fichier dans lequel on va stocker les postes
config="data.txt"
if [ $# -lt 1 ]
then
	echo "$0 [add|delete|edit] (-h hostname -i\"IP=@IP:Compte=root...\" "
	exit 1
fi
if [ $1 = "add" ]
then
	if [ ! -e $config ]
	then
		touch $config
	fi
        read -p "Hostname : " HOSTNAME
	checkExist
	if [ $exist -eq 1 ]
	then
		echo "Il existe déja un hôte avec ce nom"
		exit
	fi
        read -p "Compte : " COMPTE
        read -p "Authentification (saisir le mot de passe [mdp] ou si les clé SSH ont déja été echangées [cle]) : " AUTH
        read -p "IP : " IP
	checkIP
        read -p "OS : " OS
        read -p "Role : " ROLE
        read -p "VLAN : " VLAN
        read -p "Environnement : " ENVIRONNEMENT
	add $IP $HOSTNAME $COMPTE $AUTH $OS $ROLE $VLAN $ENVIRONNEMENT
	if [ $? -ne 0 ]
	then
		echo "Problème lors de l'ajout"
		exit
	fi
fi
if [ $1 = "delete" ]
then
	read -p "Quel hôte supprimer ? " HOST
        checkExist
        if [ $exist -eq 0 ]
        then
                echo "L'hote n'existe pas !"
                exit
        fi
	delete
        if [ $? -ne 0 ]
        then
                echo "Problème lors de la suppression"
                exit
        fi
fi
if [ $1 = "edit" ]
then
	#shift
	#HOSTNAME=$2
	#echo $HOSTNAME
	read -p "Quel hôte modifier ? " HOSTNAME
        checkExist
	read -p "Quelle propriété modifier ?" OPTION
	read -p "Quelle est sa nouvelle valeur" newValue

        if [ $exist -eq 0 ]
        then
                echo "L'hote n'existe pas !"
                exit
        fi
        edit
        if [ $? -ne 0 ]
        then
                echo "Problème lors de la modification"
                exit
        fi
fi
