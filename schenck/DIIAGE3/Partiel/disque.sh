#!/bin/bash

fdisk -l 2>/dev/null | grep '^/dev'
