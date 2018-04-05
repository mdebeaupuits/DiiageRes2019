#!/bin/bash
#Description : script qui surveille l'espace disque et qui envoie une alerte si un fs depasse lalimite

# On definit les variables pour l'alerte et pour les fs
limit=90
list="/dev/sda2 /dev/sdb1"
mail=alexis.schenck@diiage.org


for disk in $list
do
	space=$(df -h | grep $disk | awk {'print $5'} | sed 's/\%//g')
if [[ $space -ge $limit ]]
then
	echo "`hostname` : espace disque occupe a $space sur $disk" | mail -s "Espace disque sur `hostname`" $mail
else
	echo ca roule
fi
done
