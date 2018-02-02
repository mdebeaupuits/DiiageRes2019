#!/bin/bash
str="Bonjour mon nom est : Samy "
echo "Longueur = " ${#str}

#str2=$(echo ${str} | sed s/:/\\n/g)
#str2=$(echo ${str} | awk -F":" '{print $1 $2}')
#echo ${str2}

echo ${str} | tr ":" "\n"
