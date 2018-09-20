#!/bin/bash
#tableau
#exemple de tableau de hachage

declare -A tableau
tableau=(["IP"]="10.5.0.157" 
	["User"]="root"
	["Password"]="root"
	["OS"]="GNU/Linux Debian Stretch 9.3"
	);

echo "Nb éléments :" ${#tableau[*]};
echo "Index :" ${!tableau[@]};

declare -A tabtab
tabtab=(["Hote1"]=$(echo ${tableau[*]})
	);

echo "Index du tabtab :" ${!tabtab[@]};

#for elem in ${!tabtab[*]}; do
#	echo "Index \"${elem}\" : Valeur : "${tabtab[${elem}]};
#	for elemelem in ${!elem[*]}; do
#		echo "Index : \"${elemelem}\" : Valeur : "${elem[${elemelem}]};
#	done
#done

echo ${tabtab["Hote1"]};
