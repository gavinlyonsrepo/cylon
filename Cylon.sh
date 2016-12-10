#!/bin/bash
#================================================================
# HEADER cylon bash shell script
#================================================================
#name:cylon
#Date 09122016 
#License: 
#GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#see license.md  at repo or /usr/share/licenses/cylon/
#
#Written by G lyons 
#
#Version 3.0-1  See changelog.md at repo for version control
#
#Software repo
#https://github.com/gavinlyonsrepo/cylon
#AUR package name = cylon , at aur.archlinux.org by glyons
#Description:
#Arch Linux distro maintenance Bash script. 
#Aur package name = cylon 
#A script to do as much maintenance, backups and system checks in 
#single menu driven optional script Command line program for Arch.  
#This script provides numerous tools to Arch Linux 
#for maintenance, system checks and backups. see readme.md  at repo 
#or usr/share/doc for more info.
#
# Usage
# type cylon in terminal, optional config file cylonCfg.conf 
# at "$HOME/.config/cylon"
#options
#-h --help -help print help and exit.
#-s --system  print system information and exit
#-v --versiom print version information and exit.

#optional dependencies
#bleachbit  (optional) – used for system clean
#clamav  (optional) – used for finding malware
#cower  (optional) – AUR package for AUR work
#gdrive  (optional) – AUR package for google drive backup
#gnu-netcat (optional) – used for checking network
#lostfiles (optional) – AUR package for finding lost files
#rkhunter (optional) – finds root kits malware
#rmlint (optional) – Finds lint and other unwanted
#ccrypt (optional) – Encrypt and decrypt files
#rsync (optional) – backup utility
#lynis (optional) – system auditor
#pacaur (optional – AUR package for AUR work
#inxi (optional) – CLI system information script 
#htop (optional) – Command line system information script 
#wavemon (optional) – wireless network monitor 
#speedtest-cli (optional) – testing internet bandwidth
#================================================================
# END_OF_HEADER
#================================================================
#
#=======================VARIABLES SETUP=============================
#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
BLUE=$(printf "\033[36;1m")
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
PS3="${BLUE}Press option number + [ENTER]${NORMAL}"
#====================FUNCTIONS space (15)===============================
#FUNCTION HEADER
# NAME :            msgFunc
# DESCRIPTION :     utility and general purpose function,
#prints line, text and anykey prompts, makes dir for system output,
#checks network and package install
# INPUTS : $1 process name $2 text input $3 text input    
# OUTPUTS : checkpac returns 1 or 0 
# PROCESS :[1]   line [2]    anykey
# [3]   "green , red ,blue , norm" ,                 
# [4]   checkpac [5]   checkNet v
#NOTES :   needs gnu-cat installed for checkNet        
function msgFunc
{
	case "$1" in 
	
		line) #print blue horizontal line of =
			printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
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
			TODAYSDIR=$(date +%H%M%a%b%C)"$2"
			mkdir "$TODAYSDIR"
			cd "$TODAYSDIR" || exitHandlerFunc dest4
			msgFunc norm "Directory for output made at:-"
			pwd	 ;;
			
		checkpac) #check if package(passed text 2) installed 
		          #returns 1 or 0  and appends passed text 3
			x=$(pacman -Qqs "$2")
			if [ -n "$x" ]
			then 
				printf '%s\n' "$2 is Installed $3"
				return 0
			else 
				printf '%s\n' "${RED}$2 is Not installed${NORMAL} $3"
				return 1
			fi ;;
			
		checkNet) #checks network with gnu-netcat exists 
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
		*) printf '%s\n' "Error bad input to msgFunc" ;;
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
				msgFunc norm "Written by G.Lyons, Reports to  <glyons66@hotmail.com>"
				msgFunc norm "AUR package name = cylon, at aur.archlinux.org by glyons."
				msgFunc norm "Version=$(pacman -Qs cylon | head -1 | cut -c 7-20)"
				msgFunc norm "Cylon program location = $(which cylon)"
				msgFunc norm "Folder for Cylon output data = $Dest3"
				msgFunc norm "Location of cylonCfg.conf = $Dest5"
				msgFunc norm "Location of readme.md changlog.md = $Dest6"
				msgFunc norm "Location of License.md = /usr/share/licenses/cylon"
				msgFunc anykey "and check which optional dependencies are installed"
				msgFunc checkpac cower "AUR package"
				msgFunc checkpac gdrive "AUR package"
				msgFunc checkpac lostfiles "AUR package"
				msgFunc checkpac pacaur  "AUR package"
				msgFunc checkpac rmlint
				msgFunc checkpac rkhunter
				msgFunc checkpac gnu-netcat
				msgFunc checkpac clamav
				msgFunc checkpac bleachbit 
				msgFunc checkpac ccrypt
				msgFunc checkpac rsync
				msgFunc checkpac lynis
				msgFunc checkpac inxi
				msgFunc checkpac htop
				msgFunc checkpac wavemon
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
msgFunc norm "Operating System = $(uname -mo)"
msgFunc norm "Kernel = $(uname -sr)"
msgFunc norm "Network node name = $(uname -n)"
msgFunc norm "Shell = $SHELL"
msgFunc norm "Screen Resolution = $(xrandr |grep "\*" | cut -c 1-15)"
msgFunc norm "CPU $(grep name /proc/cpuinfo  | tail -1)"
mem=($(awk -F ':| kB' '/MemTotal|MemAvail/ {printf $2}' /proc/meminfo))
memused="$((mem[0] - mem[1]))"
memused="$((memused / 1024))"
memtotal="$((mem[0] / 1024))"
memory="${memused}MB / ${memtotal}MB"
msgFunc norm "RAM used/total = ($memory)"
msgFunc norm "Number of All installed  packages = $(pacman -Q | wc -l)"
msgFunc norm "Number of native, explicitly installed packages  = $(pacman -Qgen | wc -l)"
msgFunc norm "Number of foreign installed packages  = $(pacman -Qm | wc -l)"
 #check gnu-cat is installed
if ! msgFunc checkpac gnu-netcat "Accessing Network Database...."
then
	msgFunc red "Please install gnu-netcat for complete system information check"
	msgFunc anykey 
	return
