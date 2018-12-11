
#!/bin/bash
#Auteur : Nathan Millerand
#process.sh : Savoir quel process est le plus gourmand en CPU


function Process() {
#Cette commande permet d'afficher les deux premieres lignes du resultat de :
# La commande ps, avec affichage de de l'uid, , de la commande et du cpu
# En sortant par le cpu le plus elevé

if [ $# -eq 1 ]
  then
     if [ "$1" -ge 1 ]
       then
         $1 = `expr $1 + 1`
         echo $1
         ps -Ao pid,pcpu,comm --sort=-pcpu | head -n $1
       else
         echo "Il faut au moins que le parametre sois egal a 1 pour avoir un resultat"
     fi
  else
    ps -Ao pid,pcpu,comm --sort=-pcpu | head -n 2
fi


}
Process
