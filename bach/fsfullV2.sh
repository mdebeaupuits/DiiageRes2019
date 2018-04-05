#!/bin/bash
#fsfullV2.sh
#Description : script servant à afficher une alerte si l'un des filesystem dépasse 80% d'utilisation.

df -m |grep -v fichiers| awk '{ if($5 > 80) print "Alerte de saturation à plus de 80% sur" $6; }'	

