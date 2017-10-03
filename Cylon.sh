#!/bin/bash
#=========================HEADER==========================================
#name:cylon
#Title : Arch Linux distro maintenance bash script. 
#Description: Updates, maintenance, backups and system checks in 
#single menu driven optional script Command line program for Arch linx users. 
#see readme.md(access thru cylon info page) or manpage "man cylon" for info.
#Version 4.3-4 See changelog.md at repo for version control
#License: see license.md 
#Written by Gavin lyons 
#Software repo: https://github.com/gavinlyonsrepo/cylon
#AUR package name : cylon , at aur.archlinux.org by glyons

#=======================GLOBAL VARIABLES SETUP=============================
#Syntax: Global: UPPERCASE  , local: XXXVar. local Array: XXXArr
#Custom Environmental variable : CYLONDEST 
#Variables also read from config file

#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
YELLOW=$(printf "\033[33;1m")
BLUE=$(printf "\033[36;1m")
HL=$(printf "\033[42;1m")
NORMAL=$(printf "\033[0m")

#prompt for select menus
PS3="${BLUE}By your command:${NORMAL}"

#check if $EDITOR Environmental variable is set if not set it to nano
#used for modifying config files
if [ -z "${EDITOR}" ]
then 
	export EDITOR="nano"
fi

#Setup the Program Paths aka DESTx where x = 1-7,
#1 and 2 are backups path from config file, 3 = program output, 4 = general use
#5 = config file,  6 = Documentation, 7 = Module library location
if [ -z "${CYLONDEST}" ] #if environmental variable CYLONDEST not set
then 
	#default path for program output
	DEST3="$HOME/Documents/Cylon/"
else #yes it is set
	DEST3="$CYLONDEST"
fi

if [ -z "${CYLON_CONFIG}" ] #if environmental variable CYLON_CONFIG not set
then 
	#default path for config file
	DEST5="$HOME/.config/cylon"
else #yes its set
	DEST5="$CYLON_CONFIG"
fi

DEST6="/usr/share/doc/cylon"
DEST7="/usr/lib/cylon/modules/"  #production code path
#DEST7="./modules/" #development code path 
mkdir -p "$DEST3"
mkdir -p "$DEST5"

#====================FUNCTIONS===============================
#Source the module files for the functions from the cylon library folder
#at /usr/lib/cylon/modules/* , Function syntax: nameFunc.
for MYFILE in "$DEST7"*;
do
	source "$MYFILE"
done

#==================MAIN CODE====================================
#if a user input then call checkinput function for user input options
if [ -n "$1" ] 
then
	checkinputFunc "$1"
fi

#Display opening screen title 
clear
msgFunc line
AsciiArtFunc "ARCH"
msgFunc line
msgFunc highlight "$(pacman -Qs cylon | head -1 | cut -c 7-20) -- Arch Linux Maintenance Program"
msgFunc norm "$(date +%T-%d-%a-Week%U-%b-%Y)"
msgFunc norm "Unix epoch time $(date +%s)     "
msgFunc line

#Loop the display main menu function until user exit
while true; do
	cd ~ || exitHandlerFunc DEST4
	DisplayFunc
done
#======================END==============================
