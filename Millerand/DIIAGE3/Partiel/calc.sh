#!/bin/bash
#Auteur : Nathan Millerand
#Calc.sh, permet de faire des operations mathematiques simples

function Calc () {
    case "$2" in
        "+") let result=$1+$3 ;;
        "-") let result=$1-$3 ;;
        "*") let result=$1*$3 ;;
        "/") let result=$1/$3 ;;
        *)
            let result=0
            echo -e "Les parametres ont été mal saisis, le resultat affiché est donc 0";;
    esac
}
Calc $1 $2 $3
echo "Le resultat est $result"
