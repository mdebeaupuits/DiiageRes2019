#!/bin/bash
#this script allows you to enter a number 
#between 0 and 10 and returns a message according to the note entered

#if the user has not put an argument we return a message and we exit of the script
if [ $# -eq 0 ]
then
    echo "Enter a note please" 
    exit
fi

if [ $# -eq 1 ]
then

    val=$1
fi

    
#while the note is not below 10 or equal to 10 then we repeat the operation
    while [  "$val" -gt 10 ]; do
    echo "Your score is not in the range 0 to 10"
	read -p "What is your score ?" val
    done

    
    if [ "$val" -ge 9 ] && [ "$val" -le 10 ]
    then
        echo "Perfect"
    fi

    if [ "$val" -ge 7 ] && [ "$val" -le 8 ]
    then
        echo "Good"
    fi

    if [ "$val" -ge 5 ] && [ "$val" -le 6 ]
    then
        echo "Not bad"
    fi

#I can't deal with "doubles" in my script 
   
    if [ "$val" -gt 2 ] && [ "$val" -le 5 ]
    then
        echo "Not Good"
    fi

    if [ "$val" -le 2 ] 
    then
        echo "Bad"
    fi





