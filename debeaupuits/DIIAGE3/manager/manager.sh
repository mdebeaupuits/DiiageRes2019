#!/bin/bash
#set -xv
send_configfile () {
	local source_path=$1
	local dest_path=$2
	local dest_comp=$3
	echo "Envoi du fichier : "
	scp $source_path $dest_comp:$dest_path
	return $?
}

add_server () { 
	local server_list=$(pwd)"/data.txt"
	declare -A new_server=(["server_name"]=$1 
	["ip_address"]=$2 
	["username"]=$3 
	["password"]=$4 
	["role"]=$5 
	["OS"]=$6 
	["VLAN"]=$7 
	["environnement"]=$8) 
	if [[ -e $server_list ]] 
	then 
		grep  -w ${new_server["server_name"]} $server_list >> /dev/null 
		if [[ $? -ne 0 ]]
		then 
			echo ${new_server["server_name"]}:${new_server["ip_address"]}:${new_server["username"]}:${new_server["password"]}:${new_server["role"]}:${new_server["os"]}:${new_server["VLAN"]}:${new_server["environnement"]} >> $server_list 
		else 
			echo "Erreur : L'entrée éxiste déja et n'a pas été ajoutée" 
		fi
	else
		echo ${new_server["server_name"]}:${new_server["ip_address"]}:${new_server["username"]}:${new_server["password"]}:${new_server["role"]}:${new_server["os"]}:${new_server["VLAN"]}:${new_server["environnement"]} >> $server_list   
	fi 
	return $?  
}

remove_server () { 
	local server_list=$(pwd)"/data.txt"
	local server_name=$1 
	sed -i '/^'$server_name'/d' $server_list 
}

update_server () { 
	local old_servername=$9 
	declare -A new_server=(["server_name"]=$1 
	["ip_address"]=$2 
	["username"]=$3 
	["password"]=$4 
	["role"]=$5 
	["OS"]=$6 
	["VLAN"]=$7 
	["environnement"]=$8) 
	remove_server $old_servername
	add_server ${new_server["server_name"]} ${new_server["ip_address"]} ${new_server["username"]} ${new_server["password"]} ${new_server["role"]} ${new_server["OS"]} ${new_server["VLAN"]} ${new_server["environnement"]} 
}

aide () {
	echo "Usage : $0 -h hostname -i IP [-uprove] -A|U|D "
	echo "Dépendances : OpenSSH, telnet" 
	echo "-h : Nom de l'hôte"
	echo "-i : Adresse IP"
	echo "-u : Nom d'utilisateur"
	echo "-p : Mot de passe"
	echo "-r : Rôle de la machine"
	echo "-v : VLAN"
	echo "-e : Environnement" 
	echo "-A : Ajouter un hôte"
	echo "-U : Mettre à jour un hôte"
	echo "-D : Supprimer un hôte"
	return $?
}

check_mandatory () {
ip_regex="^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"	
if [[ -z $1 && -z $2 ]]
then
	return 1
else
	if [[ $2 =~ $ip_regex ]]
	then     	
		return 0
	else
	  return 1 
  fi
fi
}
# function test  
#add_server testserver320 192.168.0.1 admin pass dhcp Linux 21 production
#remove_server testserver2 
#update_server testserver32 10.5.0.51 admin pass dhcp Linux 21 production testserver320

############################
# start of script
############################

if [[ $# = 0 ]] 
then 
	aide
	exit 0 
fi
while getopts "h:i:u:p:r:o:v:eAUD" opt
do
	case "${opt}" in
		h)
			host=${OPTARG}
			;;
		i)
			ip=${OPTARG}
			;;
		u)
			user=${OPTARG}
			;;
		p)
			password=${OPTARG}
			;;
		r)
			role=${OPTARG}
			;;
		o)
			os=${OPTARG}
			;;
		v)
			vlan=${OPTARG}
			;;
		e)
			environnement=${OPTARG}
			;;
		A)	check_mandatory $host $ip 
			if [[ $? -eq 0 ]]
			then
				add_server $host $ip $user $password $role $os $vlan $environnement
			else 
				echo "Erreur : Vérifiez que le nom d'hôte et l'adresse IP ont bien été renseignés et sont valides" 
			fi 
			;;
		U)
#			echo -n "Saisir le nom du serveur à mettre à jour : " 
#			read old_server
#			check_mandatory $host $ip
#			if [[ $? -eq 0 ]]
#			then
#				update_server $host $ip $user $password $role $os $vlan $environnement $old_server
#			else 
#				echo "Erreur : Vérifiez que le nom d'hôte et l'adresse IP ont bien été renseignés et sont valides" 
#			fi 
			;;
		D)
			check_mandatory $host $ip 
			if [[ $? -eq 0 ]]
			then 
			remove_server $host
			else
				echo "Erreur : Vérifiez que le nom d'hôte et l'adresse IP ont bien été renseignés et sont valides" 
			fi
			;;
		*)   
		       aide	
			;;
	esac
done
