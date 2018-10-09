#!/bin/bash
#Script qui permet de lister les disques durs de la machine

#fdisk -l 2>/dev/null | egrep '^/dev'
fdisk -l
