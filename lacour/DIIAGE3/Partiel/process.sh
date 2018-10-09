#!/bin/bash

#function proc allow us to see what's the most CPU consumming process on this Linux
function proc {
	#Sort all process with only pid, cpu and cmd column, sort by cpu and output only the n first lines
	ps -ea -o pid,%cpu,cmd | sort -n -k2 | sed ''$1'q'
}

#Calling function with parameter
proc $1
