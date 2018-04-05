#!/bin/bash
#helloworld.sh
#Description : Script affichant ok si la chaine commence par bonjour, sinon il affiche ko

maVar="bonjour le monde"

if [[ ${maVar} =~ ^bonjour ]]
then 
	echo "ok"
else
	echo "nok"
fi

