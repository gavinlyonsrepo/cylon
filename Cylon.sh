#!/bin/bash
#================================================================
# HEADER cylon bash shell script
#================================================================
#name:cylon
#Date 280317
#License: 
#GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#see license.md  at repo or /usr/share/licenses/cylon/
#
#Written by G lyons 
#
#Version 3.4-5  See changelog.md at repo for version control
#
#Software repo
#https://github.com/gavinlyonsrepo/cylon
#AUR package name = cylon , at aur.archlinux.org by glyons
#Description:
#Arch Linux distro maintenance Bash script. 
#Aur package name = cylon 
#A script to do as much maintenance, backups and system checks in 
#single menu driven optional script Command line program for Arch.  
#see readme.md  at repo 
#or usr/share/doc for more info also man page.
#
# Usage
# type cylon in terminal, optional config file cylonCfg.conf 
# at "$HOME/.config/cylon"
#options
#-h --help  print help and exit.
#-s --system  print system information and exit
#-v --versiom print version information and exit.
#-c --config open config file
#-u --update run update routine all
#optional dependencies see helpFunc or PKGBUILD or reame
#================================================================
# END_OF_HEADER
#================================================================


#=======================VARIABLES SETUP=============================
#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
YELLOW=$(printf "\033[33;1m")
BLUE=$(printf "\033[36;1m")
HL=$(printf "\033[42;1m")
NORMAL=$(printf "\033[0m") 
#make the path for the program output dest3
mkdir -p "$HOME/Documents/Cylon/"
#make the path for the optional config file ,left to user to create it
mkdir -p "$HOME/.config/cylon"
#set the path for the program output
Dest3="$HOME/Documents/Cylon/"
#set the path for optional config file dest5
Dest5="$HOME/.config/cylon"
#set path for readme.md changlog.md dest6
Dest6="/usr/share/doc/cylon"
#prompt for select menus
PS3="${BLUE}By your command:${NORMAL}"
#

#====================FUNCTIONS space (3)===============================
#FUNCTION HEADER
# NAME :            msgFunc
# DESCRIPTION :     utility and general purpose function,
#prints line, text and anykey prompts, makes dir for system output,
#checks network and package install
# INPUTS : $1 process name $2 text input $3 text input    
# OUTPUTS : checkpac returns 1 or 0 
# PROCESS :[1]   line [2]    anykey
# [3]   "green , red ,blue , norm yellow and highlight" ,                 
# [4]   checkpac [5]   checkNet v
#NOTES :   needs gnu-cat installed for checkNet        
function msgFunc
{
	case "$1" in 
	
		line) #print blue horizontal line of =
			printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
			msgFunc norm
		;;
		anykey) #any key prompt, appends second text input to prompt
		    printf '%s' "${GREEN}" 
			read -n 1 -r -s -p "Press any key to continue $2"
			printf '%s\n' "${NORMAL}"
		;;
		
		#print passed text string
		green) printf '%s\n' "${GREEN}$2${NORMAL}" ;;
		red) printf '%s\n' "${RED}$2${NORMAL}" ;;
		blue) printf '%s\n' "${BLUE}$2${NORMAL}" ;;
		yellow)printf '%s\n' "${YELLOW}$2${NORMAL}" ;;
		highlight)printf '%s\n' "${HL}$2${NORMAL}" ;;
		
		norm) #print normal text colour
			if [ "$2" = "" ]
				then
				#just change colour to norm if no text sent
				printf '%s' "${NORMAL}"
				return
			fi
			printf '%s\n' "${NORMAL}$2" ;;
			
		dir) #makes dirs for output appends passed text to name
			#check if coming from system backup other path
			if [ "$3" != 1 ]
			then 
			cd "$Dest3" || exitHandlerFunc dest3
			fi
			TODAYSDIR=$(date +%H%M-%d%b%y)"$2"
			mkdir "$TODAYSDIR"
			cd "$TODAYSDIR" || exitHandlerFunc dest4
			msgFunc norm "Directory for output made at:-"
			pwd	 ;;
			 
		checkpac) #check if package(passed text 2) installed 
		          #returns 1 or 0  and appends passed text 3
		          #if NOMES passed as $3 goto menu display mode
			x=$(pacman -Qqs "$2")
			if [ -n "$x" ]
			then #installed
				#if text input is NOMES skip install good message
				if [ "$3" = "NOMES" ] 
				then 
					printf '%s' "$2"
				else
					printf '%s\n' "$2 is Installed $3"
				fi
				return 0
			else #not installed
				#if text input is NOMES skip install bad message
				if [ "$3" = "NOMES" ] 
				then
					printf '%s' "$2 n/a"
				else
					printf '%s\n' "${RED}$2 is Not installed${NORMAL} $3"
				fi
				return 1
			fi ;;
			
		checkNet) #checks network with netcat 
					#check netcat is installed
					if ! msgFunc checkpac gnu-netcat  
					then
						if ! msgFunc checkpac openbsd-netcat 
						then
							msgFunc red "Install gnu-netcat or openbsd-netcat for Network check"
							msgFunc anykey 
							exitHandlerFunc exitout
						fi
					fi
					#This uses netcat (nc) in its port scan mode, 
					#a quick poke (-z is zero-I/O mode [used for 
					#scanning]) with a quick timeout 
					#(-w 1 waits at most one second
					#It checks Google on port 80 (HTTP).
					if nc -zw1 "$2" 80; then
						msgFunc norm   "We have connectivity $2"
					else
						exitHandlerFunc netdown "$2"
					fi
		;;
		*) #for debug catch typos etc
			printf '%s\n' "Error bad input to msgFunc"
			 ;;
	esac
}

