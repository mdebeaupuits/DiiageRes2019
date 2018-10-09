#!/bin/bash

function disk {
	fdisk -l | sed '1q'
}

disk
