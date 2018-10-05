
#!/bin/bash
#Auteur : Pierre FORZINETTI
#Version : 1.0
#disque.sh
#Description  : Ce script permet de lister les disques

fdisk -l | grep -i disk

