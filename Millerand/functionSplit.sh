function splitFunction() {
	echo ${#1}
	echo ${1} |cut -f1 -d"${2}"
	echo ${1} |cut -f2 -d"${2}"
}

#Appel v1.0
splitFunction "Partie 1 : Partie 2" ":"

#Appel v1.1
phrase="Var 1  : Var 2 " 
sep=":"
splitFunction "${phrase}" "${sep}"
