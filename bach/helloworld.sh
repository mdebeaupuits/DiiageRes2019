#!/bin/bash
#helloworld.sh
#Description : Script affichant ok si la chaine commence par bonjour, sinon il affiche ko

maVar="bonjour le monde"

echo ${maVar} |grep -E ^bonjour > /dev/null
if [[ $? == 0 ]]
then 
	echo "ok"
else
	echo "nok"
fi

