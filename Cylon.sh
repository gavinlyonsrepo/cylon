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



function PacmanFunc 
{
	clear
		   #Pacman package manager options:
		   msgFunc line
		   msgFunc green "Pacman package manager. Number of packages installed = $(pacman -Q | wc -l) "
		   msgFunc line
		   msgFunc blue "Pacman package manager options:-"
			cat <<-EOF
			(1)     Check for updates (no download)
			(2)     pacman -Syu Upgrade packages
			(3)     pacman -Si Display extensive information about a given package
			(4)     pacman -S Install Package
			(5)     pacman -Ss Search for packages in the database
			(6)     pacman -Rs Delete Package
			(7)     pacman -Qs Search for already installed packages
			(8)     pacman -Qi  Display extensive information for locally installed packages
			(9)     paccache -r Prune older packages from cache
			(0) 	Write installed package lists to files
			(a)     Remove all packages not required as dependencies (orphans)
			(b) 	Back-up the local pacman database  
			(*) 	return to main menu
			EOF
			msgFunc blue "Press option number followed by [ENTER]"
			read -r choicep
			case "$choicep" in
					1)
					msgFunc norm "Pacman updates ready:-.... "
						
						checkupdates | wc -l
						checkupdates
					;;
					
					2) #update pacman
						msgFunc green "Update system with Pacman."
						sudo pacman -Syu
					;;
					
					3) #pacman -Si Display extensive information about a given package
						msgFunc green "Display information  for Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Si "$pacString"
					;;
					
					
					4) #pacman -S Install Package
						msgFunc green "Install package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        sudo pacman -S "$pacString"
					;;
					
					5)   #pacman -Ss Search Repos for Package
						msgFunc green "Search for packages in the database."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Ss "$pacString"
					;;
					6) #pacman -Rs Delete Package
						msgFunc green "Delete Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        sudo pacman -Rs "$pacString"
					;;
					
					7)   #pacman -Qs Search for already installed packages
						msgFunc green "Search for already installed packages."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Qs "$pacString"
					;;
					
					8) #pacman -Qi Display extensive information about a given package(local install)
						msgFunc green "Display information  for Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Qi "$pacString"
					;;
					
					
					9)  msgFunc green  "Prune older packages from cache."
					#The paccache script, deletes all cached  package 
						#regardless of whether they're installed or not, 
						#except for the most recent 3, 
							sudo paccache -r
					;;
					
					0)msgFunc green "Writing installed package lists to files at :"
						cd "$Dest3" || exitHandlerFunc dest3
						msgFunc dir "-INFO"
						#all packages 
						pacman -Q  > pkglistQ.txt
						#native, explicitly installed package
						pacman -Qqen > pkglistQgen.txt
						#foreign installed (AUR etc))
						pacman -Qm > pkglistQm.txt
					;;
					
					a)   #delete orphans
						msgFunc green "Delete orphans!"
						#Remove all packages not required as dependencies (orphans)
						sudo pacman -Rns "$(pacman -Qtdq)"
					;;

					b) #backup the pacman database
						msgFunc green "Back-up the pacman database to :"
						cd "$Dest3" || exitHandlerFunc dest3
						msgFunc dir "-BACKUPPACMAN"
						tar -v -cjf pacman_database.tar.bz2 /var/lib/pacman/local
					;;
					
					*)  #exit  
				    msgFunc green "Done!"	
					return
					;;
			esac
			msgFunc green "Done!"	
			msgFunc anykey 
}

#function LF uses lostfiles package from AUR 
#Search for files which are not part of installed Arch Linux packages
function lfFunc
{
	clear
	msgFunc line
	msgFunc green "Lostfiles :-Search for files which are not part of installed Arch Linux packages"
	cd "$Dest3" || exitHandlerFunc dest3
	msgFunc dir "-INFO"
	cat <<-EOF
	Do you wish Use strict or relaxed mode?
	s) Strict
	r) Relaxed
	*) return
	Press option number followed by [ENTER]
	EOF
	read -r choiceIU4
	if [ "$choiceIU4" = "s" ]
	then
			sudo bash -c "lostfiles strict  > lostfilesStrictlist.txt" 
	elif [ "$choiceIU4" = "r" ]
	then
			sudo bash -c  "lostfiles relaxed > lostfilesRelaxedlist.txt" 
	fi
	msgFunc green "Done!"
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

