	#!/bin/bash

	#Creation des variables pour les param
delimiter=$1
phrase=$2


	#Creation de la fonction

function separer()
{
	#Creation de la var avec la phrase
maPhrase=${2}

echo ${maPhrase} | awk -F "${1}" '{print $1,"\n" $_}'

}

	#Appel de la fonction
separer ${delimiter} "${phrase}"
