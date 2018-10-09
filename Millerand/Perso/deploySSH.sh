#!/bin/bash
##Script deploiement automatique a partir d'une liste de fichiers
set -vx

function PingHosts() {

while read line; do
ping -c 4 $line
echo "Ok host $line"
done<listIP.txt
}

function SSHHosts() {

while read i; do
scp testSSH root@$i:/root/test
export http_proxy=http://10.5.0.252:8080
a=$(cat /etc/vsftpd.conf > /dev/null ; echo $?)
        if [ $a -eq "1" ]
                then
                        apt-get install vsftpd --assume-yes
                else
                        echo "Le service vsftpd est déja installé"
        fi
        done <listIP.txt
}

SSHHosts
#PingHosts