#FUNCTION HEADER
# NAME :            HelpFunc
# DESCRIPTION :     two sections one prints various system information the
# other cylon information and the installed readme file
# INPUTS : $1 process name either HELP or SYS    
# OUTPUTS : n/a
# PROCESS :[1] HELP =cylon info [2] SYS   =system info
function HelpFunc 
{
clear
msgFunc line
	if [ "$1" = "HELP" ]
				then
				msgFunc green "cylon info and readme display" 
				msgFunc line 
				#Program details print
				cat <<-EOF
				Cylon is an Arch Linux maintenance CLI program written in Bash script.
				This program provides numerous tools to Arch Linux users to carry 
				out updates, maintenance, system checks, backups and more. 
				EOF
				msgFunc norm "Written by G.Lyons, Reports to  <glyons66@hotmail.com>"
				msgFunc norm "AUR package name = cylon, at aur.archlinux.org by glyons."
				msgFunc norm "Version=$(pacman -Qs cylon | head -1 | cut -c 7-20)"
				msgFunc norm "Cylon program location = $(which cylon)"
				msgFunc norm "Cylon modules for functions = /usr/lib/cylon/modules/*"
				msgFunc norm "Folder for Cylon output data = $Dest3"
				msgFunc norm "Location of cylonCfg.conf = $Dest5"
				msgFunc norm "Location of readme.md changlog.md = $Dest6"
				msgFunc norm "Location of License.md = /usr/share/licenses/cylon"
				msgFunc norm "Man page, Desktop entry  and icon also installed"
				msgFunc anykey "and check which optional dependencies are installed"
				#cower  (optional) – AUR package for AUR work
				msgFunc checkpac cower "NOTE: AUR package"
				#gdrive  (optional) – AUR package for google drive backup
				msgFunc checkpac gdrive "NOTE: AUR package"
				#lostfiles (optional) – AUR package for finding lost files
				msgFunc checkpac lostfiles "NOTE: AUR package"
				#pacaur (optional – AUR package for AUR work
				msgFunc checkpac pacaur  "NOTE: AUR package"
				#arch-audit(optional) -AUR package  for Arch CVE Monitoring Team data
				msgFunc checkpac arch-audit "NOTE: AUR package"
				#rmlint (optional) – Finds lint and other unwanted
				msgFunc checkpac rmlint
				#rkhunter (optional) – finds root kits malware
				msgFunc checkpac rkhunter
				#gnu-netcat (optional) – used for checking network
				msgFunc checkpac gnu-netcat "NOTE: No need if using openbsd-netcat"
				#openbsd-netcat(optional) – used for checking network
				msgFunc checkpac openbsd-netcat "NOTE: No need if using gnu-netcat"
				#clamav  (optional) – used for finding malware
				msgFunc checkpac clamav
				#bleachbit  (optional) – used for system clean
				msgFunc checkpac bleachbit 
				#ccrypt (optional) – Encrypt and decrypt files
				msgFunc checkpac ccrypt
				#rsync (optional) – backup utility
				msgFunc checkpac rsync
				#lynis (optional) – system auditor
				msgFunc checkpac lynis
				#inxi (optional) – CLI system information script 
				msgFunc checkpac inxi
				#htop (optional) – Command line system information script 
				msgFunc checkpac htop
				#wavemon (optional) – wireless network monitor 
				msgFunc checkpac wavemon
				#speedtest-cli (optional) – testing internet bandwidth
				msgFunc checkpac speedtest-cli
				msgFunc anykey "and view the readme."
				msgFunc line
				msgFunc green "Displaying cylonReadme.md file at $Dest6"
				cd "$Dest6"  || exitHandlerFunc dest6
				more Readme.md 
				msgFunc green "Done!" 
				msgFunc line
				msgFunc anykey
				clear
				return
			fi
msgFunc green "System Information"
msgFunc line
msgFunc norm  #set colour back
date +%A-Week%U-%d-%B-%Y--%T
msgFunc norm "Uptime = $(uptime -p)"
msgFunc norm "Operating System + Kernal = $(uname -mosr)"
msgFunc norm "Network node name = $(uname -n)"
msgFunc norm "Screen Resolution = $(xrandr |grep "\*" | cut -c 1-15)"
msgFunc norm "CPU $(grep name /proc/cpuinfo  | tail -1)"
mem=($(awk -F ':| kB' '/MemTotal|MemAvail/ {printf $2}' /proc/meminfo))
memused="$((mem[0] - mem[1]))"
memused="$((memused / 1024))"
memtotal="$((mem[0] / 1024))"
memory="${memused}MB / ${memtotal}MB"
msgFunc norm "RAM used/total = ($memory)"
msgFunc highlight "Package Information"
msgFunc norm "Number of All installed  packages = $(pacman -Q | wc -l)"
msgFunc norm "Number of native, explicitly installed packages  = $(pacman -Qgen | wc -l)"
msgFunc norm "Number of foreign installed packages  = $(pacman -Qm | wc -l)"
msgFunc norm "Accessing archlinux.org Network Database...." 
msgFunc norm   "Number of Pacman updates ready...>  "
msgFunc yellow "$(checkupdates | wc -l)"
if ! msgFunc checkpac cower
	then
	msgFunc anykey 
	return
fi
msgFunc norm "Number of updates for installed AUR packages ready ...>"
msgFunc yellow "$(cower -u | wc -l)"
if ! msgFunc checkpac arch-audit 
	then
	msgFunc anykey 
	return
fi
msgFunc norm "Number of upgradable Arch-audit vulnerable packages ...>"
msgFunc yellow "$(arch-audit -qu | wc -l)"
msgFunc anykey 
clear
}

