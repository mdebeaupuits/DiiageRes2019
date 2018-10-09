#!bin/bash

#Script pour ajouter, supprimer ou modifier des entrées dans un fichier texte relatif à des serveurs

#Fonction pour vérifier le fichier
function checkFile()
{
	NbHost=$(awk '/HOST='$1'/{x+=1}END{print x}' $Filename)
	if [ $NbrHost > 0 ]
	then
		exist="1"
	else
		exist="0"
	fi
}

#Initialisation
function readHost()
{
	#Initialisation
	echo "Veuillez entrer le nom d'hote :"
	read Host
	checkFile $Host
	if [ $exist = "0" ]
	then
		echo "Veuillez entrer le nom du fichier de donnees :"
		read Filename
		echo "Veuillez entrer une adresse IP :"
		read Ip
		echo "Veuillez entrer un nom d utilisateur :"
		read UserName
		echo "Veuillez entrer un mot de passe :"
		read Password
		echo "Veuillez entrer un OS :"
		read Os
		echo "Veuillez entrer un role :"
		read Role
		echo "Veuillez entrer un Vlan :"
		read Vlan
		echo "Veuillez entrer un Environnement (Production, Recette ou Developpement)"
		read Env
		AddServer $Host $Ip $UserName $Password $Os $Role $Vlan $Env
	else
		echo "Il existe deja une entree pour ce serveur !"
	fi
}

# Fonction pour ajouter une entrée

function AddServer()
{
	checkVar $1
	checkVar $2
	#Ajout de l entree dans le fichier
	if [ $emptyvar = 1 ]
	then
		echo "Il manque un hostname ou une IP !!"
	else
		echo "HOST=$1:IP=$2:USER=$3:PASSWORD=$4:OS=$5:ROLE=$6:VLAN=$7:ENV=$8" >> $Filename
	fi
}

# Vérifier si les paramètres essentiels sont vides
function checkVar()
{
	if [ -z "$1" ];
	then
		emptyvar="1"
	else
		emptyvar="0"
	fi
}

# Fonction pour supprimer une entree
function DeleteServer()
{
	sed -i "/HOST=$SHostname/d" data.txt
}

# Fonction pour modifier une entree
function EditServer()
{

}

#Choix : Ajouter, Supprimer ou Modifier
if [ $1 = "add" ]
then
	readHost
fi

if [ $1 = "del" ]
then
	read SHostname
	DeleteServer
fi

if [ $1 = "edit" ]
then
	EditServer
fi

