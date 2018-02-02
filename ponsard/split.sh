#!/bin/bash

#Declarer une variable
a='test:variable'

#Afficher sa taille
echo ${#a}

#Couper la variable en deux a partir d'un delimiteur 
echo $a | cut -f1 -d:
echo $a | cut -f2 -d:


