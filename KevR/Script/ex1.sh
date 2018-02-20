#phrase="Voici une phrase,totalement random"

#Fonction permettant de splitter
function splitPhrase()
	{
	echo $1 | cut -f1 -d "$2"
	echo $1 | cut -f2 -d "$2"
}

#Declaration et initialisation des variables
phrase="Ceci est une phrase,totalement random"
separateur=","

splitPhrase "${phrase}" "${separateur}"

#echo ${#phrase}
#echo ${phrase}| tr "," "\n"

