function add()
{
    
    echo  "IP=$IP : hostname=$hostname : user=$user : mdp=$mdp : os=$os" >> $fic

}


function del()
{
    
    sed -i "/$hostname/d" $fic


}

function mod()
{

    sed -i "s/$host/$host2/g" $fic
    sed -i "s/$ip/$ip2/g" $fic
    sed -i "s/$user/$user2/g" $fic
    sed -i "s/$mdp/$mdp2/g" $fic
    sed -i "s/$os/$os2/g" $fic

}

fic= > /home/paul/Bureau/fic.txt

if [ $# -eq 0 ]
then
    exit
    echo "add, del, mod"
fi

if [ $1 = "add" ]
then

    read -p "hostname : " hostname
    verify=$(awk /"$hostname"/ $fic)
    if [ "x$verify" != "x" ]
    then
        echo "$hostname existe deja"
        exit 
    fi
    else

    read -p "IP : " IP
    read -p "user : " user
    read -p "mdp : " mdp
    read -p "os : " os
    add
fi

if [ $1 = "del" ]
then
    echo -e "quelle hostname a supprimer"
    read -p "hostname : " hostname
    del
fi

if [ $1 = "mod" ]
then

    read -p "hote a changer : " host
    read -p "nom nouvelle hote : " host2

    read -p "IP a changer : " ip
    read -p "nouvelle IP : " ip2

    read -p "user a changer : " user
    read -p "nouveau user : " user2

    read -p "mdp a changer : " mdp
    read -p "nouveau mdp  : " mdp2

    read -p "os a changer : " os
    read -p "nom nouvelle os : " os2



    mod

fi