function CowerFunc
{
			clear
	         #AUR warning
	         msgFunc red  "AUR WARNING: User Beware"	
	         cat <<-EOF
			 The Arch User Repository (AUR) is a community-driven repository for Arch users
			 It is possible for a package to contain dangerous commands through malice 
			 or ignorance. Before installing packages or installing updates
			 Please Read wiki First and learn the AUR system.
			 https://wiki.archlinux.org/index.php/Arch_User_Repository
			EOF
			msgFunc anykey
			msgFunc line
	        msgFunc norm "Number of foreign packages installed = $(pacman -Qm | wc -l)"
	        cd "$Dest3" || exitHandlerFunc dest3
		    msgFunc blue "AUR package install and updates by cower, options:-"
			cat <<-EOF
			(1)    Get Information for AUR package with optional install
			(2)    Fetch  updates to installed AUR packages with optional install
			(3)    Check for updates ( NO downloads)
			(4)    Write installed AUR/foreign package list to file.
			(*)    Return to main menu
			EOF
			msgFunc blue "Press option followed by [ENTER]"
			read -r choiceCower
			
			case "$choiceCower" in    
						#search AUR with cower with optional install
						1)msgFunc green "${GREEN}Search AUR with cower with optional install"
						  msgFunc norm "Type a AUR package name:-"
					      read -r cowerPac		
						  msgFunc norm " " 
						  cower -i -c "$cowerPac" || return
						  #cower -cd optional install 
						  cat <<-EOF
							Do you wish to download  build and install this package now?
							1) Yes"
							*) No"
							Press option number followed by [ENTER]"
							EOF
							read -r choiceIU4
								if [ "$choiceIU4" = "1" ]
									then
									 msgFunc dir "-AUR-DOWNLOAD"
									#build and install packages
									msgFunc norm "Downloading Package $cowerPac"	
									cower -d -c	 "$cowerPac"
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
								fi	
						;;
						
						#check for updates cower and optional install 
						           
						2)msgFunc green "Update AUR packages with cower "		
						#make cower update directory
						msgFunc dir "-AUR-UPDATES" 
						cower -d -vuc 
						# look for empty dir (i.e. if no updates) 
						if [ "$(ls -A .)" ] 
						then
							msgFunc norm  "Package builds available"
							ls 
							msgFunc norm " "
							cat <<-EOF
							Cower updates available for package build
							Do you wish to build and install  them now?
							1) Yes"
							*) No"
							Press option number followed by [ENTER]"
							EOF
							read -r choiceIU2
								if [ "$choiceIU2" = "1" ]
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
				 3) #check for updates 
					#check that paths exist and change path to dest path
						msgFunc norm "Number of updates available for installed AUR packages :..."
						cower -u | wc -l
						msgFunc norm " "
						cower -uc
						msgFunc anykey
				 ;;
				 4)msgFunc green "Writing installed AUR/foreign package lists to files at :"
						cd "$Dest3" || exitHandlerFunc dest3
						msgFunc dir "-INFO"
						pacman -Qm > pkglistAURF.txt
					;;
				 
				 *)  #exit to main menu 
					return
				 ;;
				 esac
			     msgFunc green "Done!"
}

