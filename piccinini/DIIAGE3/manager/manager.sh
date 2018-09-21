#!/bin/bash

function add()						#Add object in data.txt
{
	echo "hostname="$1":ip="$2":user="$3":mdp="$4":os="$5":role="$6>>data.txt
	echo "Added/Modified !"
}

function del()						#Delete object in data.txt
{
	sed -i "/$1/d" data.txt
}

echo "Enter add, del or mod" ; read choose

if [ "$choose" = "add" ]
then
	echo "type hostname, ip, user, mdp, os, role"
	read hostname ip user mdp os role
	search=$(awk /"$hostname"/ data.txt)

	if [ -z "$hostname" ]				#Test if string is empty
	then
		echo "empty anwser"
	elif [ "x$search" != "x" ]			#Test if hostame=$hostname is found in data.txt
	then
		echo "hostname exist"
	else
		add $hostname $ip $user $mdp $os $role
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
	echo "Type new hostname, ip, user, mdp, os, role"
	read hostname2 ip2 user2 mdp2 os2 role2
	search=$(awk /"$hostname"/ data.txt)
	if [ -z "$hostname2" ]				#Test if string is empty
	then
		echo "empty anwser"
	else
		add $hostname2 $ip2 $user2 $mdp2 $os2 $role2
	fi
fi

echo "contenu du fichier fic : " ; cat data.txt		#Show data.txt content
