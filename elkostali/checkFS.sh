#!/bin/bash

fsPlein=$(df -h | grep -E "8.%|9.%|10.%" | cut -d" " -f1)
if [[ -z $fsPlein ]]
then
	echo "Aucun FS plein"
else
	echo -e "Les FS a plus de 80% sont :\n$fsPlein"
fi

