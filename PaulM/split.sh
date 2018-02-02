#!/bin/bash

#On crée un chaine de caracetère
test="cou;cou"
#split= echo ${test} | cut -d ";" -f1,2  

#On affiche sa variable puis on la redirige après le pipe pour spliter
#la chaine en 2 après le caractere que l'on a défini
echo ${test} | awk -F ";" '{print $1,"\n" $2}'
echo ${#test}









#echo ${split}

#sep=$1
#phrase=$2

#function Split ()
#{
# 
#  echo ${2} | awk -F "${1}" '{print $1,"\n" $2}'

#}

#Split ${sep} "${phrase}"
