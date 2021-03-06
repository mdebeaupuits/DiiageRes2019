#!/bin/bash
#manager
#test
#Variables
fic="data.txt"
reg="^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5])))$"

#add a line in the file
function add () {
	#Checking if host exists in file
	if [[ $(awk "/${host}/" ${fic}) ]]
	then
                echo "Host $host is already present in the file !";
                return $?
	else
		#Checking is IP exists in file
		if [[ $(awk "/$ip/" ${fic}) ]]
		then
			echo "IP $ip is already assigned to a host in this file !"
			#Send an error code generated by bash
			return $?
		else
			if [[ "${ip}" =~ "${reg}" ]]
			then
				echo "Use a valid IP address !"
			else
				#Serialize the line before writing the file
               			echo "IP=${ip}:Hostname=${host}:User=${user}:Auth=${auth}:OS=${os}:Role=${role}:VLAN=${vlan}:Environement=${environement}" >> ${fic}
				echo "Host $host has been added to the file";
				return $?
			fi
		fi
	fi
}

#delete a line in the file
function del () {
	if [[ $(awk "/${host}/" ${fic}) ]]
	then
		echo "Host is not existing in $fic !"
		return $?
	else
		sed -i "/$1/d" ${fic}
		return $?
	fi
}


#modify a line in the file
function mod () {
        if [[ $(awk "/${host}/" ${fic}) ]]
        then
                echo "Host is not existing in $fic !"
                return $?
        else
                sed -i "s/${host}/${value}/g" ${fic}
                return $?
        fi
}

#send the file on an other computer using ssh
function send () {
	cat ${fic};
	return $?
}

#main menu
echo "Choose a funtion add | del | mod | send";
read func
case $func in
	add)	echo "IP ?";
        	read ip;

		echo "Hostname ?";
		read host;

		echo "User ?";
		read user;

		echo "Auth method ?";
		read auth;

		echo "OS ?";
		read os;

		echo "Role ?";
		read role;

		echo "Vlan ?";
        	read vlan;

		echo "Environement ?";
		read environement;

		add;;

        del) 	echo "Which host you want to delete ?":
		read host;

		del;;

        mod) 	echo "Which host you want to modify ?";
		read host;

		echo "Enter a new value :"
		read value;

		mod;;

        send) send $1;;

        *) echo "Unrecognized function !";
esac
