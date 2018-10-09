#!/bin/bash

#function ajout d'une entrée
fic="data.txt"
function add () {
if [[ $(awk '/'$host'/' ${fic}) ]]
        then
                echo "L'hôte : [" $host "] est déjà présent !";
                return 1
        else
                echo  "Hostname="$host",""Ip="$ip",""User="$user"," >> ${fic}
		echo "L'hôte :  [" $host "] a été ajouté";
		return 0
        fi
}


#function supprimer

function del () {
	sed -i '/'$1'/d' ${fic}
	return 0
	echo "contenu du fichier après suppression : ";
	cat ${fic};
}


#function  modifier

function mod () {
	cat ${fic};
	return 0
}

#function d'envoie
function send () {
	cat ${fic};
	return 0
}
# lecture de la chaîne entrée par l'utilisateur pour ajouter un hôte au fichier data.txt
	echo "Veuillez entrer un nom d'hôte:";
	read host
	echo "Veuillez lui indiquer une IP";
	read ip
	echo "Veuillez indiquer un nom d'utilisateur";
	read user
# menu des fonctions
echo "Choisir la function : add | del | mod | send";
        read func
        case $func in
                add) add $host $ip;;
                del) del $1;;
                mod) mod $1;;
                send) send $1;;
                *) echo "Erreur de saisie !" ;
        esac

