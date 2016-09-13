#!/bin/bash

# G lyons
#see cat displays further below for more info
#version control:
#version 1.0 20-06-16
#verions 1.1 replace echo with printf functions.
#version 1.2 relative paths added 
#version 1.3-1 google drive function added 
#version 1.4-2 090916 extra cower options added
#version 1.5-3 options added for system backup function(dd and gdrive)
#version 1.6-4  120916 Msgfunc added, PKGBUILD display added 

#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
BLUE=$(printf "\033[36;1m")
NORMAL=$(printf "\033[0m")

clear 

#make the path for the logfiles/AUR downloads and updates etc
mkdir -p "$HOME/Documents/Tech/Linux/MyLinux/Cylon/"

#define some variables 
#path for my internal hard drive backup
Dest1="/run/media/$USER/Linux_backup"
#path for my external hard drive backup
Dest2="/run/media/$USER/iomeaga_320"
#set logfilepath + cower updates 
Dest3="$HOME/Documents/Tech/Linux/MyLinux/Cylon/"

#functions
#function for printing output also creates dirs for output
function msgFunc
{
	case "$1" in 
		line) #print horizontal line
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
				#just change colour
				printf '%s' "${NORMAL}"
				return
			fi
			printf '%s\n' "${NORMAL}$2"
		;;
		dir) #makes dirs for ouput
			TODAYSDIR=$(date +%H-%d-%b-%Y)"$2"
			mkdir "$TODAYSDIR"
			cd "$TODAYSDIR" || exitHandlerFunc dest4
			msgFunc norm "Directory for output made at:-"
			pwd	
		;;
	esac
}

#Help function to display Help info
function HelpFunc 
{
clear
#print horizonal line 
msgFunc line
msgFunc green "Displaying readme file"
cd "$HOME"/.config/  || exitHandlerFunc dest3
more cylonReadme.md 
msgFunc green "Done!" 
msgFunc line
msgFunc anykey
clear
} 

function PacmanFunc 
{
	#update pacman
	msgFunc green "Update system with Pacman"
	sudo pacman -Syu
	msgFunc green "Done!" 
}

