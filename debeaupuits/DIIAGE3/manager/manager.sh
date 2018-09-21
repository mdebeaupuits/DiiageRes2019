#!/bin/bash
#	if [[ $# = 0 ]] then echo "Usage : $0 source_path dest_path dest_comp"
#	echo "Dépendances : OpenSSH" exit 0 fi
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

# Test des fonctions 
#add_server testserver320 192.168.0.1 admin pass dhcp Linux 21 production
#remove_server testserver2 
#update_server testserver32 10.5.0.51 admin pass dhcp Linux 21 production testserver320
