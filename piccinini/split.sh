#!/bin/bash

#Script qui compte le nombre de caracteres et split apres un caractere special

#compter le nombre de lettres
test="te;st";
echo ${#test};

#Decouper apres caractere special
echo ${test} | awk -F ";" '{print $1,"\n" $2}'

#Decouper apres caractere special methode 2
#echo ${test} | cut -d ";" -f1
#echo ${test} | cut -d ";" -f2
