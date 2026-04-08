#!/bin/bash 
# === HEADER ===
# Name:   cylon
# Title:  Arch Linux distro maintenance bash script. 
# Author: Gavin lyons 
# Software repo: https://github.com/gavinlyonsrepo/cylon
# AUR package name: cylon , at aur.archlinux.org by glyons

# === ENVIRONMENT & GLOBAL VARIABLES + PATHS ===

# 1. prompt for select menus
if  [ -n "${CYLON_COLOR_OFF}" ] 
then #color off	
	PS3="By your command:"
else #color on
	PS3="$(printf "\033[36;1m")By your command:$(printf "\033[0m")"
fi

# 2. Text editor check if $EDITOR Environmental variable is set if not set it to nano
[ -z "${EDITOR}" ] && export EDITOR="nano"

# 3. Setup the Program Path for cache, Custom Environmental variable
[ -z "${CYLONDEST}" ] && CYLONDEST="$HOME/.cache/cylon/"
mkdir -p "$CYLONDEST"

# 4. Set the program path for config, Custom Environmental variable
[ -z "${CYLON_CONFIG}" ] && CYLON_CONFIG="$HOME/.config/cylon"
mkdir -p "$CYLON_CONFIG"

# 5. CYLON_MODULES = modules location
#Source the module files for the functions from the cylon lib folder
# 5.A DEVELOPMENT PATH: COMMENT OUT 
#CYLON_MODULES="../modules/" 
# 5.B Prodution PATH: COMMENT IN
CYLON_MODULES="/usr/lib/cylon/modules/" 
for CYLON_FILE in "$CYLON_MODULES"*;
do
	# shellcheck disable=SC1090
	source "$CYLON_FILE"
done

# === MAIN CODE ===

readconfigFunc # Read in config file
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
# === EOF ===
