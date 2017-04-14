#!/bin/bash
#================================================================
# HEADER cylon bash shell script
#================================================================
#name:cylon
#Date 200417
#License: 
#GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#see license.md  at repo or /usr/share/licenses/cylon/
#Written by G lyons 
#Version 3.6-7  See changelog.md at repo for version control
#Software repo
#https://github.com/gavinlyonsrepo/cylon
#AUR package name = cylon , at aur.archlinux.org by glyons
#Description:
#Arch Linux distro maintenance Bash script. 
#Aur package name = cylon 
#A script to do as much maintenance, backups and system checks in 
#single menu driven optional script Command line program for Arch.  
# Usage
# type cylon in terminal, optional config file cylonCfg.conf 
# at "$HOME/.config/cylon"
#options and dependencies 
#see readme.md(access thru cylon info page) or manpage "man cylon"
#================================================================
# END_OF_HEADER

#=======================VARIABLES SETUP=============================
#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
YELLOW=$(printf "\033[33;1m")
BLUE=$(printf "\033[36;1m")
HL=$(printf "\033[42;1m")
NORMAL=$(printf "\033[0m") 

#set the path for the program output
#if environmental variable exists set it to Dest3
if [ -z "${CYLONDEST}" ]
then 
	Dest3="$HOME/Documents/Cylon/"
else 
	Dest3="$CYLONDEST"
fi
#set the path for optional config file Dest5
Dest5="$HOME/.config/cylon"
#set path for readme.md changlog.md dest6
Dest6="/usr/share/doc/cylon"
#prompt for select menus
PS3="${BLUE}By your command:${NORMAL}"
#make the path for the program output dest3
mkdir -p "$Dest3"
#make the path for the optional config file ,left to user to create it
mkdir -p "$Dest5"
#====================FUNCTIONS space (2)===============================
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
# NAME :  exitHandlerFunc 
# DESCRIPTION: error handler deal with user 
#exists and path not found errors and internet failure 
# INPUTS:  $2 text of internet site down or filename
# PROCESS : exitout dest 1-6 netdown or file error
function exitHandlerFunc
{
	case "$1" in
			#dest1 = backup path #dest2 = backup path
			#dest3 = program output #dest4 = general
			#dest5 = config file  #dest6  = Documentation
	        exitout) #non-error exit
	        msgFunc yellow "Goodbye $USER!"
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
			 fileerror) msgFunc red "File error $2"  ;;
	 esac
	msgFunc yellow "Goodbye $USER!"
	msgFunc anykey "and exit."
	exit 1
}
#==================END OF FUNCTIONS SPACE==============================

#==================MAIN CODE HEADER====================================
#=====================================================================
#SOURCE THE MODULES for the functions from the cylon library folder
#for MYFILE in ./modules/*;  #DEBUG ONLY DEBUG ONLY
for MYFILE in /usr/lib/cylon/modules/*;
 do
   # shellcheck disable=SC1090
   source "$MYFILE"
done

#call check input functions 
checkinputFunc "$1"

###################################################
#MAIN SCREEN, print horizontal line  + Title and datetime
msgFunc line
msgFunc highlight "$(pacman -Qs cylon | head -1 | cut -c 7-20) CYbernetic LifefOrm Node"
msgFunc yellow "$(date +%T-%d-%A-Week%U-%B-%Y)"
msgFunc yellow "Unix epoch time $(date +%s)"
msgFunc line
#main program loop    
while true; do
	cd ~ || exitHandlerFunc dest4
	#make the main menu 
	msgFunc blue "Main Menu:"
	optionsM=(
	"pacman" "$(msgFunc checkpac cower NOMES)" 
	"$(msgFunc checkpac pacaur NOMES)" "System Maintenance" 
	"System backup" "Network Maintenance" "$(msgFunc checkpac bleachbit NOMES)"
	"$(msgFunc checkpac rmlint NOMES)" 
	"$(msgFunc checkpac clamav NOMES)" "$(msgFunc checkpac rkhunter NOMES)" 
	"$(msgFunc checkpac lynis NOMES)" "$(msgFunc checkpac htop NOMES)" "xterm"
	"$(msgFunc checkpac ccrypt NOMES)" "Weather" "View/Edit config file"
	 "System Update" "System information" "Cylon information" "Exit"
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
		 "${optionsM[5]}")  # network utiltes
			networkFunc
		    ;;
		 "${optionsM[6]}") #system clean with bleachbit
		   SystemCleanFunc
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
			"${optionsM[14]}")  # 3 day forecast weather
					msgFunc norm "3 day weather forecast by WTTR.IN"
					msgFunc norm "Type a City name, airport code, domain name or area code:-"
					read -r mycity		
					clear
					curl wttr.in/"$mycity"
					msgFunc anykey 
					clear
			;;
			"${optionsM[15]}")   
					 cd "$Dest5"  || exitHandlerFunc dest5
					 if [ -f "$Dest5/cylonCfg.conf" ] 
						then
							msgFunc green "Do you want to edit or view? [e/V]"
					        read -r choiceCC1
							if [ "$choiceCC1" = "e" ]
								then
									nano  "$Dest5/cylonCfg.conf" || exitHandlerFunc fileerror "$Dest5/cylonCfg.conf"
									clear
									msgFunc yellow "Must restart cylon after config file edit"
									msgFunc anykey "and exit."
									exit 0
								else
								msgFunc green  "Custom paths read from file"
								cat "$Dest5/cylonCfg.conf" || exitHandlerFunc fileerror "$Dest5/cylonCfg.conf"
								msgFunc green "Done!"
								msgFunc anykey
							fi
						else
							exitHandlerFunc fileerror "$Dest5/cylonCfg.conf"
						fi
			;;
			"${optionsM[16]}") #system update.
					checkinputFunc "-uu"
			;;
		"${optionsM[17]}") #system info
		   HelpFunc "SYS"
		   ;;
		"${optionsM[18]}")  # cylon info and cat readme file to screen 
			HelpFunc "HELP"
			;;
		*)  #exit  
			exitHandlerFunc exitout ;;
	esac
	break
	done
done
#======================End of MAIN code ===============================

