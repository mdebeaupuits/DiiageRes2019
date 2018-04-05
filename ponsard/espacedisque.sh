#!/bin/bash

#espace disque

#Description : Script qui detecte quel filesystem est plein au delà d'un
#certain seuil. Doit par exemple afficher une message attention
#le filesystem x est plein au dela de 80%

espace=$(df -h | grep -E "8.%|9.%|10.%" | cut -d " " -f 1)

if [[ -z ${espace} ]]
then
	echo "Aucun filesystem ne dépasse 80% d'espace disque utilisé"
else
	echo "Attention ! Filesystem plein au delà de 80% : " $'\n' ${espace}
fi


