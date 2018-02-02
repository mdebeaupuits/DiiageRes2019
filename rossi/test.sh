#!/bin/bash

#Creation de la var avec la phrase
maPhrase="bonjour je suis : rossi"

#Decoupage de la var avec awk au delimiter : et affigage des 2 parties avec saut de ligne
echo ${maPhrase} | awk -F ":" '{print $1,"\n" $2}'
