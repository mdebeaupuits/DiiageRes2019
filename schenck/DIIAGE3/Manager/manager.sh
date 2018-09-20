#!/bin/bash
#Fonction pour ajouter une entree dans le fichier plat
function ajout_entree() {
	local Hostname=$1
	local Ip=$2
	local User=$3
	local Pw=$4
	local Os=$5
	local Role=$6
	local Vlan=$7
	local Env=$8
	confFile=$9
	#uniqHost=$(awk '/'$Hostname'/{x+1}END{print x}' $confFile
	echo $Hostname:$Ip:$User:$Pw:$Os:$Role:$Vlan:$Env  >> $confFile
	return $?
}
ajout_entree docker 10.5.10.87 root root GNU/Linux docker aucun dev data.txt

function suppr_entree() {
	local Hostname=$1
	sed -i '/^'$Hostname'/d' $confFile
}
suppr_entree docker data.txt

function modif_entree() {
	suppr_entree docker data.txt
	ajout_entree docker 10.5.10.87 root root GNU/Linux docker 5 prod data.txt

}
modif_entree
