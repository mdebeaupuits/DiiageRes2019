#!/bin/bash
#Auteur : Nathan Millerand
## Disque.sh : permet de lister les disques durs d'une machine

fdisk -l | grep -i disk
