#On déclare le fichier dans lequel on ajoutera,modif,suppr les PC
fichier_conf=/root/Scripting/DiiageRes2019/data.txt

function verif_Doublon_Hostname()
{
	verify=$(awk /"HOSTNAME=$HOSTNAME/ {print}" $fichier_conf)
        if [ "x$verify" = "x" ]
        then
                exist=0
	else
		exist=1
        fi
}


#Fonction permettant d'ajouter un hote a la liste
function add()
{
	echo "IP=$IP : HOSTNAME=$HOSTNAME : USER=$USER : PASSWORD=$PASSWORD: OS=$OS : ROLE=$ROLE : ENVIRONNEMENT=$ENVIRONNEMENT : VLAN=$VLAN" >>$fichier_conf
}


#Fonction permettant de supprimer un hote de la liste
function delete()
{
	sed -i "/$HOSTNAME/d" $fichier_conf
}


#Tester le nombre de param, si pas 1 param alors on affiche l'aide de la cmd
if [ $# -ne 1 ]
then
	echo "Utilisation : NomScript + add | edit | delete "
fi


#Si le param est ajouter alors on appel la fonction ajouter
if [ $1 = "add" ]
then
	echo "Ajouter un nouvel hôte à la liste : "
        read -p "HOSTNAME : " HOSTNAME
	verif_Doublon_Hostname

	if [ $exist -eq 1 ]
	then
		echo "Le nom d'hote existe deja"
		exit
	fi

	read -p "IP : " IP
        read -p "USER : " USER
        read -p "PASSWORD : " PASSWORD
        read -p "OS : " OS
        read -p "ROLE : " ROLE
        read -p "ENVIRONNEMENT : " ENVIRONNEMENT
        read -p "VLAN : " VLAN
	add
fi


#Si le param est modifier alors on appel la fonction modifier
if [ $1 = "edit" ]
then
        edit
fi


#Si le param est supprimer alors on appel la fonction supprimer
if [ $1 = "delete" ]
then
	echo "Supprimer un hote :"
	read -p "HOSTNAME : " HOSTNAME
	delete
fi
