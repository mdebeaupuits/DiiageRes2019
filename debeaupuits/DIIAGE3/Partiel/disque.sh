#!/bin/bash
#
# Ce script permet de lister tous les disques disponible sur le serveur
#
#
fdisk -l |grep Disque
