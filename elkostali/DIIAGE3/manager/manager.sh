#!/bin/bash
function verifExist(){
	if [ -z $HOSTNAME ]
	then
		echo "Entrez un hostname !"
		exit
	fi
	verifHostname=$(awk "/Hostname=$HOSTNAME/ {print}" $config)
	if [ "x$verifHostname" != "x" ]
        then
		exist=1
	else
		exist=0
	fi
	return $exist
	
}
function verifIP(){
	regex='^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}'
	regex+='0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))$'

	if ! [[ $IP =~ $regex ]]; then
		echo "Mauvaise format d'adresse ip ! "
		exit
	fi

	#if [ $AUTH != "cle" ]
	#then
	#	nohup "ssh-copy-id root@$IP -o \"ConnectTimeout 2\" "
	#fi
	#testHostname=$(nohup "ssh root@$IP \"hostname\" -o \"ConnectTimeout 2\"")
	#if [ -z $testHostname ]
	#then
	#	echo "La connexion SSH a échoué"
	#	exit
	#fi
	
}
function ajout(){
	local IP=$1 HOSTNAME=$2 COMPTE=$3 AUTH=$4 OS=$5 ROLE=$6 VLAN=$7 ENVIRONNEMENT=$8
	echo "IP=$IP:Hostname=$HOSTNAME:Compte=$COMPTE:Auth=$AUTH:OS=$OS:Role=$ROLE:VLAN=$VLAN:Environnement=$ENVIRONNEMENT" >> $config 
	return $?
}
function supprimer(){
	sed -i"$config" "/Hostname=$HOST/d" $config
	return $?
}
function modifier(){
	ligne=$(grep $HOSTNAME $config)
	sed -i"$config" "s/$OPTION=.*:/$OPTION=$nvValeur:/g" $config
	return $?
}



config="data.txt"
if [ $# -lt 1 ]
then
	echo "$0 [ajout|supprimer|modfifier] (-h hostname -i\"IP=@IP:Compte=root...\" "
	exit 1
fi
if [ $1 = "ajout" ]
then
	if [ ! -e $config ]
	then
		touch $config
	fi
        read -p "Hostname : " HOSTNAME
	verifExist
	if [ $exist -eq 1 ]
	then
		echo "Il existe déja un hôte avec ce nom"
		exit
	fi
        read -p "Compte : " COMPTE
        read -p "Authentification (saisir le mot de passe [mdp] ou si les clé SSH ont déja été echangées [cle]) : " AUTH
        read -p "IP : " IP
	verifIP
        read -p "OS : " OS
        read -p "Role : " ROLE
        read -p "VLAN : " VLAN
        read -p "Environnement : " ENVIRONNEMENT
	ajout $IP $HOSTNAME $COMPTE $AUTH $OS $ROLE $VLAN $ENVIRONNEMENT
	if [ $? -ne 0 ]
	then
		echo "Problème lors de l'ajout"
		exit
	fi
fi
if [ $1 = "supprimer" ]
then
	read -p "Quel hôte supprimer ? " HOST
        verifExist
        if [ $exist -eq 0 ]
        then
                echo "L'hote n'existe pas !"
                exit
        fi
	supprimer
        if [ $? -ne 0 ]
        then
                echo "Problème lors de la suppression"
                exit
        fi
fi

if [ $1 = "modifier" ]
then
	#shift
	#HOSTNAME=$2
	#echo $HOSTNAME
	read -p "Quel hôte modifier ? " HOSTNAME
        verifExist
	read -p "Quelle propriété modifier ?" OPTION
	read -p "Quelle est sa nouvelle valeur" nvValeur
	
        if [ $exist -eq 0 ]
        then
                echo "L'hote n'existe pas !"
                exit
        fi
        modifier
        if [ $? -ne 0 ]
        then
                echo "Problème lors de la modification"
                exit
        fi
fi
