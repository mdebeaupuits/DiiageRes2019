#!/bin/bash
#fsfull.sh
#Description : script servant à afficher une alerte si l'un des filesystem dépasse 80% d'utilisation.

#df -m |awk '{ if($5 > 80) printf -d% "Alerte de saturation à 80% sur" $6; }'|grep -v de| cut -d% -f1 
df -m |grep -v fichiers| awk '{ if($5 > 80) print "Alerte de saturation à plus de 80% sur" $6; }'	

#fsFull=$(grep -E "80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100" utilisationfs.txt) 
#if [[ $? == 0 ]]
#then
#	echo `df -m| grep "${fsFull}" |awk '{print $6}'` "est plein à plus de 80%"
#fi
