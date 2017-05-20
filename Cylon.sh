#!/bin/bash
#=========================HEADER=================================
# cylon : Arch Linux distro maintenance bash shell script. 
#================================================================
#name:cylon
#First commit to AUR  =080916
#Last update to github repo =200517
#Last Version release =050517
#License: see license.md 
#Written by Gavin lyons 
#Version 3.7-9 See changelog.md at repo for version control
#Software repo: https://github.com/gavinlyonsrepo/cylon
#AUR package name : cylon , at aur.archlinux.org by glyons
#Title : Arch Linux distro maintenance Bash script. 
#Updates, maintenance, backups and system checks in 
#single menu driven optional script Command line program for Arch linx users. 
#see readme.md(access thru cylon info page) or manpage "man cylon" for info.

#=======================GLOBAL VARIABLES SETUP=============================
#Syntax: Global: uppercase , local: XXXVar. local Array: XXXArr
#environmental variable CYLONDEST. variables also read from config file

#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
YELLOW=$(printf "\033[33;1m")
BLUE=$(printf "\033[36;1m")
HL=$(printf "\033[42;1m")
NORMAL=$(printf "\033[0m") 

#prompt for select menus
PS3="${BLUE}By your command:${NORMAL}"

#Setup the Program Paths aka DESTs
#1 and 2 are backups path from config file
#3 = program output, 4 = general use
#5 = config file,  6 = Documentation
#7 = module library location

#set the path for the program output path DEST3
#if environmental variable CYLONDEST exists set it to DEST3
#and make the path for dest3
if [ -z "${CYLONDEST}" ]
then 
	#default path for program output
	DEST3="$HOME/Documents/Cylon/"
else 
	DEST3="$CYLONDEST"
fi
mkdir -p "$DEST3"

#set the path for optional config file DEST5 and
#make the path for the optional config file ,left to user to create it
DEST5="$HOME/.config/cylon"
mkdir -p "$DEST5"

#set path for readme.md changlog.md DEST6
DEST6="/usr/share/doc/cylon"

#set the path for the modules library functions. DEST7
DEST7="/usr/lib/cylon/modules/*"  #production code path
#DEST7="./modules/" #development code path 


#====================FUNCTIONS===============================

#Source the module files for the functions from the cylon library folder
#at /usr/lib/cylon/modules/*  ,  Function syntax: nameFunc.
for MYFILE in "$DEST7"*;
 do
   # shellcheck disable=SC1090
   source "$MYFILE"
done


#==================MAIN CODE====================================

#call check for user input options
checkinputFunc "$1"

#Display MAIN opening title 
msgFunc line
msgFunc highlight "$(pacman -Qs cylon | head -1 | cut -c 7-20)                    "
msgFunc highlight "Arch Linux Maintenance Program "
msgFunc highlight "$(date +%T-%d-%a-Week%U-%b-%Y)"
msgFunc highlight "Unix epoch time $(date +%s)     "
msgFunc line


#Main menu program, loop until user exit 
while true; do
	#reset path to $HOME
	cd ~ || exitHandlerFunc DEST4
	#call the display main menu function
	DisplayFunc
done
#====================== END ==============================

