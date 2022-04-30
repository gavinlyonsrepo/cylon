#!/bin/bash 
#shellcheck disable=SC1117
#========================= HEADER ==========================
#name:cylon
#Title : Arch Linux distro maintenance bash script. 
#Written by Gavin lyons 
#Software repo: https://github.com/gavinlyonsrepo/cylon
#AUR package name : cylon , at aur.archlinux.org by glyons

#======= ENVIRONMENT & GLOBAL VARIABLES + PATHS =========
#Custom Environmental variables : $CYLONDEST  CYLON_CONFIG CYLON_COLOR_OFF

# Colours for printf, check if color output setting is off
if  [ -n "${CYLON_COLOR_OFF}" ] 
then #color off
	RED=$(printf "\033[0m")
	GREEN=$(printf "\033[0m")
	YELLOW=$(printf "\033[0m")
	BLUE=$(printf "\033[0m")
	NORMAL=$(printf "\033[0m")
else #color on
	RED=$(printf "\033[31;1m")
	GREEN=$(printf "\033[32;1m")
	YELLOW=$(printf "\033[33;1m")
	BLUE=$(printf "\033[36;1m")
	NORMAL=$(printf "\033[0m")
fi

#prompt for select menus
PS3="${BLUE}By your command:${NORMAL}"

#check if $EDITOR Environmental variable is set if not set it to nano
[ -z "${EDITOR}" ] && export EDITOR="nano"

#Setup the Program Paths
# CYLONDEST = cache
# CYLON_CONFIG = config file
# CYLON_DOCUMENTS = help
# CYLON_MODULES = modules location
[ -z "${CYLONDEST}" ] && CYLONDEST="$HOME/.cache/cylon/"
mkdir -p "$CYLONDEST"
[ -z "${CYLON_CONFIG}" ] && CYLON_CONFIG="$HOME/.config/cylon"
mkdir -p "$CYLON_CONFIG"

CYLON_DOCUMENTS="/usr/share/doc/cylon"

# Prodution PATH
CYLON_MODULES="/usr/lib/cylon/modules/" 
# NB ** DEVELOPMENT TESTING PATH ONLY , COMMENT OUT ** NB
#CYLON_MODULES="../modules/" 

#=================== FUNCTIONS =============================
#Source the module files for the functions from the cylon lib folder
for CYLON_FILE in "$CYLON_MODULES"*;
do
	source "$CYLON_FILE"
done

#================= MAIN CODE ============================

readconfigFunc # Variables also read in from config file
[ -n "$1" ] && checkinputFunc "$1" 

#Display opening screen title 
clear
msgFunc line
AsciiArtFunc "ARCH"
msgFunc line
drawBoxFunc "$(pacman -Qs cylon | head -1 | cut -c 7-20): Arch Linux Maintenance Program" \
"Date Time:   $(date +%T" "%d-%a-Week%U-%b-%Y)" "Unix epoch:  $(date +%s)"

#Loop the display main menu function until user exit
while true; do
	cd ~ || exitHandlerFunc UnknownPath
	DisplayFunc
done
#====================== EOF =============================
