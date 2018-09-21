function verific()
{
	NbrHost=$(awk '/HOST='$1'/{x+=1}END{print x}' data.txt)
	if [ $NbrHost > 0 ]
	then
		exist="1"
	else
		exist="0"
	fi
}

function readhost()
{
	#Interaction utilisateur
	echo "Nom d'hote"
	read Host
	verific $Host
	if [ $exist = "0" ]
	then
		echo "Nom du fichier de configuration"
		read Ficname
		echo "Adresse IP"
		read Ip
		echo "Compte utilisateur a utiliser"
		read CompteUtil
		echo "Mot de passe du compte"
		read PassUtil
		echo "OS"
		read Os
		echo "Role de ce serveur"
		read Role
		echo "Vlan"
		read Vlan
		echo "Environnement (Production / Recette / Developpement)"
		read Env
		addfic $Host $Ip $CompteUtil $PassUtil $Os $Role $Vlan $Env $Ficname
	else
		echo "l element existe deja"
	fi
}
function addfic()
{
	verifvar $1
	varvide2=$varvide
	verifvar $2
	#Ajout dans le fichier
	#Verification du contenu
	if [ $varvide2 = 0 ] && [ $varvide = 0 ]
	then
		verifip $2
		if [ $stat = 0 ]
		then
			verifssh $3 $2
			if [ $verifsshok = 0 ]
			then
				echo "IP Valide"
				echo "HOST=$1:IP=$2:UTIL=$3:MDP=$4:OS=$5:ROLE=$6:VLAN=$7:ENV=$8" >> $9
			else
				echo "Erreur de comunication avec le serveur"
			fi
		fi
	else
		echo "une entree obligatoire n a pas ete renseignee"
	fi
}
function verifssh()
{
	spawn ssh $1'@'$2
	expect "password:"
	sleep 1
	send "root\r"
	verifsshok=$?
	echo $verifsshok
}
function verifip()
{
    ip=$1
    stat=1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function verifvar()
{
	if [ -z "$1" ];
	then
		varvide="1"
	else
		varvide="0"
	fi
}



function delfic()
{
	sed -i "/HOST=$hostnameperso/d" data.txt
}

function readmodif()
{
	echo "Type de donnee a modifier"
	read type
	echo "Ancienne valeure"
	read hold
	echo "Nouvelle valeur"
	read new
	editfic $type $hold $new
}

function editfic()
{
	sed -i -e 's/'$1'='$2'/'$1'='$3'/g' data.txt
	echo $1'='$2'/'$1'='$3
}

if [ $1 = "add" ]
then
	readhost
fi

if [ $1 = "del" ]
then
	read hostnameperso
	delfic
fi

if [ $1 = "edit" ]
then
	readmodif
fi