function SystemMaintFunc
{
	#system maintenance
	        #change dir for log files
	        cd "$Dest3" || exitHandlerFunc dest3
			msgFunc dir "-INFO"
			
	        # -systemd --failed:
			msgFunc green "All Failed Systemd Services"
			systemctl --failed --all
			msgFunc green "Done!"
			
			msgFunc green "All Failed Active Systemd Services"
			systemctl --failed
			msgFunc green "Done!"
			
			# -Logfiles:
			msgFunc green "Check log Journalctl for Errors"
			msgFunc norm "Errorfile written to :-"
			pwd
			journalctl -p 3 -xb > Journalctlerrlog
			msgFunc green "Done!"
			
			#check ssd trim ok
			msgFunc green "Check Journalctl for fstrim SSD trim"
			msgFunc norm "SSD trim report written to -"
			pwd
			echo "SSD trim" > JournalctlerrSDDlog
			journalctl -u fstrim > JournalctlerrSDDlog
			msgFunc green "Done!"
			
			# Checking for broken symlinks:
			msgFunc green "Checking for Broken Symlinks"
			msgFunc norm "log.txt written to -"
			pwd
            find /"$HOME" -type l -! -exec test -e {} \; -print > symlinkerr
			msgFunc green "Done!"
			
}

function SystemBackFunc
{
			#Full system backup
			#get paths form config file if exists
			clear
			readconfigFunc
			msgFunc green "Done!"
			
			#get user input for backup
			msgFunc blue "Pick destination directory for system backup or gdrive option"
			cat <<-EOF
			(1)    "$Destination1"
			(2)    "$Destination2"
			(3)    "$Dest3"
			(4)    Specify a path 
			(5)    gdrive connect and sync to google drive
			(*)    Exit
			EOF
			msgFunc blue "Press option followed by [ENTER]"
			read -r choiceBack
			#check that paths exist and change path to dest path
			case "$choiceBack" in
			1)  
				  cd "$Destination1" || exitHandlerFunc dest1				
			;;
			2)  
				 cd "$Destination2"   || exitHandlerFunc dest2
			;;
			3)  
				  cd "$Dest3" || exitHandlerFunc dest3						
			;;
			4)  msgFunc norm "Type a custom destination path:-"
				read -r Path1		
				  cd "$Path1" || exitHandlerFunc dest4				
			;;
			5)  msgFunc green "gdrive sync with remote documents directory"
					#This uses netcat (nc) in its port scan mode, 
					#a quick poke (-z is zero-I/O mode [used for 
					#scanning]) with a quick timeout 
					#(-w 1 waits at most one second
					#It checks Google on port 80 (HTTP).
					if nc -zw1 google.com 80; then
						msgFunc norm   "**We have connectivity to google.com**"
					else
						exitHandlerFunc gdrive
					fi
				   	cat <<-EOF 
					Do you wish to use gdrive current paths or type a custom path?
					1) Continue 
					2) Type a Custom path 
					Press option number and [ENTER]
					EOF
					read -r  choiceGD
					
						if  [ "$choiceGD" = "1" ]
						then
							msgFunc green "gdrive sync with  remote directory path number one:-"
							gdrive sync upload "$gdriveSource1" "$gdriveDest1"
							msgFunc green "Done!"
							msgFunc green "gdrive sync with remote remote directory path number two:-"
							gdrive sync upload  "$gdriveSource2" "$gdriveDest2"
							msgFunc green "Done!"
				   		fi
				   		if [ "$choiceGD" = "2" ]
				   		then
				   		#custom path
							msgFunc norm "Type a custom Source directory path:-"
				            read -r gdriveS		            
				            msgFunc norm "Type a gdrive directory ID:-"
				            read -r gdriveD		          
							msgFunc green "gdrive sync with custom path"
							gdrive sync upload  "$gdriveS"	 "$gdriveD"
							msgFunc green "Done!"
				   		fi
				   		return
			;;				
			*) exitHandlerFunc exitout
			  ;;
			esac

			#make the backup directory
			msgFunc dir "-BACKUP"
			#begin the backup
			msgFunc green "Pick a Backup option"
			cat <<-EOF
			(1)    Copy of 512 bytes of MBR 
			(2)    Copy of Etc folder
			(3)    Copy of Home folder
			(4)    Copies of installed package lists
			(5)    Make tarball of all except tmp dev proc sys run
			(6)    ALL (options 1-5)
			(0)    Return
			EOF
			msgFunc green "Press option followed by [ENTER]"
			read -r  choiceBackup
			case  "$choiceBackup" in
			
			1|6) #MBR
				msgFunc green "Make copy of first 512 bytes MBR with dd"
				#get /dev/sdxy where currenty filesystem is mounted 
				myddpath="$(df /boot/ --output=source | tail -1)"
				msgFunc norm "$myddpath"
				sudo dd if="$myddpath" of=hda-mbr.bin bs=512 count=1
				msgFunc green "Done!"
            ;;&
            
			2|6)#etc
				msgFunc green "Make a copy of etc dir"
				sudo cp -a -v -u /etc .
				msgFunc green "Done!"
            ;;&
            
            3|6)#home
				msgFunc green "Make a copy of home dir"
				sudo cp -a -v -u /home .
				msgFunc green "Done!"
				sync
			;;&
			
			4|6)#packages
				msgFunc green "Make copy of package lists"
				pacman -Qqen > pkglist.txt
				pacman -Qm > pkglistAUR.txt
				msgFunc green "Done!"
            ;;&
            
            5|6)#tar
				msgFunc green "Make tarball of all except tmp dev proc sys run"
				sudo tar --one-file-system --exclude=/tmp/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/run/* -pzcvf RootFS_backup.tar.gz /
				msgFunc green "Done!"
				sync
			;;
			
			0)#quit
				msgFunc green "Done!"
				return
				
			;;
			esac
			
}

#function to display various information
function SysinfoFunc
{
clear
msgFunc line
msgFunc red "System and cylon Information"
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
msgFunc norm  " "
msgFunc norm "Written by G. lyons Reports to  <glyons66@hotmail.com>"
msgFunc norm "Version=$(pacman -Qs cylon | head -1 | cut -c 7-20)"
msgFunc norm "Cylon program location =  $(which cylon)"
msgFunc norm "Destination folder for Cylon data = $Dest3"
msgFunc norm "Location of cylonCfg.conf and cylonReadme.md files = $Dest5"
msgFunc norm "Number of All installed  packages = $(pacman -Q | wc -l)"
msgFunc norm "Number of native, explicitly installed packages  = $(pacman -Qgen | wc -l)"
msgFunc norm "Number of foreign installed packages  = $(pacman -Qm | wc -l)"
#check network connectivity 
if nc -zw1 archlinux.org 80; 
	then
		msgFunc norm   "Number of Pacman updates ready...> $(checkupdates | wc -l)"
fi
if	 nc -zw1 aur.archlinux.org 80;
	then
		msgFunc norm "Number of updates for installed AUR packages ready ...> $(cower -u | wc -l)"
fi
msgFunc anykey
}
function ClamAVFunc
{
	       #anti virus with clamscan
           # update clamscan virus definitions:
			msgFunc green "Updating clamavscan Databases"
			sudo freshclam
			msgFunc green "Done!"
			msgFunc green "Scanning with Clamav$"
			cat <<-EOF
			Do you wish to run anti-virus check with clamAv at this point?
			1) Yes
			*) No
			Press option number and [ENTER]
			EOF
			read -r choiceAV			
			if [ "$choiceAV" = "1" ]
				then
					# scan entire system
					cd "$Dest3" || exitHandlerFunc dest3
					msgFunc dir "-INFO"
					sudo clamscan -l clamavlogfile --recursive=yes --infected --exclude-dir='^/sys|^/proc|^/dev|^/lib|^/bin|^/sbin' /
					msgFunc green "Done!"			
				else
					msgFunc green "Done!"
			fi
}

function SystemCleanFunc
{
		  clear
		   #system clean with bleachbit
		   msgFunc blue "System clean with bleachbit:-"
			cat <<-EOF
			(1)     bash
			(2)     Epiphany
			(3)     Evolution
			(4)     GNOME
			(5)     Rhythmbox
			(6)     Thumbnails
			(7)     Thunderbird
			(8) 	Transmission
			(9) 	VIM
			(0) 	VLC media player
			(a)     X11
			(b)     deepscan
			(c)     flash
			(d)     libreoffice
			(e)     System
			(f)     Firefox
			(A)     ALL - Full Bleachbit clean options 1-f
			(T)     Trash + Download folder clean (non bleachbit)     
			(q) 	return to main menu
			EOF
			msgFunc blue "Press option number followed by [ENTER]"
			read -r choicebb
			case "$choicebb" in
				   
				   A)msgFunc green "ALL - Full Bleachbit clean"
				   ;;&
				   
				   1|A)msgFunc green "Clean bash"
				   bleachbit --clean bash.*
				   ;;&
				   
				   2|A)msgFunc green "Clean Epiphany"
				   bleachbit --clean epiphany.*
				   ;;&
				   
				   3|A)msgFunc green "Clean Evolution"
				   bleachbit --clean evolution.*
				   ;;&
				   
				   4|A)msgFunc green "Clean GNOME"
				   bleachbit --clean gnome.*
				   ;;&
				   
				   5|A)msgFunc green "Clean Rhythmbox"
				   bleachbit --clean rhythmbox.*
				   ;;&
				   
				   6|A)msgFunc green "Clean Thumbnails"
				   bleachbit --clean thumbnails.*
				   ;;&
				   
				   7|A)msgFunc green "Clean Thunderbird"
				   bleachbit --clean thunderbird.*  
				   ;;&
				   
				   8|A)msgFunc green "Clean Transmission"
				   sudo bleachbit --clean transmission.*
				   ;;&
				   
				   9|A)msgFunc green "Clean VIM"
				   bleachbit --clean vim.*
				   ;;&
				   
				   0|A)msgFunc green "Clean VLC media player"
				   bleachbit --clean vlc.*
				   ;;&
				   
				   a|A)msgFunc green "Clean X11"
				   bleachbit --clean x11.*
				   ;;&
				   
				   b|A)msgFunc green "Clean Deep scan"
				   bleachbit --clean deepscan.*
				   ;;&
				   
				   c|A)msgFunc green "Clean Flash"
				   bleachbit --clean flash.*
				   ;;&
				   
				   d|A)msgFunc green "Clean libreoffice"
				   bleachbit --clean libreoffice.*
				   ;;&
				   
				   e|A)msgFunc green "Clean System"
				   sudo bleachbit --clean system.*
				   ;;&
				    
				   f|A)msgFunc green "Clean Firefox"
					bleachbit --clean firefox.*
				   ;;
				    
				    
				    T)  msgFunc green "Deleting  Trash + downloads folder"
						 rm -rvf /home/gavin/.local/share/Trash/*
						 rm -rvf "$HOME"/Downloads/*
					;;
					
				    q)  #exit  
				     msgFunc green "Done!"	
					return
					;;
					 
		esac
		msgFunc green "Done!"	
}

#function for rmlint software
#download with pacman
function RmLintFunc
{
	clear
	msgFunc green "Running rmlint"
			cat <<-EOF
			rmlint finds space waste and other broken things on 
			your filesystem and offers to remove it.
			Despite its name, rmlint just finds suspicious files, 
			but never modifies the filesystem itself . 
			Instead it gives you detailed reports in different formats 
			to get rid of them yourself. These reports are called outputs. 
			By default a shellscript will be written to rmlint.sh that 
			contains readily prepared shell commands to remove 
			duplicates and other finds.
			EOF
			msgFunc line
			msgFunc norm "Type a  directory path you wish to scan:-"
			read -r rmlintPath	            
		     cd "$rmlintPath" || exitHandlerFunc dest4
			msgFunc norm " "
			cat <<-EOF
			How do you wish to view output of rmlint scan?
			g) progress bar
			*) file list
			Press option  and [ENTER]
			EOF
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
			cat <<-EOF
			Do you wish to display result file  to screen?
			r) Display results file
			*) quit
			Press option  and [ENTER]
			EOF
			read -r choicermlint1
			if [ "$choicermlint1" = "r" ]
			then
				msgFunc green  "rmlint output file"
				more rmlint.json		
				msgFunc line
				msgFunc anykey
				#run the shell option?
				cat <<-EOF
				Do you wish to execute rmlint.sh file?
				e) Yes
				*) quit
				Press option and [ENTER]
				EOF
				msgFunc red "This file will change your system based on results of the previous scan"
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

#function for  ROOTKIT HUNTER software
function rootKitFunc
{
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
