#!/bin/bash
#PAUL PONSARD
#SCRIPT PERMETTANT LE TRI DE NOTES


notgood=$(echo $((5/2)))


#Fonction verification de la note
function testnote(){
    if [[ $note -ge 9 && $note -le 10 ]]
    then
        echo "Perfect"
    elif [[ $note -ge 7 && $note -le 8 ]]
    then
        echo "Good"
    elif [[ $note -ge 5 && $note -le 6 ]]
    then
	if [ $note -eq 5 ]
	then
            echo "Not good Not bad"
	else
	    echo "Not bad"
	fi
    elif [[ $note -ge $notgood && $note -le 5 ]]
    then
        echo "Not good"
    else
        echo "Bad"
    fi
}

#fonction verification de plusieurs notes
function testnoteloop(){

    while [ $note -gt 10 ]
    do
        echo "[Error] Your score is not in the range 0 to 10 !"
    done
    if [[ $note -ge 9 && $note -le 10 ]]
    then
        echo $note " -> Perfect"
    elif [[ $note -ge 7 && $note -le 8 ]]
    then
        echo^$note " -> Good"
    elif [[ $note -ge 5 && $note -le 6 ]]
    then
        if [ $note -eq 5 ]
        then
            echo $note " -> Not good Not bad"
        else
            echo $note " -> Not bad"
        fi
    elif [[ $note -ge $notgood && $note -le 5 ]]
    then
        echo $note " -> Not good"
    else
        echo $note " -> Bad"
    fi

}

#Appel de la fonction testnote et verification si notes passees en parametres
if [ $# -eq 0 ]
then
    read -p "What is your score ? " note
    testnote
else
    while [ $# -gt 0 ]
    do
	note=$1
        testnoteloop
	shift
    done
fi



