phrase=torchon:serviette
delimiteur=":"
function Fsplit()
{
	#compter le nombre de caracthrers dans la chaine
	echo ${#1}
	#Split la chaine au niveau des :
	#echo ${1%$2*}
	echo $1 |cut -f1 -d"$2"
	echo $1 |cut -f2 -d"$2"
}
Fsplit $phrase $delimiteur


