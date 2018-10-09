
#!/bin/bash
#Auteur : Pierre FORZINETTI
#Version : 1.0
#note.sh
#Description  : Afficher un message en fonction de la note obtenue

note="42"
pass="0"
#i=
while [ $note -gt 10 ]
do
if [ -z "$1" ]||[ $pass == "1" ]; 
then 
	echo "What is your score ?"
	read note
else 
	note=$1
	pass="1"
fi
#while [ $i != $# ]
#do
if [ "$note" -ge 9 -a "$note" -le 10  ]; then text="Perfect";
fi
if [ "$note" -ge 7 -a "$note" -le 8  ]; then text="Good";
fi
if [ "$note" -ge 5 -a "$note" -le 6  ]; then text="Not Bad";
fi
if [ "$note" -ge 2 -a "$note" -le 5  ]; then text="Not good";
fi
if [ "$note" -ge 0 -a "$note" -le 2  ]; then text="Bad";
fi
if [ "$note" -ge 10 ]; 
then 
	text="[Error] Your score is not in the range 0 to 10 !";
fi
echo $text
#i=$[$i+1]
done
#done
