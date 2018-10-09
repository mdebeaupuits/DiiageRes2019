#!/bin/bash

#Script permettant de lister les disques durs de la machine

fdisk -l | grep -i disk


#Pour ce script j'ai fais cette commande mais avec grep -i disque car ma machine est en francais
#J'ai laisser disk pour que ca corresponde à la demande de lenoncer
