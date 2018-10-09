#!/bin/bash
#this script allows you to retrieve the most demanding process 
if [ $# -eq 0 ]
then
    
    
    cpu=$(ps -eo %cpu,args | sort -nrk1 | head -n1 | awk -F " "  '{print $1}')
    cpu2=$(ps -Ao 'time=' -o 'args=' |sort -rn | head -n1 | awk -F " "  '{print $2,$3,$4}')
    cpu3=$(echo $cpu %)
    echo "process is use the most cpu is $cpu2 $cpu3 "


fi

if [ $# -eq 1 ]
then
  
    cpu=$(ps -eo %cpu,args | sort -nrk1 | head  | awk -F " "  '{print $1}')
    cpu2=$(ps -Ao 'time=' -o 'args=' |sort -rn | head  | awk -F " "  '{print $2,$3,$4}')
    cpu3=$(echo $cpu %)
    echo "the 10 process is use the most cpu is $cpu2 $cpu3 "
    
fi





