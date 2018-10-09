#!/bin/bash
function getDisk()		#Function to get disks
{
fdisk -l | sed '1q'
}

getDisk