function PacmanMantFunc
{
	        #pacman maintenance
	        msgFunc green "Pacman Maintenance"
			msgFunc green "Delete orphans!"
			#Remove all packages not required as dependencies (orphans)
			sudo pacman -Rns "$(pacman -Qtdq)"
			msgFunc green "Done!"
			
			msgFunc green  "Prune older packages from cache!"
			#The paccache script, deletes all cached  package 
			#regardless of whether they're installed or not, 
			#except for the most recent 3, 
			sudo paccache -r
			msgFunc green "Done!"
			
			msgFunc green "Writing installed package lists to files at :"
			cd "$Dest3" || exitHandlerFunc dest3
			msgFunc dir "-INFO"
			pacman -Qqen > pkglist.txt
			pacman -Qm > pkglistAUR.txt
			msgFunc green "Done!"   
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
	         #check that paths exist and change path to dest path
	         cd "$Dest3" || exitHandlerFunc dest3
		     msgFunc green "AUR package install and updates by cower, options:-"
			cat <<-EOF
			(1)    Get Information for package with optional install
			(2)    Check for updates to installed packages with optional install
			(*)    Return to main menu
			Press option followed by [ENTER]
			EOF
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
									#TODAYSAURDL=$(date +%H-%d-%b-%Y)"-AUR-Download"
									 #mkdir "$TODAYSAURDL"
									 #cd "$TODAYSAURDL" || exitHandlerFunc dest4
									 #msgFunc norm "Directory made at pwd below for AUR Download"
									 #pwd	
									 msgFunc dir "-AUR-DOWNLOAD"
									#build and install packages
									msgFunc norm "Downloading Package $cowerPac"	
									cower -d -c	 "$cowerPac"
									cd "$cowerPac" || return
									msgFunc green "$cowerPac PKGBUILD: Please read"
									cat PKGBUILD
									msgFunc green "PKGBUILD displayed above" 
									msgFunc norm "Press 1 to install any other key to quit" 
									read -r choiceIU3
									if [ "$choiceIU3" = "1" ]
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
									msgFunc green "PKGBUILDS displayed above$" 
									msgFunc norm "Press 1 to install ALL, any other key to quit" 
									read -r choiceIU1
									if [ "$choiceIU1" = "1" ]
										then
											#build and install all donwloaded PKGBUILD files 
											msgFunc norm  "Installing packages"
											find . -name PKGBUILD -execdir makepkg -si \;
									fi			
								fi	
						  else
							msgFunc norm "No updates  found for installed AUR packages by Cower..."
						  fi	
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
			#Check that user ran as sudo (obsolete version 1.2)
			#if (( EUID != 0 )); then
			#	printf '%s\n\n' "${RED}Please run as root for system backup${NORMAL}"	
			#	exitHandlerFunc exitout
			#fi
			#get user input for backup
			msgFunc green "Pick destination directory for system backup or gdrive option"
			cat <<-EOF
			(1)    "$Dest1"
			(2)    "$Dest2"
			(3)    "$Dest3"
			(4)    Specify a path 
			(5)    gdrive connect and sync to google drive
			(*)    Exit
			Press option followed by [ENTER]
			EOF
			
			read -r choiceBack
			#check that paths exist and change path to dest path
			case "$choiceBack" in
			1)  
				  cd "$Dest1" || exitHandlerFunc dest1				
			;;
			2)  
				 cd "$Dest2"   || exitHandlerFunc dest2
						
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
						msgFunc norm '%s\n'  "**We have connectivity to google.com**"
					else
						exitHandlerFunc gdrive
					fi
				   	cat <<-EOF 
					Do you wish to use gdrive default paths or custom path?
					1) Default
					*) Custom
					Press option number and [ENTER]
					EOF
					read -r choiceGD
					
						if  [ "$choiceGD" = "1" ]
						then
							msgFunc green "gdrive sync with remote documents directory"
							gdrive sync upload ./Documents 0B3_RVJ50UWFAaGxJSXg3NGJBaXc
							msgFunc green "Done!"
							msgFunc green "gdrive sync with remote pictures directory"
							gdrive sync upload  ./Pictures 0B3_RVJ50UWFAR3A2T3dZTU9TaTA
							msgFunc green "Done!"
				   		else 
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
			msgFunc green "Make copy of first 512 bytes MBR with dd"
			#get /dev/sdxy where currenty filesystem is mounted 
			myddpath="$(df /boot/ --output=source | tail -1)"
			msgFunc norm "$myddpath"
			sudo dd if="$myddpath" of=hda-mbr.bin bs=512 count=1
			msgFunc green "Done!"
			
            msgFunc green "Make a copy of etc dir"
			sudo cp -a -v -u /etc .
			msgFunc green "Done!"
			
            msgFunc green "Make a copy of home dir"
			sudo cp -a -v -u /home .
			msgFunc green "Done!"
			sync

            msgFunc green "Make tarball of all except tmp dev proc sys run"
			sudo tar --one-file-system --exclude=/tmp/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/run/* -pzcvf RootFS_backup.tar.gz /
			msgFunc green "Done!"
			sync

            msgFunc green "Make copy of package lists"
			pacman -Qqen > pkglist.txt
			pacman -Qm > pkglistAUR.txt
			msgFunc green "Done!"
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
			2) No
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
			(f) 	return to main menu
			EOF
			msgFunc blue "Press option number followed by [ENTER]"
			read -r choicebb
			case "$choicebb" in
				   
				   1)msgFunc green "Clean bash"
				   bleachbit --clean bash.*
				   msgFunc green "Done!"
				   ;;
				   
				   2)msgFunc green "Clean Epiphany"
				   bleachbit --clean epiphany.*
				   msgFunc green "Done!"
				   ;;
				   
				   3)msgFunc green "Clean Evolution"
				   bleachbit --clean evolution.*
				   msgFunc green "Done!"
				   ;;
				   
				   4)msgFunc green "Clean GNOME"
				   bleachbit --clean gnome.*
				   msgFunc green "Done!"
				   ;;
				   
				   5)msgFunc green "Clean Rhythmbox"
				   bleachbit --clean rhythmbox.*
				   msgFunc green "Done!"
				   ;;
				   
				   6)msgFunc green "Clean Thumbnails"
				   bleachbit --clean thumbnails.*
				   msgFunc green "Done!"
				   ;;
				   
				   7)msgFunc green "Clean Thunderbird"
				   bleachbit --clean thunderbird.*
				   msgFunc green "Done!"
				   ;;
				   
				   8)msgFunc green "Transmission"
				   sudo bleachbit --clean transmission.*
				   msgFunc green "Done!"
				   ;;
				   
				   9)msgFunc green "Clean VIM"
				   bleachbit --clean vim.*
				   msgFunc green "Done!"
				   ;;
				   
				   0)msgFunc green "Clean VLC media player"
				   bleachbit --clean vlc.*
				   msgFunc green "Done!"
				   ;;
				   
				   a)msgFunc green "Clean X11"
				   bleachbit --clean x11.*
				   msgFunc green "Done!"
				   ;;
				   
				   b)msgFunc green "Clean Deep scan"
				   bleachbit --clean deepscan.*
				   msgFunc green "Done!"
				   ;;
				   
				   c)msgFunc green "Clean Flash"
				   bleachbit --clean flash.*
				   msgFunc green "Done!"
				   ;;
				   
				   d)msgFunc green "Clean libreoffice"
				   bleachbit --clean libreoffice.*
				   msgFunc green "Done!"
				   ;;
				   
				   e)msgFunc green "Clean System"
				   sudo bleachbit --clean system.*
				   msgFunc green "Done!"	
				   ;;
				    
				    *)  #exit  
					return
					;;
		esac
}

function exitHandlerFunc
{
	#deal with user exists and path not found errors
	case "$1" in
	        exitout)              	
				msgFunc norm " "
			;;
			dest1)  
				  msgFunc red "Path not found to destination directory, The internal HDD must be mounted"	
				  msgFunc norm "$Dest1"
			;;
			dest2)  
			      msgFunc red "Path not found to destination directory, The external HDD must be mounted"
				  msgFunc norm "$Dest2"
			;;			
			dest3)  
			     msgFunc red "Path not found to destination directory"
			     msgFunc norm "$Dest3"
			;;
			dest4)
				msgFunc red "Path not found to custom destination directory"
			;;
			 gdrive)
				msgFunc red "Internet connectivity test to google.com failed"
			;;
	 esac
	msgFunc anykey
	msgFunc blue "GOODBYE $USER!!"
	exit
}



#print horizonal line 
msgFunc line
msgFunc norm 
#Program details print
cat <<-EOF
Cylon.sh 25-06-16  Version 1.6-4 (13-09-16)
Copyright (C) 2016  Reports to  <glyons66@hotmail.com>
Aur package name="cylon" , repo="github.com/whitelight999/cylon"
Arch Linux distro Maintenance program written in Bash script.
This script is a  maintenance, backup and system check menu driven 
optional script Command line program  This script provides numerous tools 
to Arch Linux for maintenance, system checks and backups. 
EOF
msgFunc line

#main program loop    
while true; do
    cd ~ || exitHandlerFunc dest4
    msgFunc blue "Main Menu :-"
	cat <<-EOF
	(1)     Pacman updates
	(2)     Pacman maintenance 
	(3)     AUR by Cower options
	(4)     System maintenance check
	(5)     System backup 
	(6)     System clean by Bleachbit
	(7) 	Delete Firefox history
	(8) 	Delete Trash and Downloads folder
	(9) 	ClamAv anti-virus check
	(0)     Display Help Info
	(*) 	Exit
	EOF
	msgFunc blue "Press option number followed by [ENTER] "
    read -r choiceMain
    case "$choiceMain" in
		1)   #pacman update
			 PacmanFunc 		
		;;
		2)  #pacman maintenance
			PacmanMantFunc		
		;;
		3) #cower AUR helper
		    CowerFunc
		;;
		4) #system maintenance
			SystemMaintFunc			 
		;;
		5)  #Full system backup
		   	SystemBackFunc
		;;
		6) #system clean with bleachbit
		   SystemCleanFunc							  
		;;
		
		7)  msgFunc green "Deleting firefox history"
			bleachbit --clean firefox.*
			msgFunc green "Done!"			
		;;
		
		8)  msgFunc green "Deleting Trash and Downloads folder"
			rm -rv "$HOME"/.local/share/Trash/files
			rm -rv "$HOME"/Downloads
			mkdir "$HOME"/Downloads
			msgFunc green "Done!"
		;;
		
		9) 	#Anti-virus clam Av
			ClamAVFunc  			
		;;
		0)  #Help  
			HelpFunc
		;;
		
		*)  #exit  
		exitHandlerFunc exitout
		;;
	esac

done


