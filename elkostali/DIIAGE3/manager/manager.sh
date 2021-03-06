#!/bin/bash
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
function checkDoubleIP(){
        checkIP=$(awk "/IP=$IP/ {print}" $config)
        if [ "x$checkIP" != "x" ]
        then
		echo "Cette adresse IP est déja renseignée"
		exit
        fi

}	
#Fonction verifiant le format de l'adresse IP puis test la connexion SSH	
function checkFormatIP(){
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

#fonction permettant d'ajouter un hote au fichier
function add(){
	local IP=$1 HOSTNAME=$2 COMPTE=$3 AUTH=$4 OS=$5 ROLE=$6 VLAN=$7 ENVIRONNEMENT=$8
	echo "IP=$IP:Hostname=$HOSTNAME:Compte=$COMPTE:Auth=$AUTH:OS=$OS:Role=$ROLE:VLAN=$VLAN:Environnement=$ENVIRONNEMENT" >> $config 
        if [[ $? -ne 0 ]]
        then
                echo "Echec lors de l'ajout"
                return $? 
        fi

}

#Fonction permettant de supprimer un hote du fichier
function delete(){
	sed -i"$config" "/Hostname=$HOSTNAME/d" $config
        if [[ $? -ne 0 ]]
        then
                echo "Echec lors de la suppression"
                return $?
        fi

}

function edit () {
	LIGNE=$(grep $HOSTNAME $config)
	echo "Copier coller cette ligne puis modifier la : "
	echo "$LIGNE"
	read NEWVALUE
        sed -i "s/$LIGNE/$NEWVALUE/g" $config
        #Retour erreur
        if [[ $? -ne 0 ]]
        then
                echo "Echec lors de la modification"
                return $?
        fi
}


#Declaration du fichier dans lequel on va stocker les postes
config="data.txt"
#Affichage de l'utilisation de la commande dans le cas où il manque un argument
if [ $# -lt 1 ]
then
	echo "$0 [add|delete|edit] (-h hostname -i\"IP=@IP:Compte=root...\" "
	exit 1
fi
if [ $1 = "add" ]
then
	#Verification de l'existence du fichier de config
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
	checkDoubleIP
	checkFormatIP
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
	read -p "Quel hôte supprimer ? " HOSTNAME
        checkExist
        if [ $exist -eq 0 ]
        then
                echo "L'hote n'existe pas !"
                exit
        fi
	delete
fi

if [ $1 = "edit" ]
then
	read -p "Quel hôte modifier ? " HOSTNAME
        checkExist

        if [ $exist -eq 0 ]
        then
                echo "L'hote n'existe pas !"
                exit
        fi
        edit
fi
