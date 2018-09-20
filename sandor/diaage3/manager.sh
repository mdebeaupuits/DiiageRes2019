#!/bin/bash

#function ajout d'une entrée
function add () {
if [[ $(grep $1 fic) ]];
then
	echo $1 "est déja dans fic";
else
	echo $1>>fic;
	cat fic;
fi
}


#function supprimer

function del () {
sed -i '/'$1'/d' fic;
echo "contenu du fichier après suppression :";
cat fic;
}


#function  modifier

function mod () {
	cat fic;
}

echo "Choisir la function : add | del | mod";
        read func
        case $func in
                add) add $1;;
                del) del $1;;
                mod) mod $1;;
                *) echo "Erreur de saisie !" ;
        esac


