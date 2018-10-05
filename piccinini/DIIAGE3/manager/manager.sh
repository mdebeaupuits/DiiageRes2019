#!/bin/bash
file=data.txt
function add()							#Function add object in data.txt and verify IP syntax
{
        regex='^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}'	#Verify IP address syntax
        regex+='0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))$'
        if ! [[ $1 =~ $regex ]]; then
                echo "IP address error"
                exit
        fi
	echo "IP="$1":Hostname="$2":User="$3":Auth="$4":OS="$5":Role="$6":VLAN="$7":Environnement="$8"">>data.txt
}

function del()							#Function Delete object in data.txt
{
	sed -i "/$1/d" $file
}

function checkHostname()					#Function test if string is empty or existant
{
	search=$(awk /"$1"/ $file)
	if [ -z "$1" ]; then
		echo "Hostname empty anwser"
		exit
	elif [ "x$search" != "x" ]; then			#Test if hostame=$hostname is found in data.txt
		echo "hostname exist"
		exit
	fi
}

function readhost()						#Function read objects properties
{
	echo "type ip, hostname, user, auth, os, role, vlan, environnement"
	read ip hostname user auth os role vlan environnement
}

echo "Enter add, del or mod" ; read choose			#Interraction view menu

if [ "$choose" = "add" ]; then					#Add choice, verify and add function
	readhost
	checkHostname $hostname
	add $ip $hostname $user $auth $os $role $vlan $environnement
elif [ "$choose" = "del" ]; then				#Delette choice, show content and remove
	cat $file
	echo "type hostname"
	read hostname
	del $hostname
elif [ "$choose" = "mod" ]; then				#Modify choice, delete,verify and add object
	cat $file
	echo "type hostname"
	read name
	del $name
	readhost
	checkHostname $hostname
	add $ip $hostname $user $auth $os $role $vlan $environnement
fi

echo "contenu du fichier Data.txt : " ; cat $file		#Show data.txt content
