#!/bin/bash 
# we initiate a variable containing a file
confFile=data.txt
#if the file doesn't we create it else the file exist
if [ ! -f $confFile ]
then
    > data.txt
else
echo "file exist"
fi
# We create a function we send each variable which returns all values in the file 
function add()
{
    
    echo  "IP=$IP : hostname=$hostname : user=$user  : Auth=$auth : os=$os : role=$role : vlan=$vlan : environement:$environement " >> $confFile

}

# We create a function which delete the line that hostname it type by the user
function del()
{
#We search in the file the value "hostname" type by the user and we delete it    
    sed -i "/$hostname/d" $confFile


}

# We create a function who replace the older value by the new one
function mod()
{
    sed -i "s/$ip/$ip2/g" $confFile
    sed -i "s/$host/$host2/g" $confFile
    sed -i "s/$user/$user2/g" $confFile
    sed -i "s/$auth/$auth2/g" $confFile
    sed -i "s/$os/$os2/g" $confFile
    sed -i "s/$role/$role2/g" $confFile
    sed -i "s/$vlan/$vlan2/g" $confFile
    sed -i "s/$environement/$environement2/g" $confFile


}

#We create a function who verify an IP address
function checkip()
{


    re='^(0*(1?[0-9]{1,2}|2([0-4][0-9]|5[0-5]))\.){3}'
    re+='0*(1?[0-9]{1,2}|2([‌​0-4][0-9]|5[0-5]))$'
     if [[ $IP =~ $re ]]
    then
        echo "sucess"
    else
        echo "ip already used"
        exit
    fi
    
}

# We create a function who verify the reachable host 
function hostexist()
{
# We initate a ssh connection of 5 seconds and we return the result of command in dev/null (trash) redirect STDERR to where STDOUT is redirected
# if the return code is equal to 0 the host is reachable
    ssh -o ConnectTimeout=5 $user@$IP echo "" > /dev/null 2>&1
    if [ $? -eq 0 ] 
    then 
    echo "host ok" 
    else echo " host not ok "
    exit
    fi
}

# if after the script call there is no function indicated in the first parameter we go out 
if [ $# -eq 0 ]
then
    echo "add, del, mod"
    exit
    
fi
# if after the script call there is function add indicated we start the function "add"
if [ $1 = "add" ]
then
# We read the result of the command type by the user and we send the result in variable $IP
    read -p "IP : " IP 
# We call the function checkip
    checkip
# if the value type by the user is exist we go out 
# we search the string type by the user in the configfile confFile
    ipexist=$(awk /"IP=$IP/ {print}" $confFile)
    if [ "x$ipexist" != "x" ]
    then
        echo "$IP existe deja"
        exit 
    fi
# if the value type by the user is exist we go out 
# we search the string type by the user in the configfile confFile
    read -p "hostname : " hostname
    verify=$(awk /"$hostname"/ $confFile)
    if [ "x$verify" != "x" ]
    then
        echo "$hostname existe deja"
        exit 
    fi
# We read the result of the command type by the user and we send the result in variable
    read -p "user : " user
#We call the function hostexist
    hostexist
    read -p "Auth : " auth
    read -p "os : " os
    read -p "role : " role
    read -p "vlan : " vlan
    read -p "environement : " environement
    add
fi
# if after the script call there is function add indicated we start the function "del"
if [ $1 = "del" ]
then
    echo -e "which host to delete"
    read -p "hostname : " hostname
    del
fi
# if after the script call there is function add indicated we start the function "mod"
if [ $1 = "mod" ]
then
# We read the result of the command type by the user and we send the result in variable
    read -p "IP a changer : " ip
    read -p "nouvelle IP : " ip2

    read -p "hote a changer : " host
    read -p "nom nouvelle hote : " host2

    read -p "User to change : " user
    read -p "New user : " user2

    read -p "Auth to change : " auth
    read -p "New Auth   : " auth2

    read -p "Os to change : " os
    read -p "New os : " os2

    read -p "Role to change : " role
    read -p "New role : " role2

    read -p "Vlan to change : " vlan
    read -p "New vlan  : " vlan2

    read -p "Environement to change : " environement
    read -p "New Environement : " environement2
#We call the function mod
    mod
fi


