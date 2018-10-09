#!/bin/bash

ps -eAo pcpu,pid,user,args --sort=-pcpu |head -n 2
