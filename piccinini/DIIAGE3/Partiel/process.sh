#!/bin/bash
function getProcess()		#Function to get the process (classic)
{
pid=$(ps -eo %p --sort=-%mem | sed -n 2p)
var=$(ps -eo %cpu --sort=-%mem | sed -n 2p)
}

#function getProcess()		#Function to get the process (bonus)
#{
#pid=$(ps -eo %p --sort=-%mem | head $1)
#var=$(ps -eo %cpu --sort=-%mem | head $1)
#}


function getPath()		#Function to get the path with the pid
{
pPath=$(readlink -f /proc/$pid/exe)
}

getProcess
getPath $pid

echo $var $pPath		#Show result
