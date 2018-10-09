#!/bin/bash
#Administration
#Permet ladministration des machines du parc
basemachine=data.txt
user='root'
auth='ssh'
os='debian'
role='web'
vlan='1'
envi='production'

echo "what do you want to do? (ADD a host(1), MODIFY a host(2)or delete a host  (3)) ?"
read choice

function verif_ip () {
	if [[ "$ip" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
		awk "BEGIN  {i=1} /${ip}/ {i=0} END {exit i}" ${basemachine};
		if [[ $? -eq 0 ]]
		then
			echo "The IP address already exist"
			return 1
		fi
	else
		echo "fail, enter a valid IP ADDRESS"
		return 1
	fi
}

function ssh_timeout () {
	ssh -o ConnectTimeout=10 ${user}@${ip}
	if [[ $? -gt 1 ]]; 
	then
		echo "Fail, an error occured because a wrong IP address or a wrong port was specified"
		return 1
	fi
}

function add () {
	awk "BEGIN  {i=1} /${ADD}/ {i=0} END {exit i}" ${basemachine};
	if [[ $? -eq 0 ]]
	then
		echo "The machine is already in the base"
		return 1
	fi

	echo "${ADD}" >> ${basemachine}

	#Retour erreur
	if [[ $? -eq 0 ]]
	then
		echo "host added"
		return 0
	else
		echo "Unspecified error"
		return 1
	fi
}

function modify () {
	modify=$(grep ${host} ${basemachine})
	sed -i "s/${modify}/${newvaluech}/g" ${basemachine}

	#Retour erreur
	if [[ $? -eq 0 ]]
	then
		echo "Host modified"
		return 0
	else
		echo "Unspecified error"
		return 1
	fi
}

function check_hostname () {
	awk "BEGIN  {i=1} /${host}/ {i=0} END {exit i}" ${basemachine};
	if [[ $? -eq 0 ]]
	then
		echo "the hostname already exists"
		return 1
	else
		return 0
	fi
}

function delete () {
	sed -i "/${host}/d" ${basemachine}

	#Retour erreur
	if [[ $? -eq 0 ]]
	then
		echo "Host deleted"
		return 0
	else
		echo "Unspecified error"
		return 1
	fi
}
if [[ $# -eq 0 ]]
then
	case $choice in
		1)
			echo "Enter the IP address :"
			read ip
			verif_ip
			if [[ $? -eq 1 ]]
			then
				exit 1
			fi

			echo "Enter the hostname : "
			read host
			check_hostname
			if [[ $? -eq 1 ]]
			then
				exit 1
			fi

			echo "Enter the account :"
			read user

			echo "give the authentification mode"
			echo "Check in progress..."
			ssh_timeout
			if [[ $? -eq 1 ]]
			then
				exit 1
			fi
			echo "Give the OS"
			read os

			echo "Give the role of the machine"
			read role

			echo "Give the vlan"
			read vlan

			echo "Host environnment (prod, recipe, development) ?"
			read envi

			ADD="IP=$ip:Hostname=$host:User=$user:Auth=$auth:OS=$os:Role=$role:Vlan=$vlan:Environnement=$envi"
			add
			;;
		2)
			echo "which host do you want to modify ?"
			read host
			grep ${host} ${basemachine}

			echo "Copy the line above and change it"
			read newvaluech

			modify
			;;

		3)
			echo "give the hostname :"
			read host

			delete
			;;
		*)
			echo "Erreur de choix"
	esac
