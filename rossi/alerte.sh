#!/bin/bash

pourcent=$(df -h | awk '{print $5}' | cut -d"%" -f1 | grep -v "Utilisé")

for ligne in ${pourcent}
do
	echo "Le pourcentage est de ${ligne}"


	if [[ ${ligne} -ge 5 ]]
	then
		echo "Attention % eleve"
	else
		echo "OK"
	fi
done
