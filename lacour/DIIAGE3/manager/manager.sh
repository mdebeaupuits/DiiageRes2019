#!/bin/bash
#manager
#This script allows to add, modify, delete lines in a flat file
#Variables
fic="data.txt"
regex="^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5])))$"

#Function that allows to adds a new line in the file
function add() {
	#echo $(awk -F, '{print $1}' ${fic})
	#if [[ $(awk -F, '{print $1}' $1) -eq $(awk -F, '{print $1}' ${fic}) ]]

#Testing if the Ip is already taken
if [[ $(awk "/${IP}/" ${fic}) ]]
then
	echo "this IP ${IP} is already taken !"
	return 1
else
	if [[ $( "${IP}" =~ "${regex}" ) ]]
	then
		echo "this isn't a proper IP";
		return 1
	else

		#Testing if the hostname is already taken
		if [[ $(awk "/${Hostname}/" ${fic}) ]]
		then
			echo "the host ${Hostname} is already present !"
			return 1
		else
			#Sending data in the file
			echo "IP=${IP}:Hostname=${Hostname}:User=${User}:Auth=${Auth}:Os=${Os}:Role=${Role}:VLAN=${VLAN}:Environnement=${Environnment}" >> ${fic}
                	return 0
		fi
	fi
fi
}
#Function that allows to modify an existing line in the file
function mod() {
	if [[ $(awk "/${Hostname}/" ${fic}) ]]
	then
                sed -i "s/^${Hostname}/^$2/g" ${fic}
		return 0
	else
                echo "line" $1 "isn't in the file !"
                return 1
	fi
}

#Function that allows to delete an existing line in the file
function del() {
        if [[ $(awk "/$Hostname/" ${fic}) ]]
        then
                sed -i "/$Hostname/d" ${fic}
	        return 0

        else
                echo "Line $Hostname isn't in the file !"
                return 1
        fi
}

#Function to send the file by ssh on a remote machine
function send() {
	echo "coucou"
}

#Verify the presence of a parameter
	#Options
		echo "choose an option : a to add | m to modify | d to delete";
		read option
		case ${option} in
			a)
			echo "Enter an IP";
			read IP;
			echo "Enter a hostname";
			read Hostname
			echo "Enter a User";
			read User;
			echo "Enter an Auth";
			read Auth ;
			echo "Enter an OS";
			read Os;
			echo "Enter a Role";
			read Role;
			echo "Enter a VLAN";
			read VLAN;
			echo "Enter an Environnement";
			read Environnment;
			add;;
			m) shift; mod $1;;
			d) shift; del $1;;
			*) echo "Option invalide !"
		esac
