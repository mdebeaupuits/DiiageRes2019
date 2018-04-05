#!/bin/bash
var="bonjour le monde"
if [[ $var =~ ^bonjour ]]
then
	echo "OK"
else
	echo "KO"
fi
