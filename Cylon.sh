#!/bin/bash
#=========================HEADER=================================
# cylon : A bash shell script
#================================================================
#name:cylon
#Date 100517
#License: see license.md 
#Written by Gavin lyons 
#Version 3.7-9 See changelog.md at repo for version control
#Software repo: https://github.com/gavinlyonsrepo/cylon
#AUR package name : cylon , at aur.archlinux.org by glyons
#Title : Arch Linux distro maintenance Bash script. 
#Updates, maintenance, backups and system checks in 
#single menu driven optional script Command line program for Arch linx users. 
#see readme.md(access thru cylon info page) or manpage "man cylon" for info.

#=======================VARIABLES SETUP=============================
#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
YELLOW=$(printf "\033[33;1m")
BLUE=$(printf "\033[36;1m")
HL=$(printf "\033[42;1m")
NORMAL=$(printf "\033[0m") 

#prompt for select menus
PS3="${BLUE}By your command:${NORMAL}"

#Program Paths aka Dests
#dest1 #dest2= backup path from config file
#dest3 = program output #dest4 = general use
#dest5 = config file  #dest6  = Documentation

#set the path for the program output path Dest3
#if environmental variable CYLONDEST exists set it to Dest3
if [ -z "${CYLONDEST}" ]
then 
	#default path for program output
	Dest3="$HOME/Documents/Cylon/"
else 
	Dest3="$CYLONDEST"
fi
#set the path for optional config file Dest5
Dest5="$HOME/.config/cylon"
#set path for readme.md changlog.md Dest6
Dest6="/usr/share/doc/cylon"
#make the path for the program output dest3
mkdir -p "$Dest3"
#make the path for the optional config file ,left to user to create it
mkdir -p "$Dest5"

#====================FUNCTIONS===============================
#
#Source the modules files for the functions from the cylon library folder
#at /usr/lib/cylon/modules/*
#
#The debug path comment OUT in production code
#for MYFILE in ./modules/*;  
#
for MYFILE in /usr/lib/cylon/modules/*;
 do
   # shellcheck disable=SC1090
   source "$MYFILE"
done

#==================MAIN CODE====================================

#call check for user input options
checkinputFunc "$1"

#Display MAIN opening title 
msgFunc line
msgFunc highlight "$(pacman -Qs cylon | head -1 | cut -c 7-20) CYbernetic LifefOrm Node"
msgFunc yellow "$(date +%T-%d-%A-Week%U-%B-%Y)"
msgFunc yellow "Unix epoch time $(date +%s)"
msgFunc line

#Main menu program, loop until user exit 
while true; do
	#reset path to $HOME
	cd ~ || exitHandlerFunc dest4
	#call the display main menu function
	DisplayFunc
done
#====================== END ==============================

