#!/bin/bash
#Script qui réalise une opération mathématique (addition, soustraction, multiplication, division)

function Calc () {
    case "$2" in
        "+") let result=$1+$3 ;;
        "-") let result=$1-$3 ;;
        "*") let result='expr $1 \* $3' ;;
        "/") let result=$1/$3 ;;
        *)
            let result=0
            echo "[ERROR] Please give me something to do !"
	    echo "[USAGE] calc.sh 3 + 2";;
    esac
}
Calc $1 $2 $3
echo "Voici le résultat de votre opération : $result"
