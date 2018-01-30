#!/bin/bash
var="j'aime la vie : c'est cool"
echo ${#var}
for i in 1 2 3
do
        echo $var | cut -f$i -d:
done
