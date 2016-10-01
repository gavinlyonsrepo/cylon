#!/bin/bash

# G lyons
#see cat displays/readme further below for more info
#version control:
#version 1.0 20-06-16
#version 1.1 replace echo with printf functions.
#version 1.2 relative paths added 
#version 1.3-1 google drive function added 
#version 1.4-2 090916 extra cower options added
#version 1.5-3 options added for system backup function(dd and gdrive)
#version 1.6-4  120916 Msgfunc added, PKGBUILD display added 
#version 1.7-5  140916 Config file added for custom backup paths
#version 1.8-6  180916 added rootkithunter option + update counters
#version 1.9-7  250916 added option for rmlint , menu layout option 
#version 2.0-8  011016 added option for lostfiles, system info,optimisations
 

#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
BLUE=$(printf "\033[36;1m")
NORMAL=$(printf "\033[0m")

clear 
#make the path for the logfiles/AUR downloads and updates etc
mkdir -p "$HOME/Documents/Cylon/"
#set logfilepath + cower updates + conf file + custom backup
Dest3="$HOME/Documents/Cylon/"
Dest5="$HOME/.config/cylon"
 
#functions
#function for printing output also creates dirs for output
function msgFunc
{
	case "$1" in 
		line) #print blue horizontal line
			printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
		;;
		anykey) #any key prompt
		    printf '%s' "${GREEN}" 
			read -n 1 -r -s -p "Press any key to continue!"
			printf '%s\n' "${NORMAL}"
		;;
		green) #green text
			printf '%s\n' "${GREEN}$2${NORMAL}" 
		;;
		red) #red text
			printf '%s\n' "${RED}$2${NORMAL}"
		;;
		blue) #blue text
			printf '%s\n' "${BLUE}$2${NORMAL}"
		;;
		norm) #normal text
			if [ "$2" = "" ]
				then
				#just change colour to norm if no text sent
				printf '%s' "${NORMAL}"
				return
			fi
			printf '%s\n' "${NORMAL}$2"
		;;
		dir) #makes dirs for ouput
			TODAYSDIR=$(date +%X-%d-%b-%Y)"$2"
			mkdir "$TODAYSDIR"
			cd "$TODAYSDIR" || exitHandlerFunc dest4
			msgFunc norm "Directory for output made at:-"
			pwd	
		;;
		*)
			printf '%s\n' "Error bad input to msgFunc"
		;;
	esac
}

#Help function to display Help info
function HelpFunc 
{
clear
#print horizonal line 
msgFunc line
msgFunc green "Displaying cylonReadme.md file at $Dest5"
cd "$Dest5"  || exitHandlerFunc dest4
more cylonReadme.md 
msgFunc green "Done!" 
msgFunc line
msgFunc anykey
clear
} 

function checkRequirement
{
	#!/bin/bash
x=`pacman -Qs $1`
if [ -n "$x" ]
 then return true
 else return false
 fi

}

function genChoices
{
	# Without requiremenrs
	declare -A choices
	choices=(
	["1"]="Pacman options "
	["3"]="System maintenance check"
	["4"]="System backup "
	["5"]="System clean by Bleachbit"
	["6"]="System information"
	["7"]="Rmlint remove duplicates and other lint"
	["8"]="Lostfiles scan"
	["9"]="mAv anti-malware scan"
	["0"]="tKit hunter scan"
	["h"]="Display readme file to screen"
	["*"]="Exit"
	)


	#TODO check all  other choices in this way 
	if [[ `checkRequirement "cower"` ]]; then
		ARRAY+=( ["2"]="Cower options (AUR)")
	fi
}





