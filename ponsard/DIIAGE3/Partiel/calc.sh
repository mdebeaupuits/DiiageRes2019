#!/bin/bash
#PAUL PONSARD
#SCRIPT REALISANT DES OPERATIONS MATHEMATIQUES SIMPLES



#Afficher le resultat du calcul
function calcul(){

    echo "$value =" $(($value))


}

#Verifier si au moins un calcul est entré en parametre
if [ $# -eq 0 ]
then
    echo "[ERROR] Please give me something to do !"
    echo "[USAGE] calc.sh 3+2"
else
#Tant qu il y a au moins un parametre, utiliser ce dernier pour dans la fonction calcul
    while [ $# -gt 0 ]
    do
        value=$1
        calcul
        shift
    done
fi