#FUNCTION HEADER
# NAME :           readconfigFunc
# DESCRIPTION:read the config file into program if not there   
#use hardcoded defaults config file is for paths for backup function
# OUTPUTS : sets paths for backup function 
# PROCESS : read $Dest5/cylonCfg.conf
#NOTES :   file is optional       
function readconfigFunc
{
	#read cylon.conf for system back up paths 
	msgFunc green "Reading config file cylonCfg.conf at:-"
	msgFunc norm "$Dest5"
	#check if file there if not use defaults.
	if [ ! -f "$Dest5/cylonCfg.conf" ]
		then
		msgFunc red "No config found: Use the default hardcoded paths"
		#path for an internal hard drive backup
		Destination1="/run/media/$USER/Linux_backup"
		#path for an external hard drive backup
		Destination2="/run/media/$USER/iomeaga_320"
		#default paths for gdrive sync upload path 1 		#path2 
		gdriveSource1="$HOME/Documents"
		gdriveDest1="0B3_RVJ50UWFAaGxJSXg3NGJBaXc"
		gdriveSource2="$HOME/Pictures"
		gdriveDest2="0B3_RVJ50UWFAR3A2T3dZTU9TaTA"
		#paths for rsync option
		rsyncsource="$HOME/"
		rsyncDest="/run/media/$USER/Linux_backup/Hbp_rsync_101016"
		#ccyptfile
		myccfile="XXXX"
		msgFunc green "Done!"
		return
	fi
	cd "$Dest5"  || exitHandlerFunc dest5
	# shellcheck disable=SC1091
	source ./cylonCfg.conf
	msgFunc green  "Custom paths read from file"
	cat ./cylonCfg.conf
	msgFunc green "Done!"
}

