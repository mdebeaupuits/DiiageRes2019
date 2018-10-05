#!/bin/bash
#this script allows you to retrieve the most demanding process 
cpu=$(df -h | awk '{print $5}' | cut -d'%' -f1 | grep -v "Utilisé")

for res in ${cpu}; do

echo "le pourcentage est de" ${res} %


if [[ ${res} -ge 6 ]]

then
	echo "overload"
else
	echo "stable"
fi
done
