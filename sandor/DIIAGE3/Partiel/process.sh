#!/bin/bash
#Exercice 2 process.sh
# create a script that gives the process that use the more CPU o nthe machine
ps -C  -o %cpu,%mem,cmd