#FUNCTION HEADER
# NAME :  exitHandlerFunc 
# DESCRIPTION: error handler deal with user 
#exists and path not found errors and internet failure 
# INPUTS:  $2 text of internet site down
# PROCESS : exitout dest 1-5 netdown 
function exitHandlerFunc
{
	case "$1" in
			#dest1 = backup path #dest2 = backup path
			#dest3 = program output #dest4 = general
			#dest5 = config file  #dest6  = Documentation
	        exitout) 
	        msgFunc yellow "GOODBYE $USER!!"
			msgFunc anykey "and exit."
			exit 0
	        ;;
			dest1) msgFunc red "Path not found to destination directory"	
				  msgFunc norm "$Destination1" ;;
			dest2) msgFunc red "Path not found to destination directory"
				  msgFunc norm "$Destination2" ;;			
			dest3) msgFunc red "Path not found to destination directory"
			     msgFunc norm "$Dest3" ;;
			dest4) msgFunc red "Path not found to directory"  ;;
			dest5) msgFunc red "Path not found to destination directory"
			     msgFunc norm "$Dest5" ;;
			dest6) msgFunc red "Path not found to destination directory"
			     msgFunc norm "$Dest6" ;;
			 netdown) msgFunc red "Internet connectivity test to $2 failed" ;;
	 esac
	msgFunc yellow "GOODBYE $USER!!"
	msgFunc anykey "and exit."
	exit 1
}
#==================END OF FUNCTIONS SPACE==============================
#======================================================================

