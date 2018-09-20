#!/bin/bash

maVar="bonjour le monde"
regex="^bonjour\b"

if [[ "${maVar}" =~ ${regex} ]]
then
	echo "ok"
else
	echo "ko"
fi
