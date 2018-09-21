#!/bin/bash
#Fonction pour ajouter une entree dans le fichier plat
confFile='data.txt'
function ajout_entree() {
	local Hostname=$1
	local Ip=$2
	local User=$3
	local Pw=$4
	local Os=$5
	local Role=$6
	local Vlan=$7
	local Env=$8
	echo $Hostname:$Ip:$User:$Pw:$Os:$Role:$Vlan:$Env  >> $confFile
	return $?
}
#ajout_entree docker 10.5.10.87 root root GNU/Linux docker aucun dev data.txt

function suppr_entree() {
	local Hostname=$1
	sed -i '/^'$Hostname'/d' $confFile
}
#suppr_entree docker data.txt

function modif_entree() {
	suppr_entree docker $confFile
	ajout_entree docker 10.5.10.87 root root GNU/Linux docker 5 prod $confFile

}
#modif_entree

function verif_hostname() {
	local Hostname=$1
	if [ -z $Hostname ]
	then
		echo "veuillez saisir un hostname!"
		exit
	fi
	verifHostname=$(awk '/'Hostname'/{x+1}END{print x}' $confFile)
	if [ "x$verifHostname" != "x" ]
	then
		exist=0
	else
		exist=1
	fi

}

function verif_ip() {
	if [ $# = 1 ]
	then
		printf $1 | grep -Eq '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-4]|2[0-4][0-9]|[01]?[1-9][0-9]?)$'
		return $?
  	else
	   	return 2
	fi
   }


echo "voulez-vous ajouter(-a) ,modifier(-m), supprimer(-d)?"
read choix
case $choix in 
	-a)
		echo "veuillez saisir un hostname"
		read hostname
		verif_hostname
		echo "veuillez saisir un IP"
		read ip
		verif_ip $ip && echo "ok"
		echo "veuillez saisir un user"
		read user
		echo "veuillez saisir un pw"
		read pw
		echo "veuillez saisir un os"
		read os
		echo "veuillez saisir un role"
		read role
		echo "veuillez saisir un vlan"
		read vlan
		echo "veuillez saisir un env"
		read env

		ajout_entree $hostname:$ip:$user:$pw:$os:$role:$vlan:$env
		;;
	-m)		
		modif_entree
		;;
	-d)
		echo "veuillez saisir un hostname à supprimer"
		read hostname
		suppr_entree $hostname $confFile
		;;
esac