#read cylon.conf for system back up paths 
function readconfigFunc
{
	msgFunc green "Reading config file cylonCfg.conf at:-"
	msgFunc norm "$Dest5"
	#check if file there if not use defaults.
	if [ ! -f "$Dest5/cylonCfg.conf" ]
		then
		msgFunc red "No config found: Use the default paths"
		#path for an internal hard drive backup
		Destination1="/run/media/$USER/Linux_backup"
		#path for an external hard drive backup
		Destination2="/run/media/$USER/iomeaga_320"
		#default paths for gdrive 
		gdriveSource1="$HOME/Documents"
		gdriveSource2="$HOME/Pictures"
		gdriveDest1="0B3_RVJ50UWFAaGxJSXg3NGJBaXc"
		gdriveDest2="0B3_RVJ50UWFAR3A2T3dZTU9TaTA"
		return
	fi
	cd "$Dest5"  || exitHandlerFunc dest4
	source ./cylonCfg.conf
	msgFunc norm "Custom paths read from file"
}


function exitHandlerFunc
{
	#deal with user exists and path not found errors
	case "$1" in
	        exitout)              	
				msgFunc norm " "
			;;
			dest1)  
				  msgFunc red "Path not found to destination directory"	
				  msgFunc norm "$Destination1"
			;;
			dest2)  
			      msgFunc red "Path not found to destination directory"
				  msgFunc norm "$Destination2"
			;;			
			dest3)  
			     msgFunc red "Path not found to destination directory"
			     msgFunc norm "$Dest3"
			;;
			dest4)
				msgFunc red "Path not found to directory"
			;;
			 gdrive)
				msgFunc red "Internet connectivity test to google.com failed"
			;;
	
	 esac
	msgFunc blue "GOODBYE $USER!!"
	msgFunc anykey
	
	exit
}
source ./modules/cower_module
source ./modules/system_maint_module
source ./modules/system_back_module
source ./modules/pacman_module
source ./modules/lostfiles_module
source ./modules/sysinfo_module
source ./modules/clamav_module
source ./modules/rmlint_function
source ./modules/sysclean_module
source ./modules/rootkit_module



#print horizontal line 
msgFunc line
msgFunc red "***** CYLON (CYbernetic LifefOrm Node) (version 2.0-8) (25-09-16) *****" 
msgFunc line
msgFunc norm
#Program details print
cat <<-EOF
Cylon is an Arch Linux  maintenance CLI program written in Bash script.
This program provides numerous tools to Arch Linux users to carry 
out updates, maintenance, system checks and backups. 
AUR package name="cylon" at aur.archlinux.org by glyons.
EOF
#msgFunc line
msgFunc norm
date +%A-Week%U-%d-%B-%Y--%T
#main program loop    
while true; do
    cd ~ || exitHandlerFunc dest4
    msgFunc blue "Main Menu :-"
	cat <<-EOF
	(1)     Pacman options 
	(2)     Cower options (AUR)
	(3)     System maintenance check
	(4)     System backup 
	(5)     System clean by Bleachbit
	(6)     System information
	(7)     Rmlint remove duplicates and other lint
	(8)     Lostfiles scan
	(9) 	ClamAv anti-malware scan
	(0) 	RootKit hunter scan
	(h)     Display readme file to screen
	(*) 	Exit
	EOF
	msgFunc blue "Press option number followed by [ENTER] "
    read -r choiceMain
    case "$choiceMain" in
		1)   #pacman update
			 PacmanFunc 		
		;;	
		
		2) #cower AUR helper
		    CowerFunc
		;;
		3) #system maintenance
			SystemMaintFunc			 
		;;
		4)  #Full system backup
		   	SystemBackFunc
		;;
		5) #system clean with bleachbit
		   SystemCleanFunc							  
		;;
		6) #system info
		   SysinfoFunc							  
		;;
		7) #rmlint 
		   RmLintFunc
		;;
		8)#lostfiles(AUR))
		   lfFunc
		;;
		9) 	#Anti-virus clam Av
			ClamAVFunc  			
		;;
		0)  #rootkit hunter 
			rootKitFunc
		;;
		h)  #cat readme file to screen 
			HelpFunc
		;;
		
		*)  #exit  
			exitHandlerFunc exitout
		;;
	esac

done


 1.2 relatiñ
