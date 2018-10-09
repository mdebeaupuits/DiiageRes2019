#!/bin/bash
#Proposition d'amélioration :
#Création de la fonction d'édition

#On déclare le fichier dans lequel on ajoutera,modif,suppr les PC
confFile=data.txt

#fonction permettant de vérifier si un hote existe deja dans la liste
function checkHostname()
{
	if [ -z "$HOSTNAME"  ]
	then
		echo "Veuillez saisir un nom d'hote"
		exit
	fi

	verify=$(awk /"HOSTNAME=$HOSTNAME/ {print}" $confFile)
        if [ "x$verify" = "x" ]
        then
                existHostname=0
	else
		existHostname=1
        fi
}

#Fonction permettant de verifier si une IP existe deja
function checkDoubleIP()
{
	verifyIP=$(awk "/IP=$IP/ {print}" $confFile)
	if [ "x$verifyIP" = "x" ]
	then
		existIP=0
	else
		existIP=1
	fi
}

#Fonction permettant de verifier si une IP a le bon format et connection ssh
function checkIPFormat()
{
	re='^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}'
	re+='0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))$'

	if ! [[ $IP =~ $re ]];
	then
  		echo "Adresse IP INCORRECT"
		exit
	fi

	ssh -o ConnectTimeout=5 $IP echo "" > /dev/null 2>&1
	if [ $? -ne 0 ]
	then
		echo "L'hote est pas dispo "
		exit
	fi
}


#Fonction permettant d'ajouter un hote a la liste
#Changement de l'affichage
function add()
{
	echo "IP=$IP:Hostname=$HOSTNAME:Compte=$COMPTE:Auth=$AUTH:OS=$OS:Role=$ROLE:VLAN=$VLAN:Environnement=$ENVIRONNEMENT" >> $confFile
}

function edit () {
	LIGNE=$(grep $HOSTNAME $confFile)
	echo "Copier coller cette ligne puis modifier la : "
	echo "$LIGNE"
	read NEWVALUE
        sed -i "s/$LIGNE/$NEWVALUE/g" $confFile
        #Retour erreur
        if [[ $? -ne 0 ]]
        then
                echo "Echec lors de la modification"
                return $?
        fi
}

#Fonction permettant de supprimer un hote de la liste
#Pas de message d'erreur si on tente de supprimer un hôte nexistant pas
function delete()
{
	sed -i "/$HOSTNAME/d" $confFile
}


#Tester le nombre de param, si pas 1 param alors on affiche l'aide de la cmd
#MESSAGE D'ERREUR LORS DE LEXEC DU SCRIPT SANS PARAMETRE
if [ $# -ne 1 ]
then
	echo "Utilisation : NomScript + add | edit | delete "
	exit
fi

#Verification de l'existence du fichier de configuration
if [ ! -e $confFile ]
then
	touch $confFile
fi

#Si le param est ajouter alors on appel la fonction ajouter
if [ $1 = "add" ]
then
	echo "Ajouter un nouvel hôte à la liste : "
        read -p "HOSTNAME : " HOSTNAME
	checkHostname

	if [ $existHostname -eq 1 ]
	then
		echo "Le nom d'hote existe deja"
		exit
	fi

	read -p "IP : " IP
	checkIPFormat
	checkDoubleIP

	if [ $existIP -eq 1 ]
        then
                echo "L'adresse IP existe déjà"
                exit
        fi

        read -p "USER : " USER
        read -p "AUTH : " AUTH
        read -p "OS : " OS
        read -p "ROLE : " ROLE
        read -p "ENVIRONNEMENT : " ENVIRONNEMENT
        read -p "VLAN : " VLAN
	add
fi


#Si le param est modifier alors on appel la fonction modifier
if [ $1 = "edit" ]
then
	read -p "Quel hôte modifier ? " HOSTNAME
        checkHostname

        if [ $exist -eq 0 ]
        then
                echo "L'hote n'existe pas !"
                exit
        fi
	edit
fi


#Si le param est supprimer alors on appel la fonction supprimer
if [ $1 = "delete" ]
then
	echo "Supprimer un hote :"
	read -p "HOSTNAME : " HOSTNAME
	delete
	checkHostname
	if [ $exist -eq 0 ]
        then
                echo "L'hote n'existe pas"
                exit
        fi
fi
