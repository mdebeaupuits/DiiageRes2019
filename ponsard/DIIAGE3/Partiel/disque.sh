#!/bin/bash
#PAUL PONSARD
#SCRIPT LISTANT LES DISQUES

fdisk -l | grep -i disk
