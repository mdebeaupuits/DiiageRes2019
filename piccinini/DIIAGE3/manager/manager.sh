#!/bin/bash
function add()						#Add object in data.txt
{
        regex='^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}'	#Verify IP address syntax
        regex+='0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))$'

        if ! [[ $IP =~ $regex ]]; then
                echo "IP address error"
                exit
        fi
	echo "IP="$1":Hostname="$2":User="$3":Auth="$4":OS="$5":Role="$6":VLAN="$7":Environnement="$8"">>data.txt
}

function del()						#Delete object in data.txt
{
	sed -i "/$1/d" data.txt
}

echo "Enter add, del or mod" ; read choose

if [ "$choose" = "add" ]
then
	echo "type ip, hostname, user, auth, os, role, vlan, environnement"
	read ip hostname user auth os role vlan environnement
	search=$(awk /"$hostname"/ data.txt)

	if [ -z "$hostname" ]				#Test if string is empty
	then
		echo "empty anwser"
	elif [ "x$search" != "x" ]			#Test if hostame=$hostname is found in data.txt
	then
		echo "hostname exist"
	else
		add $ip $hostname $user $auth $os $role $vlan $environnement
	fi
elif [ "$choose" = "del" ]
then
	echo "type hostname to delete"
	read hostname
	del $hostname
elif [ "$choose" = "mod" ]
then
	cat data.txt
	echo "Type hostname to modify"			#Line choose with hostname
	read name
	del $name
	echo "type ip, hostname, user, auth, os, role, vlan, environnement"
	read ip hostname user auth os role vlan environnement
	search=$(awk /"$hostname"/ data.txt)
	if [ -z "$hostname2" ]				#Test if string is empty
	then
		echo "empty anwser"
	else
		add $ip $hostname $user $auth $os $role $vlan $environnement
	fi
fi

echo "contenu du fichier Data.txt : " ; cat data.txt		#Show data.txt content
