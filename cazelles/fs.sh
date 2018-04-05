# !/bin/bash
res=$(df -h | grep -E "8.%|9.%|10.%" | cut -d" " -f1)
if [[ -z ${res} ]]
then
	echo "aucun espace sur-utilisé"
else
	echo "les espaces suivants sont utilisés à plus de 80% :"
	echo ${res}
fi
