#!/bin/bash

function split()
{
   echo ${1} | cut -f1 -d:
   echo ${1} | cut -f2 -d:
}

split ${1}
