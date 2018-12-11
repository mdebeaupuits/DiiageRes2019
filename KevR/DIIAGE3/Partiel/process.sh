#!/bin/bash

# Script qui donne le processus qui utilise le plus de CPU sur la machine

function Process() {

if [ $# -ge 1 ]
  then
     if [ "$1" -ge 1 ]
       then
         ps -eo pcpu,pid,comm --sort=-pcpu | head -n "$1"
       else
         echo "Il faut au moins 1 paramètre pour obtenir les processus utilisant le plus de CPU sur cette machine!"
     fi
  else
    ps -eo pcpu,pid,comm --sort=-pcpu | head -n 2
fi

}
Process
