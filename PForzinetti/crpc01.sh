var=torchon:serviette
#compter le nombre de caracthrers dans la chaine
echo ${#var}
#Split la chaine au niveau des :
echo "'${var%:*}'"
