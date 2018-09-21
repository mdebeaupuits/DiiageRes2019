function checkhost()
{
    nbrhost=$(awk '/host='$1'/{x+=1}END{print x}' data.txt)
    if [ $nbrhost > 0 ]
    then
	exist="1"
    else
	exist="0"
    fi
}

function addhost()
{
    #Interaction utilisateur
    echo "Nom d'hote : "
    read host
    checkhost $host
    if [ $exist = "0" ]
    then
	echo "Nom du fichier de configuration : "
	read conffile
	echo "Adresse IP : "
	read ip
	echo "Compte utilisateur a utiliser : "
	read user
	echo "Mot de passe du compte : "
	read password
	echo "OS : "
	read os
	echo "Role de ce serveur : "
	read role
	echo "Vlan : "
	read vlan
	echo "Environnement (Production / Recette / Developpement) : "
	read env
	addtofile $host $ip $user $password $os $role $vlan $env $conffile
    else
	echo "L'element existe deja"
    fi
}

function addtofile()
{
    varcheck $1
    emptyvar2=$emptyvar
    varcheck $2
    #Ajout dans le fichier
    #Verification du contenu
    if [ $emptyvar2 = 0 ] && [ $emptyvar = 0 ]
    then
	ipcheck $2
	if [ $stat = 0 ]
	then
	    #testssh $3 $2
	    #Déclaration de la variable $testsshok à 0 pour passer dans le then
	    testsshok=0
	    if [ $testsshok -eq "0" ]
	    then
		echo "IP Valide"
		echo "host=$1:ip=$2:user=$3:password=$4:os=$5:role=$6:vlan=$7:env=$8" >> $9
    	    else
		echo "Erreur de communication avec le serveur"
	    fi
	fi
	else
	    echo "Une entree obligatoire n'a pas été renseignée"
    fi
}

function testssh()
{
    spawn ssh $1'@'$2
    expect "password:"
    sleep 1
    send "root\r"
    testsshok=$?
    echo $testsshok
}

function ipcheck()
{
    ip=$1
    stat=1
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip2=($ip)
        IFS=$OIFS
        [[ ${ip2[0]} -le 255 && ${ip2[1]} -le 255 && ${ip2[2]} -le 255 && ${ip2[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function varcheck()
{
    if [ -z "$1" ]
    then
	emptyvar="1"
    else
	emptyvar="0"
    fi
}



function delfic()
{
    sed -i "/host=$hostnameperso/d" data.txt
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
    addhost
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

