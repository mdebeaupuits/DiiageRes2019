#!/bin/bash
if [ $# -eq 0 ]
then
	ps aux | sort -nrk 3,3 | head -n1
elif [ $# -eq 1 ]
then
	lines=$1
	ps aux | sort -nrk 3,3 | head -n${lines}
fi