fi
#check network connectivity if good get updates numbers from arch
msgFunc checkNet "archlinux.org"
msgFunc norm   "Number of Pacman updates ready...> "
msgFunc blue "$(checkupdates | wc -l)"
msgFunc checkNet  "aur.archlinux.org"
msgFunc norm "Number of updates for installed AUR packages ready ...>"
msgFunc blue "$(cower -u | wc -l)"
msgFunc anykey
#check if inxi package  installed
if ! msgFunc checkpac inxi
then
	msgFunc anykey 
	clear
return
fi
# inxi  - Command line system information script for console and IRC
msgFunc green "get output of inxi -Fxz"
inxi -Fixz >> inxioutput
inxi -Fixz 
msgFunc green "Done!"
msgFunc anykey
clear
} 


#FUNCTION HEADER
# NAME :            PacmanFunc
# DESCRIPTION :     Pacman package manager options
# PROCESS : See options array      
#NOTE gnu-netcat is neeeded for the first option.      
#CHANGES : rss news feed added in v2.2
function PacmanFunc 
{
			clear
		   #Pacman package manager options:
		   msgFunc line
		   msgFunc green "Pacman package manager. Number of packages installed = $(pacman -Q | wc -l) "
		   msgFunc line
		   msgFunc blue "Pacman package manager options:-"
			options=("Check network and then check for updates (no download)" "pacman -Syu Upgrade packages" \
			 "pacman -Si Display extensive information about a given package" "pacman -S Install Package" \
			 "pacman -Ss Search for packages in the database" \
			 "pacman -Rs Delete Package" "pacman -Qs Search for already installed packages" \
			 "pacman -Qi  Display extensive information for locally installed packages" "pacman -Ql  List all files owned by a given package." \
			 "paccache -r Prune older packages from cache"\
			 "Write installed package lists to files" "Remove all packages not required as dependencies (orphans)" \
			 "Back-up the local pacman database" "Arch Linux News Rss feed" "Return to main menu")
			select choicep in "${options[@]}"
			do
			case "$choicep" in
					"${options[0]}")
					msgFunc green "Pacman updates ready:-.... "
					#check gnu-netcat is installed
					
					if ! msgFunc checkpac gnu-netcat "Accessing Network Database...."
					then
						msgFunc anykey 
						return
					fi
					#check network connectivity if good get updates numbers from arch
						msgFunc checkNet "archlinux.org"
						msgFunc norm   "Number of Pacman updates ready...> $(checkupdates | wc -l)"
						checkupdates
					;;
					"${options[1]}") #update pacman
						msgFunc green "Update system with Pacman."
						sudo pacman -Syu
					;;
					"${options[2]}") #pacman -Si Display extensive information about a given package
						msgFunc green "Display information  for Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Si "$pacString"
					;;
					"${options[3]}") #pacman -S Install Package
						msgFunc green "Install package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        sudo pacman -S "$pacString"
					;;
					"${options[4]}")   #pacman -Ss Search Repos for Package
						msgFunc green "Search for packages in the database."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Ss "$pacString"
					;;
					"${options[5]}") #pacman -Rs Delete Package
						msgFunc green "Delete Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        sudo pacman -Rs "$pacString"
					;;
					"${options[6]}")   #pacman -Qs Search for already installed packages
						msgFunc green "Search for already installed packages."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Qs "$pacString"
					;;
					"${options[7]}") #pacman -Qi Display extensive information about a given package(local install)
						msgFunc green "Display information  for Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Qi "$pacString"
					;;
					"${options[8]}") #pacman -Ql  List all files owned by a given package.
						msgFunc green "List all files owned by a given package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Ql "$pacString"
					;;
					
					"${options[9]}")  msgFunc green  "Prune older packages from cache."
					#The paccache script, deletes all cached  package 
						#regardless of whether they're installed or not, 
						#except for the most recent 3, 
							sudo paccache -r
					;;
					"${options[10]}")msgFunc green "Writing installed package lists to files at :"
						msgFunc dir "-PKGINFO"
						#all packages 
						pacman -Q  > pkglistQ.txt
						#native, explicitly installed package
						pacman -Qqen > pkglistQgen.txt
						#foreign installed (AUR etc))
						pacman -Qm > pkglistQm.txt
					;;
					"${options[11]}")   #delete orphans
						msgFunc green "Delete orphans!"
						#Remove all packages not required as dependencies (orphans)
						sudo pacman -Rns "$(pacman -Qtdq)"
					;;
					
					"${options[12]}") #backup the pacman database
						msgFunc green "Back-up the pacman database to :"
						msgFunc dir "-BACKUPPACMAN"
						tar -v -cjf pacman_database.tar.bz2 /var/lib/pacman/local
					;;
					"${options[13]}") #Arch Linux News Rss feed
						msgFunc green "Arch Linux News Rss feed last 5 items"
						# Set N to be the number of latest news to fetch
						NEWS=$(echo -e $(curl --silent https://www.archlinux.org/feeds/news/  | awk ' NR == 1 {N = 4 ; while (N) {print;getline; if($0 ~ /<\/item>/) N=N-1} ; sub(/<\/item>.*/,"</item>") ;print}'))
						#  THE RSS PARSER Remove some tags 
						NEWS=$(echo -e "$NEWS" | \
						awk '{
						# uncomment to remove first line which is usually not a news item
						sub(/<lastBuildDate[^>]*>([^>]*>)/,"");sub(/<language[^>]*>([^>]*>)/,"");sub(/<title[^>]*>([^>]*>)/,"");sub(/<link[^>]*>([^>]*>)/,""); 
						while (sub(/<guid[^>]*>([^>]*>)/,"")); 
						while (sub(/<dc:creator[^>]*>([^>]*>)/,""));
						while (sub(/<description[^>]*>([^>]*>)/,"")); print }' | \
						sed -e ':a;N;$!ba;s/\n/ /g')
					    echo -e "$(echo -e "$NEWS" | \
						sed -e 's/&amp;/\&/g
						s/&lt;\|&#60;/</g
						s/&gt;\|&#62;/>/g
						s/<\/a>/£/g
						s/href\=\"/§/g
						s/<title>/\\n\\n :: \\e[01;31m/g; s/<\/title>/\\e[00m ::/g
						s/<link>/\\n [ \\e[01;36m/g; s/<\/link>/\\e[00m ]\\n/g
						s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
						s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
						s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
						s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
						s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
						s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
						s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
						s/<!\[CDATA\[\|\]\]>//g
						s/\|>\s*<//g
						s/ *<[^>]\+> */ /g
						s/[<>£§]//g')"    
						;;
						*)  #exit  
						msgFunc green "Done!"	
						return
						;;
			esac
			break
			done
			msgFunc green "Done!"	
			msgFunc anykey 
}
 
 #FUNCTION HEADER
# NAME :      pacaurFunc
# DESCRIPTION:use pacaur utility to mange AUR packages
# downloads, updates and searches
# PROCESS : 8 options, see options array 
#NOTES :    needs pacaur(AUR) installed  gnu-netcat is needed 1 option      
function pacaurFunc
{
	       #check if installed
            if ! msgFunc checkpac pacaur
				then
				msgFunc anykey 
				return
			fi
			clear
			#AUR warning
	         msgFunc red  " AUR WARNING: User Beware"	
	         cat <<-EOF
			 The Arch User Repository (AUR) is a community-driven repository for Arch users
			 Before installing packages or installing updates
			 Please read Arch linux wiki First and learn the AUR system.
			EOF
			msgFunc anykey
			clear
			msgFunc line
		    msgFunc green "AUR packages management by pacaur. Number of foreign packages installed = $(pacman -Qm | wc -l)"
		    msgFunc line
			msgFunc blue "Pacaur options:-"
			optionsP=("Search for package " "Display information for package"\
	         	"Check network and then check for updates (no download)"\
	         	 "Get updates for installed packages" "Download and install package"\
	         	 "Download files , build the package(no install)" "Download the package files only"\
	         	  "Delete pacaur cache( $HOME/.cache/pacaur/)" "Return")
	         	select choiceP in "${optionsP[@]}"
	         	do
				case "$choiceP" in  
					"${optionsP[0]}") #search
						msgFunc green "Search for package in AUR pacaur -s"
						msgFunc norm "Type a AUR package name:-"
					      read -r pacaurP		
						  pacaur -s "$pacaurP" || return
						  msgFunc anykey
					;;
					"${optionsP[1]}") #info
						msgFunc green "Display information for package in AUR pacaur -i"
						msgFunc norm "Type a AUR package name:-"
					      read -r pacaurP		
						  pacaur -i "$pacaurP" || return
						  msgFunc anykey
					;;
					"${optionsP[2]}")    #check updates
								msgFunc green  "Check network and then check for updates, pacaur -k"
								#check gnu-netcat is installed
								if ! msgFunc checkpac gnu-netcat "Accessing Network Database...."
								then
									msgFunc anykey 
									return
								fi
								#check network connectivity if good get updates numbers from arch
								msgFunc checkNet "aur.archlinux.org"
								msgFunc norm "Number of updates available for installed AUR packages :..."
								pacaur -k | wc -l
								pacaur -k
								msgFunc anykey
					;;
				   "${optionsP[3]}")  #check for updates cower and optional install 
					msgFunc green "Update AUR packages.  pacaur -u  "	
					 pacaur -u
					 msgFunc anykey
					;;
					"${optionsP[4]}")  #download build and install from AUR by pacaur
					      msgFunc green "Download package. pacaur -y"
						  msgFunc norm "Type a AUR package name:-"
					      read -r pacaurP		
						  pacaur -y "$pacaurP" || return
						  msgFunc anykey
					;;
					"${optionsP[5]}") #Clone build files and build target package
						msgFunc green "Clone build files and build target package in AUR. pacaur -m"
						msgFunc norm "Type a AUR package name:-"
					      read -r pacaurP		
						  pacaur -m "$pacaurP" || return
						  msgFunc anykey
					;;
					"${optionsP[6]}") #Clone the target(s) build files
						msgFunc green "Clone the package build files  in AUR. pacaur -d"
						msgFunc norm "Type a AUR package name:-"
					      read -r pacaurP		
						  pacaur -d "$pacaurP" || return
						  msgFunc anykey
					;;
					"${optionsP[7]}")  #delete pacaur cache
						rm -rvf "$HOME"/.cache/pacaur/*
					;;
					
					*)  #exit  
				     msgFunc green "Done!"	
					return
					;;
				esac
				break
				done
				msgFunc green "Done!"	
			
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
# NAME :           CowerFunc
# DESCRIPTION:use cower and makepkg utility to mange AUR packages
# downloads, updates and searches
# PROCESS : six options, see optionsC array 
#NOTES :    needs cower(AUR) installed  gnu-netcat is needed for option 5     
function CowerFunc
{
			 #check cower is installed
            if ! msgFunc checkpac cower
				then
				msgFunc anykey 
				return
			fi
			clear
	         #AUR warning
	         msgFunc red  " AUR WARNING: User Beware"	
	         cat <<-EOF
			 The Arch User Repository (AUR) is a community-driven repository for Arch users
			 Before installing packages or installing updates
			 Please read Arch linux wiki First and learn the AUR system.
			EOF
			msgFunc anykey
			clear
			msgFunc line
		   msgFunc green "AUR packages management by cower. Number of foreign packages installed = $(pacman -Qm | wc -l)"
		   msgFunc line
	        msgFunc blue "AUR package install and updates by cower, options:-"
         	optionsC=("Information for package" "Search for package" \
         	"Download package" "Get updates for installed packages" \
         	"Check network and then check for updates (no download)" "Return")
         	select choiceCower in "${optionsC[@]}"
			do
			case "$choiceCower" in    
						#search AUR with cower with optional install
						"${optionsC[0]}")msgFunc green "${GREEN}Information for AUR package , cower -i"
						  msgFunc norm "Type a AUR package name:-"
					      read -r cowerPac		
						  msgFunc norm " " 
						  cower -i -c "$cowerPac" 
						  msgFunc anykey
						    ;;
						   
						  "${optionsC[1]}") msgFunc green "${GREEN}Search for AUR package, cower -s"
						  #cower -s 
						  msgFunc norm "Type a AUR package name:-"
					      read -r cowerPac		
						  msgFunc norm " " 
						  cower -s -c "$cowerPac" 
						  msgFunc anykey
						  ;;
						  
						"${optionsC[2]}")#cower -d Download AUR package with an optional install
							msgFunc green "${GREEN}Download AUR package cower -d with an optional install"
							msgFunc dir "-AURDOWNLOAD"
							#build and install packages
							msgFunc norm "Type a AUR package name:-"
							read -r cowerPac		
							cower -d -c	 "$cowerPac" || return
							cd "$cowerPac" || return
							msgFunc green "$cowerPac PKGBUILD: Please read"
							cat PKGBUILD
							msgFunc green "PKGBUILDS displayed above. Install  [Y/n]"
							read -r choiceIU3
							if [ "$choiceIU3" != "n" ]
								then
									msgFunc norm  "Installing package $cowerPac"
									makepkg -si		
							fi
						 ;;
						
						#check for updates cower and optional install 
						"${optionsC[3]}")msgFunc green "Update AUR packages  cower -du  "		
						#make cower update directory
						msgFunc dir "-AURUPDATES" 
						cower -d -vuc || return
						# look for empty dir (i.e. if no updates) 
						if [ "$(ls -A .)" ] 
						then
							msgFunc norm  "Package builds available"
							ls 
							msgFunc norm " "
						    msgFunc green "Press any key to View package builds or n to quit"
							read -r choiceIU2
								if [ "$choiceIU2" != "n" ]
									then
									msgFunc green " Viewing  PKGBUILDS of updates :-" 
									#cat PKGBUILDs to screen
									find . -name PKGBUILD -exec cat {} \; | more
									msgFunc anykey
									msgFunc line
									msgFunc green "PKGBUILDS displayed above. Install all [Y/n]"  
									read -r choiceIU1
									if [ "$choiceIU1" != "n" ]
										then
											#build and install all donwloaded PKGBUILD files 
											msgFunc norm  "Installing packages"
											find . -name PKGBUILD -execdir makepkg -si \;
									fi			
								fi	
						  else
							msgFunc norm "No updates found for installed AUR packages by Cower."
						  fi	
						;;
						
						 "${optionsC[4]}") #check for updates 
								msgFunc green  "Check network and then check for updates"
								#check gnu-netcat is installed
								if ! msgFunc checkpac gnu-netcat
								then
									msgFunc anykey 
									return
								fi
								#check network connectivity if good get updates numbers from arch
								msgFunc checkNet "aur.archlinux.org"
								msgFunc norm "Number of updates available for installed AUR packages :..."
								cower -u | wc -l
								cower -uc
								msgFunc anykey
						  ;;
						 
						 *)  #exit to main menu 
							return
						 ;;
				 esac
				 break
				 done
			     msgFunc green "Done!"
}

#FUNCTION HEADER
# NAME :           networkFunc
# DESCRIPTION: provides network utuiles and commands 
# OUTPUTS : no output or inputs
# PROCESS : 5 options see options array
#NOTES :   new in version 3.0-1
function networkFunc
{
	clear        
	 #change dir for log files
	 msgFunc dir "-NETINFO"
     msgFunc norm "Files report will be written to path above -"
	msgFunc blue "Network. options:-"
				optionsN=("Wavemon - wireless network monitor" "Speedtest-cli testing internet bandwidth" \
	         	"Check if website up with netcat and ping" "ip addr" "netstat -r & route" "Return")
	         	select choiceN in "${optionsN[@]}"
	         	do
				case "$choiceN" in  
				
					"${optionsN[0]}") #wavemon - wireless network monitor"
				     #check wavemon is installed
					if ! msgFunc checkpac wavemon 
					then
						msgFunc anykey 
					return
					fi
					msgFunc green "Opening wavemon"
				    xterm -e "wavemon" &  
					;;
					
					"${optionsN[1]}")  #speedtest-cli testing internet bandwidth
					   #check speedtest-cli  is installed
					if ! msgFunc checkpac speedtest-cli
					then
						msgFunc anykey 
					return
					fi
					msgFunc green "Speedtest-cli"
					 msgFunc norm "Do you want to generate server list [y/N]"
									read -r choiceST
									if [ "$choiceST" = "y" ]
									then
											msgFunc green "List speedtest.net servers sorteby distance sent to file, cat top 20"
											speedtest-cli --list > stclilist
											head -n20 stclilist 
									fi		
					 msgFunc norm "Do you want to specify a server ID [y/N]"
									read -r choiceST
									if [ "$choiceST" = "y" ]
										then
											msgFunc norm "Enter Server ID from list"
											read -r SERVERID
											clear
											speedtest-cli --server "$SERVERID" | tee stclilog
											return
									fi		
					 clear
					 msgFunc green "Running Speedtest-cli "
					 speedtest-cli  | tee stclilog
					;;
					
					"${optionsN[2]}")  #netcat 
					msgFunc green "Check if website up with netcat "
					msgFunc norm "Enter website"
					read -r WEBSITE
					msgFunc checkNet "$WEBSITE"
					ping -c 10 "$WEBSITE"

					;;
				   "${optionsN[3]}")  #ip a
				     ip a | tee ifconfiglog
					;;
					 "${optionsN[4]}")  #netstat  andview route table
				     netstat -r 
				     route
					;;
					*)  #exit  
				     msgFunc green "Done!"	
					return
					;;
				esac
				break
				done
				msgFunc green "Done!"	
}

#FUNCTION HEADER
# NAME :           SystemMaintFunc
# DESCRIPTION:carries out 6 maintenance checks  
# OUTPUTS : various output files 
# PROCESS : systemd , SSD trim , broken syslinks ,journalcontrol errors
#lostfiles check with lostfiles package, systemdanalysis boot, 
#NOTES :    needs lostfiles (AUR)  installed       
function SystemMaintFunc
{
	        clear        
	        #change dir for log files
	        msgFunc dir "-SYSINFO"
			msgFunc norm "Files report will be written to path above -"
	        # -systemd --failed:
			msgFunc green "All Failed Systemd Services"
			systemctl --failed --all
			systemctl --failed --all > Systemderrlog
			msgFunc green "Done!"
			msgFunc green "All Failed Active Systemd Services"
			systemctl --failed
			systemctl --failed >> Systemderrlog
			msgFunc green "Done!"
			# -Logfiles:
			msgFunc green "Check log Journalctl for Errors"
			journalctl -p 3 -xb > Journalctlerrlog
			msgFunc green "Done!"
			
			#check if ssd trim functioning  ok in log
			#am I on a sdd drive? , 0 for SDD 1 for HDD from command
			SDX="$(df /boot/ --output=source | tail -1 | cut -c 6-8)"
			SDX=$(grep 0 /sys/block/"$SDX"/queue/rotational) 
			if [ "$SDX" = "0" ] 
				then
				msgFunc green "Check Journalctl for fstrim SSD trim"
				echo "SSD trim" > JournalctlerrSDDlog
				journalctl -u fstrim > JournalctlerrSDDlog
				msgFunc green "Done!"
				else 
				msgFunc red "HDD detected no SSD trim check done"
			fi
			
			# systemd-analyze - Analyze system boot-up performance
			msgFunc green "Analyze system boot-up performance"
            {
            echo "Analyze boot-up performance"  
            systemd-analyze time 
            echo "CRITICAL-CHAIN" 
            systemd-analyze critical-chain 
            echo "BLAME" 
            systemd-analyze blame 
		     } >>  systemdanalyzelog
		     
			msgFunc green "Done!"
			
			# Checking for broken symlinks:
			msgFunc green "Checking for Broken Symlinks"
            find / -path /proc -prune -o -type l -! -exec test -e {} \; -print 2>/dev/null > symlinkerr
            #version pre-2.1 just for home
            #find "$HOME" -type l -! -exec test -e {} \; -print > symlinkerr
			msgFunc green "Done!"
			
			msgFunc green "Find files where no group or User corresponds to file's numeric user/group ID."
			find / -nogroup > filenogrouplog 2> /dev/null
			find / -nouser  > filenouserlog  2> /dev/null
			msgFunc green "Done!"
			
			#check if lostfiles package (AUR) installed
		    if ! msgFunc checkpac lostfiles
			then
				msgFunc anykey 
			return
			fi
			msgFunc green "Lostfiles :-Search for files which are not part of installed Arch Linux packages"
			msgFunc norm  "Lostfiles strict scan running, outputing to file"
			sudo bash -c "lostfiles strict  > lostfilesStrictlist.txt" 
			msgFunc green "Done!"
			msgFunc norm  "Lostfiles relaxed scan running, outputing to file"
		    sudo bash -c  "lostfiles relaxed > lostfilesRelaxedlist.txt" 
			msgFunc green "Done!"

}
#FUNCTION HEADER
# NAME :          SystemBackFunc
# DESCRIPTION:carries out Full system backup + gdrive sync 
#to google drive
# INPUTS:  configfile from readconfigFunc   
# OUTPUTS : backups see OptionsB2 array
# PROCESS : system backup(5 options) + option to call gdriveFunc  +rsync option
#NOTES :    needs rsync installed if using rsync option
#
function SystemBackFunc
{
			#get paths from config file if exists
			clear
			readconfigFunc
			#get user input for backup
			optionsB1=("$Destination1" "$Destination2" "$Dest3" \
			"Custom" "gdrive" "rsync" "Return")
			#variable to be passed to msgFunc dir : custom path
			local D3=""
			msgFunc blue "Pick destination directory for system backup or gdrive option"
			select  choiceBack in "${optionsB1[@]}"
			#check that paths exist and change path to dest path
			do
			case "$choiceBack" in
			
			"${optionsB1[0]}")  cd "$Destination1" || exitHandlerFunc dest1 
											D3="1";;				
			"${optionsB1[1]}")  cd "$Destination2"   || exitHandlerFunc dest2 
											D3="1";;
			"${optionsB1[2]}")  cd "$Dest3" || exitHandlerFunc dest3;;
			"${optionsB1[3]}")  #custom path read in 
						msgFunc norm "Type a custom destination path:-"
						read -r Path1		
						cd "$Path1" || exitHandlerFunc dest4 
						D3="1"
						;;
			"${optionsB1[4]}")   #gdrive function
					gdriveFunc
					return
					;;
			"${optionsB1[5]}") 
					msgFunc green "rsync backup utility"
					#check rsync is installed
					
					if ! msgFunc checkpac rsync 
					then
						msgFunc anykey 
					return
					fi
					msgFunc norm "Source: $rsyncsource"
					msgFunc norm "Destination: $rsyncDest"
					msgFunc anykey
					rsync -av --delete "$rsyncsource" "$rsyncDest" 
					msgFunc green "Done!"
					msgFunc anykey
					return ;;	
			*) return ;;
			esac
			break
			done
			
			#make the backup directory
			msgFunc dir "-BACKUP" "$D3"
			#begin the backup get user choice from user to what to back up
			optionsB2=("Copy of 1st 512 bytes MBR" "Copy of etc dir" \
"Copy of home dir" "Copy of package lists" "Make tarball of all" "ALL" "Return")
			msgFunc blue "Pick a Backup option:-"
			select  choiceBack2 in "${optionsB2[@]}"
			do
			case  "$choiceBack2" in
			"${optionsB2[0]}"|"${optionsB2[5]}") #MBR
				msgFunc green "Make copy of first 512 bytes MBR with dd"
				#get /dev/sdxy where currenty filesystem is mounted 
				myddpath="$(df /boot/ --output=source | tail -1)"
				msgFunc norm "$myddpath"
				sudo dd if="$myddpath" of=hda-mbr.bin bs=512 count=1
				msgFunc green "Done!"
            ;;&
			"${optionsB2[1]}"|"${optionsB2[5]}")#etc
				msgFunc green "Make a copy of etc dir"
				sudo cp -a -v -u /etc .
				msgFunc green "Done!"
            ;;&
            "${optionsB2[2]}"|"${optionsB2[5]}")#home
				msgFunc green "Make a copy of home dir"
				sudo cp -a -v -u /home .
				msgFunc green "Done!"
				sync
			;;&
			"${optionsB2[3]}"|"${optionsB2[5]}")#packages
				msgFunc green "Make copy of package lists"
				pacman -Qqen > pkglistQgenNAT.txt
				pacman -Qm > pkglistQmAUR.txt
				pacman -Q  > pkglistQALL.txt
				msgFunc green "Done!"
            ;;&
            "${optionsB2[4]}"|"${optionsB2[5]}")#tar
				msgFunc green "Make tarball of all except tmp dev proc sys run"
				sudo tar --one-file-system --exclude=/tmp/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/run/* -pzcvf RootFS_backup.tar.gz /
				msgFunc green "Done!"
				sync 
				;;&
			  *)#quit
				msgFunc green "ALL Done!"
				return
				;;
			esac
			break 
			done
}
#FUNCTION HEADER
# NAME :         gdriveFunc
# DESCRIPTION:gdrive sync to google drive
# INPUTS:  configfile from readconfigFunc   
# PROCESS : 6 syncs to google drive + provides information and search 
#NOTES :    needs gdrive and gnu-netcat installed 
function gdriveFunc
{
clear
msgFunc green "gdrive, connect to google drive via the terminal" 
#check gnu-cat is installed

if ! msgFunc checkpac gnu-netcat "Accessing Network ...."
then
	msgFunc red "Please install gnu-netcat for gdrive function to work"
	msgFunc anykey 
return
fi
#check net up

 #check gdrive is installed
if ! msgFunc checkNet "google.com"
then
	msgFunc anykey 
return
fi
gdrive version
msgFunc blue "gdrive options"
optionsGD=("List all syncable directories on drive" "Sync local directory to google drive (path 1)" \
"Sync local directory to google drive (path 2)" "List content of syncable directory" "Google drive metadata, quota usage"
 "List files" "Get file info" \
  "Return")
			select  choiceGD in "${optionsGD[@]}"
			do
			case "$choiceGD" in
			 "${optionsGD[0]}")#List all syncable directories on drive
			     msgFunc green "gdrive List all syncable directories on drive"
				 gdrive sync list
			   ;;
			  "${optionsGD[1]}")#Sync upload to remote directory  path 1
				msgFunc green "gdrive sync with remote directory path 1:-"
				msgFunc norm "Source: $gdriveSource1"
				msgFunc norm "Destination: $gdriveDest1"
				msgFunc anykey
				gdrive sync upload "$gdriveSource1" "$gdriveDest1"
			   ;;
			   "${optionsGD[2]}")#Sync upload to remote directory  path 2
			     msgFunc green "gdrive sync with remote directory path 2:-"
			    msgFunc norm "Source: $gdriveSource2"
				msgFunc norm "Destination: $gdriveDest2"
				msgFunc anykey
				gdrive sync upload  "$gdriveSource2" "$gdriveDest2"
			   ;;
			    "${optionsGD[3]}")#List content of syncable directory
					msgFunc dir "-SYNCINFO"
					msgFunc green "List content of syncable directory (output to file)"
					msgFunc norm "Enter fileId:-"
					read -r  FID
					gdrive sync content "$FID" > Syncinfo
			    ;;
			    "${optionsGD[4]}")#gdrive about
					msgFunc green "Google drive metadata, quota usage"
					gdrive about
			   ;;
			     "${optionsGD[5]}")#gdrive list files
					msgFunc green "List files "
					msgFunc norm "Enter Max files to list, Just press enter for all:-"
					read -r  num
					msgFunc norm "Enter Query (see https://developers.google.com/drive/search-parameters)"
					msgFunc norm "Common Example: name contains 'foo' "
					msgFunc norm "Just press enter to to leave Query blank :-"
					read -r  quy
					msgFunc norm "Enter Order (see https://godoc.org/google.golang.org/api/drive/v3#FilesListCall.OrderBy)"
					msgFunc norm "Common Example: quotaBytesUsed desc "
					msgFunc norm "Just press enter to to leave order blank :-"
					read -r  order
					msgFunc norm "Output to file? [Y/n] :-"
					read -r CHOICE
						if [ "$CHOICE" != "n" ]
							then
								# output to file
								msgFunc dir "-LISTINFO"
								gdrive list  -q "$quy" --order "$order" -m "$num" > Listinfo
							else #output to screen 
								gdrive list  -q "$quy" --order "$order" -m "$num" 
						fi
					;;
				"${optionsGD[6]}")# get file info
					msgFunc green "get file info"
					msgFunc norm "Enter fileId:-"
					read -r  ID
					gdrive info "$ID"
				      ;;
				*)return  ;;
			esac
			break 
			done
			 msgFunc green "Done!"
			 msgFunc anykey
			 clear	
}
#FUNCTION HEADER
# NAME :  AntiMalwareFunc 
# DESCRIPTION: Function for ROOTKIT HUNTER software
#anti virus with clamscan and lynis security audit
# INPUTS:  $1  CLAMAV or "RKHUNTER" or lynis
# PROCESS : clamav and rkhunter full scans
#NOTES :    needs clamav,lynis and rkhunter installed  
function AntiMalwareFunc
{
#clamav section
	if [ "$1" = "CLAMAV" ]
				then
            #check clamav is installed
            
            if ! msgFunc checkpac clamav
				then
				msgFunc anykey 
				return
			fi
			# update clamscan virus definitions:
			msgFunc green "Updating clamavscan Databases"
			sudo freshclam
			msgFunc green "Done!"
			msgFunc green "Scanning with Clamav$"
			# scan entire system
			msgFunc dir "-CLAMAVINFO"
			sudo clamscan -l clamavlogfile --recursive=yes --infected --exclude-dir='^/sys|^/proc|^/dev|^/lib|^/bin|^/sbin' /
			msgFunc green "Done!"			
			return
	fi
			
#Rootkitsection
	if [ "$1" = "RKHUNTER" ]
	then
		#check rkhunter is installed
		
		if ! msgFunc checkpac rkhunter
		then
			msgFunc anykey 
		return
		fi
		msgFunc green "Checking rkhunter data files"
		sudo rkhunter --update
		msgFunc green "Done!"
		msgFunc green "Fill the file properties database"
		sudo rkhunter --propupd
		msgFunc green "Done!"
		msgFunc green "Running Rootkit hunter"
		sudo rkhunter --check
		msgFunc green "Done!"
		msgFunc anykey
		return
	fi
	
#lynis section
	if [ "$1" = "LYNIS" ]
	then
		#check lynis is installed
		if ! msgFunc checkpac lynis
		then
			msgFunc anykey 
		return
		fi
		msgFunc green "Lynis - System and security auditing tool"
		 sudo  lynis audit system
		 msgFunc norm "Entire logfile at /var/log/lynis.log"
		 msgFunc norm  "Summary of logfile at:-"
		 msgFunc dir "-LYNISINFO"
		 {
		 echo "Warnings" 
		 sudo grep Warning /var/log/lynis.log 
		 echo "Suggestions" 
		 sudo grep Suggestion /var/log/lynis.log  
		 } >> lynisinfo
		msgFunc anykey
		msgFunc green "Done!"
	fi
	
}

#FUNCTION HEADER
# NAME :            ccryptFunc
# DESCRIPTION :      function to use ccrpyt encrypt and decrypt files
# PROCESS :[1]   Encrypt. a file [2] decrypt  
# [3]   view a encrypted file                 
# [4]   view a decrypted file [5]  keychange
#NOTES :   needs ccrypt  installed 
function ccryptFunc
{
	clear
	msgFunc blue "ccrypt - encrypt and decrypt files:-"
	#check if ccrypt installed
    if ! msgFunc checkpac ccrypt
	then
		msgFunc anykey 
	return
	fi
	msgFunc norm "Type a path to the folder you want to work with:-"
	read -r myccfile
	cd "$myccfile" || exitHandlerFunc dest4
	ls -la
	msgFunc norm "Type the file name  you want to work with:-"
	read -r myccfile
	 if [ -f "$myccfile"  ] 
	 then 
		msgFunc norm 'Found file!' 
	 else
		msgFunc red 'File out found!'
		exitHandlerFunc exitout
	 fi
	 msgFunc blue "ccrypt - encrypt and decrypt files Menu options:-"
	optionscc=("Encrypt a file " "Decrypt a file" "View encrypted file" \
"Edit decrypted file with NANO" "Change the key of encrypted file" "Return")
			select choicecc in "${optionscc[@]}"
			do
			case "$choicecc" in 
			 "${optionscc[0]}") #Encrypt.
			   msgFunc green "Decrypt  a files to standard output., ccrypt -e"
				ccrypt -e "$myccfile"
			 ;;
			 "${optionscc[1]}") #Decrypt
			 msgFunc green "Decrypt  a files to standard output., ccrypt -d"
			   ccrypt -d "$myccfile"
			 ;;
			 "${optionscc[2]}") #Decrypt  files to standard output.
				msgFunc green "Decrypt  file to standard output., ccrypt -c"
				 ccrypt -c "$myccfile"
			 ;;
			 "${optionscc[3]}") #Edit a Decrypted file
			    msgFunc green "Edit a Decrypted file with nano text editor, nano"
				nano "$myccfile"
			 ;;
			 "${optionscc[4]}") #Change the key of encrypted data
				msgFunc green "Change the key of encrypted file, ccrypt -x"
				ccrypt -x "$myccfile"
			 ;;
			 *)  #exit  
				     msgFunc green "Done!"	
				     msgFunc anykey
				     clear
					return
					;;
			esac
			break
			done
			msgFunc green "Done!"
}

#FUNCTION HEADER
# NAME :  SystemCleanFunc 
# DESCRIPTION: Function for cleaning programs files and system  
# with bleachbit also deletes trash can and download folder.
# INPUTS : $1 FOLDERS option 
# PROCESS : 16 see optionsbb array.
#NOTES :    needs bleachit installed
#CHANGES: added new options version 2.3.2
function SystemCleanFunc
{
		     #check bleachbit is installed
			
			if ! msgFunc checkpac bleachbit 
			then
				msgFunc anykey 
			return
			fi
			clear
			#check $1, Called with  FOLDERS input option?
			#delete folders and shred with bleachbit options
			if [ "$1" = "FOLDERS" ]
			then
				msgFunc blue "Delete files/folders. options:-"
				optionsF=("Shred specific files or folders with bleachbit" "Delete Trash folder" \
	         	"Delete Download folder" "Delete Cylon output folder ($HOME/Documents/Cylon/)" "Return")
	         	select choiceF in "${optionsF[@]}"
	         	do
				case "$choiceF" in  
					"${optionsF[0]}")
				    msgFunc green "Shred specific files or folders"
					msgFunc red "Enter path of file or folder to shred:"
					read -r  mydelpath
					bleachbit -s "$mydelpath" || exitHandlerFunc exitout
					;;
					"${optionsF[1]}")  msgFunc green "Deleting Trash folder "
						 rm -rvf "$HOME"/.local/share/Trash/*
					;;
					"${optionsF[2]}")  msgFunc green "Deleting Download folder "
						 rm -rvf "$HOME"/Downloads/*
					;;
				   "${optionsF[3]}")  msgFunc green "Deleting Cylon output folder ($HOME/Documents/Cylon/)"
				   		rm -rvf "$HOME"/Documents/Cylon/*
					;;
					*)  #exit  
				     msgFunc green "Done!"	
					return
					;;
				esac
				break
				done
				msgFunc green "Done!"	
			return
			fi
			
			#system clean with bleachbit (if this function called without "FOLDERS" input)
			#query for preset option or custom?
			msgFunc green "Bleachbit system clean. Use the options set in the GUI? [y/N]"  
			msgFunc norm "For Preset options see $HOME/.config/bleachbit/ or GUI "
									read -r choiceBBBB
									if [ "$choiceBBBB" = "y" ]
										then
											#use options set in the graphical interface 
											msgFunc norm  "Running bleachbit -c --preset"
											bleachbit -c --preset
											return
									fi		
		  
					#custom bleachbit -c cleaner.option
				    #get cleaner list and put it in array
				    msgFunc green "Scanning bleachbit cleaners:"
					myarray=$(bleachbit --list | awk -F"." '{ print $1 }' | sort -u)
					#Sort array
					IFS=$'\n' myarraysorted=($(sort <<<"${myarray[*]}"))
					unset IFS
					# get length of an array
					tLen="${#myarraysorted[@]}"
					# use for loop read all installed packages exception for deepscan
					for (( i=0; i<"${tLen}"; i++ ));
					do
					  if [ "${myarraysorted[i]}" != "deepscan" ]
					  then 
							  
							  if ! msgFunc checkpac "${myarraysorted[i]}"
								then
									unset "myarraysorted[i]"
								fi
						fi
					done
					msgFunc anykey
					msgFunc green "Done!"	
					clear
					 msgFunc blue "System clean with Bleachbit, Select Cleaner :-"
					#get cleaner input from user
					select cleaner in "${myarraysorted[@]}"
					do
					    #get list of options for selected cleaner and put in array
					    myarray2=$(bleachbit --list | awk -F"."  ''/"${cleaner}"/' {print $2}')
						break
					done
					#check for valid selection
					if [ "$cleaner" =  ""  ]
					then
						return
					fi
					IFS=$'\n' myarraysorted2=($(sort <<<"${myarray2[*]}"))
					unset IFS
					myarraysorted2+=('*')
					#get options from user
					msgFunc blue  "Select option(* is all):-"
					#msgFunc blue  "Options"
					select options in "${myarraysorted2[@]}"
					do
						if [ "$options" =  ""  ]
							then
							return
						fi
						msgFunc norm " "
						msgFunc green "You have selected ${cleaner}.${options}"
						msgFunc anykey 
					break
					done
					#give user 4 options - preview ,clean ,clean and overwrite ,quit
					msgFunc blue "Pick a Bleachbit option (see readme for more details)"
					select choiceBBB in "Preview only" "Overwrite & delete" "Delete" "Return"
						do
						case "$choiceBBB" in
						"Preview only" )bleachbit -p "${cleaner}.${options}"
						;;
						"Overwrite & delete")
							if [ "$cleaner" = "system" ]
								then
								sudo bleachbit -oc "${cleaner}.${options}"
								else
								bleachbit  -oc "${cleaner}.${options}"
							fi
						;;
						"Delete")if [ "$cleaner" = "system" ]
								then
								sudo bleachbit  -c "${cleaner}.${options}"
								else
								bleachbit  -c "${cleaner}.${options}"
							fi
						  ;;
						  *)
						  return
						  ;;
						esac
						break
						done
					 msgFunc anykey
					 msgFunc green "Done!"	
}

#FUNCTION HEADER
# NAME :  RmLintFunc 
# DESCRIPTION: Function for crmlint - 
#find duplicate files and other space waste efficiently
# PROCESS : rmlint scan 
#NOTES :    needs rmlint installed
function RmLintFunc
{
	clear
	msgFunc green "Running rmlint"
cat <<-EOF
rmlint finds space waste and other broken things on your filesystem.
It then produces a report and a shellscript called rmlint.sh that 
contains readily prepared shell commands to remove duplicates and other 
finds. cylon wrapper  will scan, then optionally show report and then  
optionally execute the rmlint.sh.
EOF
	     #check crmlint is installed
            
            if ! msgFunc checkpac rmlint
				then
				msgFunc anykey 
				return
			fi
			msgFunc line
			msgFunc norm "Type a  directory path you wish to scan:-"
			read -r rmlintPath	            
		     cd "$rmlintPath" || exitHandlerFunc dest4
			msgFunc norm " "
			msgFunc green "Press g for progress bar any other key for list [g/L]"
			read -r choicermlint
			if [ "$choicermlint" = "g" ]
				then
					# run with progress bar 
					rmlint -g
				else
					rmlint
			fi
			msgFunc line
			msgFunc anykey
			#display the results file option? 
			msgFunc green "Display results file? press Any key or n to quit [Y/n]"
			read -r choicermlint1
			if [ "$choicermlint1" != "n" ]
			then
				msgFunc green  "rmlint output file"
				more rmlint.json		
				msgFunc line
				msgFunc anykey
				#run the shell option?
				msgFunc green "Execute rmlint.sh file? press e or any key to quit [e/N]"
				msgFunc red "Warning rmlint.sh will change your system based on results of the previous scan"
			    read -r choicermlint2
					if [ "$choicermlint2" = "e" ]
					then
						msgFunc green  "running rmlint.sh output file"
						./rmlint.sh -d
					else
						msgFunc green "Done!"
						return
					fi
			else
				msgFunc green "Done!"
				return
			fi
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
	        exitout) msgFunc norm " " ;;
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
	msgFunc blue "GOODBYE $USER!!"
	msgFunc anykey "and exit."
	exit
}
#==================END OF FUNCTIONS SPACE==============================
#======================================================================
#==================MAIN CODE HEADER====================================

#check Options from linux command line arguments passed to program on call
#-v display version and exit
#-s display system info and exit
#-help display cylon info and exit 
case "$1" in
  -v|--version)
    msgFunc norm "$(pacman -Qs cylon)" 
    exit 0
    ;;
  -s|--system)
    HelpFunc 
    exit 0
    ;;
  -help|-h|--help)
    HelpFunc HELP
    exit 0
    ;;
  *)
    clear
    ;;
esac
#print horizontal line  + Title
msgFunc line
msgFunc green "********* $(pacman -Qs cylon | head -1 | cut -c 7-20) (CYbernetic LifefOrm Node) *********" 
msgFunc line
msgFunc norm
#Program details print
cat <<-EOF
Cylon is an Arch Linux maintenance CLI program written in Bash script.
This program provides numerous tools to Arch Linux users to carry 
out updates, maintenance, system checks, backups and more. 
EOF
date +%A-Week%U-%d-%B-%Y--%T
msgFunc norm " " 
#main program loop    
while true; do
	cd ~ || exitHandlerFunc dest4
    msgFunc blue "Cylon Main Menu :-"
	optionsM=("Pacman options" "Cower  options (AUR)" "Pacaur options (AUR)" "System check"\
	 "System backup" "System clean" "System information " "Rmlint scan"\
	  "Clamav scan" "RootKit hunter scan" "Lynis system audit" "Ccrypt utility"\
	  "Password generator" "Delete files/folders"\
	  "Open xterm (terminal)" "htop - interactive process viewer"\
	   "Weather" "Network" "Display Cylon information" "Exit")
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
		"${optionsM[6]}") #system info
		   HelpFunc "SYS"
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
		"${optionsM[11]}")  # ccrypt - encrypt and decrypt files 
			ccryptFunc
			 ;;
		"${optionsM[12]}")  # password generator 
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
		  "${optionsM[13]}")  # delete folders /files
			SystemCleanFunc "FOLDERS"
			;;
		
		"${optionsM[14]}")  # open a terminal
			xterm &
			msgFunc anykey
		;;
		"${optionsM[15]}")  # htop - interactive process viewer
			xterm -e "htop" &  
			msgFunc anykey
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
		"${optionsM[17]}")  # network utiltes
			networkFunc
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

