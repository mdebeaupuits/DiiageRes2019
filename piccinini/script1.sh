#!/bin/bash

test="test"

#Compter le nb de caracteres
nbcaract=$(echo ${#test});
moit=$(($nbcaract/2));

#split
#tab= echo ${test} | cut -f$moit

echo $test | cut -c $moit;




#for part in $tab
#do
#	echo $part
#done
