#!/bin/bash

if [[ $# -eq 0 ]]
then
	echo "[Error] Please give me something to do!"
	echo "[Usage] calc.sh 3 + 2"
	exit 1
fi

CALCUL=$(( $* ))

echo "$* = ${CALCUL}"