#==================MAIN CODE HEADER====================================
#=====================================================================
#SOURCE THE MODULES for the functions from the cylon library folder
#for MYFILE in ./modules/*;  #DEBUG ONLY DEBUG ONLY
#echo $f #debug
for MYFILE in /usr/lib/cylon/modules/*;
 do
   # shellcheck disable=SC1090
   source "$MYFILE"
done
########
#CHECK INPUT OPTIONS from linux command line arguments passed to program on call
#-v display version and exit
#-s display system info and exit
#-h display cylon info and exit 
#-c open config file for edit.
#-u update all
case "$1" in
	"");;
	-u|--update)
      clear
      #check if arch-audit package  installed
		if ! msgFunc checkpac arch-audit
		then
			msgFunc anykey 
			clear
		return
		fi
		#check if pacaur package  installed
		if ! msgFunc checkpac pacaur
		then
			msgFunc anykey 
			clear
		return
		fi
	  msgFunc line
		RssFunc
	  msgFunc anykey
	  msgFunc line
	  msgFunc green "Arch-audit upgradable vulnerable packages"
	  arch-audit -u #used to be -q pre v3.3
	  msgFunc line
      msgFunc green "Number of Pacman updates ready ..> $(checkupdates | wc -l)"	
	  checkupdates
	  msgFunc anykey
	  msgFunc line
	  msgFunc green "Number of updates available for installed AUR packages ..> $(cower -u | wc -l)"
	  cower -uc
	   cat <<-EOF
		The Arch User Repository (AUR) is a community-driven repository for Arch users
		When installing packages or installing updates
		user beware. Also make sure TargetDir in cower config file not set. 
		EOF
		msgFunc line
	  msgFunc green "Install ALl updates? pacaur -Syu	 [Y/n]"
	  read -r choiceIU3
			if [ "$choiceIU3" != "n" ]
				then
					pacaur -Syu	
			fi
		msgFunc green "Done!"
	;;
  -c|--config)
		nano  "$HOME/.config/cylon/cylonCfg.conf"
    ;;
  -d|--defaultBB)
#Bleachbit system clean. Use the options set in the GUI
		msgFunc green "Bleachbit system clean"  
		msgFunc norm "Preset options see $HOME/.config/bleachbit/ or GUI "
		msgFunc norm  "Running bleachbit -c --preset"
		bleachbit -c --preset
		msgFunc green "Done!"
     ;;
  -v|--version)
		msgFunc norm "$(pacman -Qs cylon)" 
    ;;
  -s|--system)
		HelpFunc SYS
    ;;
  -h|--help)
		HelpFunc HELP
    ;;
   *) msgFunc yellow "Usage:- -c -d -v -s -u -h"
   ;;
esac
if [ -n "$1" ] 
then
	exit 0 
else
	clear
fi   
#############
#MAIN SCREEN, print horizontal line  + Title and datetime
msgFunc line
msgFunc highlight "$(pacman -Qs cylon | head -1 | cut -c 7-20) (CYbernetic LifefOrm Node)"
msgFunc yellow "$(date +%T-%A-%d-Week%U-%B-%Y)"
msgFunc line
#main program loop    
while true; do
	cd ~ || exitHandlerFunc dest4
	#make the main menu 
	msgFunc blue "Main Menu:"
	optionsM=(
	"pacman" "$(msgFunc checkpac cower NOMES)" 
	"$(msgFunc checkpac pacaur NOMES)" "System check" 
	"System backup" "$(msgFunc checkpac bleachbit NOMES)"
	"Network" "$(msgFunc checkpac rmlint NOMES)" 
	"$(msgFunc checkpac clamav NOMES)" "$(msgFunc checkpac rkhunter NOMES)" 
	"$(msgFunc checkpac lynis NOMES)" "$(msgFunc checkpac htop NOMES)" "xterm"
	"$(msgFunc checkpac ccrypt NOMES)" "Password generator" "Delete files"
	"Weather" "$(msgFunc checkpac inxi NOMES)" "System information" "Cylon information" "Exit"
	)
	select choiceMain in "${optionsM[@]}"
	do
	case "$choiceMain" in
		"${optionsM[0]}")   #pacman update
			 PacmanFunc
			  ;;
		"${optionsM[1]}") #cower AUR helper
		    CowerFunc
		     ;;
		"${optionsM[2]}") #pacaur AUR helper
		    pacaurFunc
		     ;;
		"${optionsM[3]}") #system maintenance
			SystemMaintFunc 
			;;
		"${optionsM[4]}")  #Full system backup
		   	SystemBackFunc 
		   	 ;;
		 "${optionsM[5]}") #system clean with bleachbit
		   SystemCleanFunc
		    ;;
		"${optionsM[6]}")  # network utiltes
			networkFunc
		    ;;
		"${optionsM[7]}") #rmlint 
		   RmLintFunc
		    ;;
		"${optionsM[8]}") 	#Anti-virus clamav
			AntiMalwareFunc "CLAMAV"
			 ;;
		 "${optionsM[9]}")  #rootkit hunter 
			AntiMalwareFunc "RKHUNTER"
			;;
		"${optionsM[10]}")  # Lynis - System and security auditing tool
			AntiMalwareFunc "LYNIS"
			 ;;
		"${optionsM[11]}")  # htop - interactive process viewer
			#check if htop package  installed
				if ! msgFunc checkpac htop
				then
					msgFunc anykey 
					clear
				break
				fi
			xterm -e "htop" &  
			msgFunc anykey
			;;
		"${optionsM[12]}")  # open a terminal
			xterm &
			msgFunc anykey
			;;
		"${optionsM[13]}")  # ccrypt - encrypt and decrypt files 
			ccryptFunc
			;;
		"${optionsM[14]}")  # password generator 
			msgFunc green "Random Password generator"
			msgFunc norm "Enter length:-"
			read -r mylength
			if [ -z "$mylength" ]; then
				mylength=50
			fi
			msgFunc dir "-PGINFO"
		    echo -n "$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c"${1:-$mylength}";)"	> pg	  
			msgFunc green "Done!"
			;;
		"${optionsM[15]}")  # delete folders /files
			SystemCleanFunc "FOLDERS"
			;;
		"${optionsM[16]}")  # 3 day forecast weather
			msgFunc norm "3 day weather forecast by WTTR.IN"
			msgFunc norm "Type a City name, airport code, domain name or area code:-"
			read -r mycity		
			clear
			curl wttr.in/"$mycity"
			msgFunc anykey 
			clear
			;;
			"${optionsM[17]}") 
				#check if inxi package  installed
				if ! msgFunc checkpac inxi
				then
					msgFunc anykey 
					clear
				break
				fi
				# inxi  - Command line system information script for console and IRC
				msgFunc green "get output of inxi -Fixz"
				msgFunc dir "-SYSINXI"
				inxi -Fixz | tee inxioutput
				msgFunc green "Done!"
				msgFunc anykey
			;;
		"${optionsM[18]}") #system info
		   HelpFunc "SYS"
		   ;;
		"${optionsM[19]}")  # cylon info and cat readme file to screen 
			HelpFunc "HELP"
			;;
		*)  #exit  
			exitHandlerFunc exitout ;;
	esac
	break
	done
done
#======================End of MAIN code ===============================

