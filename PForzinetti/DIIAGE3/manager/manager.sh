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
	echo "Contenu des variables: OK"
	ipcheck $2
	if [ $stat = 0 ]
	then
	    echo "Format de l adresse IP: OK"
	    sshname=$3
	    sshhost=$2
	    testssh
	    #Déclaration de la variable $testsshok à 0 pour passer dans le then
	    testsshok=0
	    if [ $testsshok -eq "0" ]
	    then
		echo "Test de la comunication avec le serveur: OK"
		#echo "host=$1:ip=$2:user=$3:password=$4:os=$5:role=$6:vlan=$7:env=$8" >> $9
		echo "IP=$2:Hostname=$1:User=$3:Auth=$4:OS=$5:Roles=$6:VLAN=$7:Environement=$8" >> $9
		echo "Element ajouté au fichier"
    	    else
		echo "Test de la comunication avec le serveur: Erreur de comunication"
	    fi
	else
	    echo "Format de l'adresse IP: Format non conforme"
	fi
	else
	    echo "Contenu des variables: Element(s) obligatoire(s) manquant(s) "
    fi
}

function testssh()
{
    ssh -o ConnectTimeout=5 $sshname@$sshhost echo "" > /dev/null 2>&1
    sshresult=$?
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
    sed -i "/${delline}/d" data.txt
    if [[ $? -eq 1 ]]
    then
	echo "Erreur de suppression"
        return 1 
    else
	return 0
    fi
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
	sed -i "s/${hostmodify}/${valuemodify}/g" data.txt
}

if [ $1 = "add" ]
then
    addhost
fi

if [ $1 = "del" ]
then
    cat data.txt |awk -F ":" '{ print $2 }'	
    echo "Host a modifier"
    read delline
    delfic ${delline}
fi

if [ $1 = "edit" ]
then
    echo "Quel est l hote a modifier"
    read hostmodify
    grep ${hostmodify} data.txt
    echo "Copier cette ligne et modifier la ci dessous"
    read valuemodify
    valuemodify=$(grep ${hostmodify} data.txt)
    editfic 
fi
