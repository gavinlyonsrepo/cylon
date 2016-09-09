#!/bin/bash

#version 1.0 20-06-16
#verions 1.1 replace echo with prtintf functions.
#version 1.2 relative paths added 
#version 1.3 google drive function added 
#version 1.4 090916 extra cower options added

#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
BLUE=$(printf "\033[36;1m")
NORMAL=$(printf "\033[0m")

#make the path for the logfiles/updates etc
mkdir -p "$HOME/Documents/Tech/Linux/MyLinux/Cylon/"
#path for my internal hard drive backup
Dest1="/run/media/$USER/Linux_backup"
#path for my external hard drive backup
Dest2="/run/media/$USER/iomeaga_320"
#set logfilepath + cower updates 
Dest3="$HOME/Documents/Tech/Linux/MyLinux/Cylon/"


#functions
#Help function to display Help info
function HelpFunc 
{
#print horizonal line 
printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
cat <<-EOF
Funtions:
(1)Updates Offical Arch Repos with pacman
(2)Pacman maintenance routine.
Delete orphans + Prunes older packages from cache +
Writes installed package lists to files 
(3)AUR cower options search and optional install + Updates AUR package
using  Cower with optional install requires cower  from AUR
(4) system maintenance check
All Failed Systemd Services All Failed Active Systemd Services
Check log Journalctl for Errors Check log Journalctl for fstrim SSD trim
Check for broken symlinks, 
(5)System backup
Optional destination path as defined in script or custom path
Make copy of first 512 bytes MBR with dd
Make a copy of etc dir Make a copy of home dir
Make tarball of all except tmp dev proc sys runMake copy of package 
lists, Also there is an option  for gdrive sync with remote 
directories on google drive requires netcat and gdrive(AUR) installed
(6)Clean system with bleachbit
Requires program bleachbit installed, menu option 15 settings.
(7)Delete firefox history by bleachbit
(8)Deleting Trash and Downloads folder
(9)ClamAv anti virus scan 
EOF

printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
printf '%s' "${GREEN} "
read -n 1 -r -s -p "Press any key to continue!"
clear
}

function PacmanFunc 
{
	#update pacman
	printf '%s\n\n' "${GREEN}Update Pacman ${NORMAL}"
	sudo pacman -Syu
	printf '%s\n\n' "${GREEN}DONE!${NORMAL}" 
}

function PacmanMantFunc
{
	        #pacman maintenance
	        printf '%s\n\n' "${GREEN}Pacman Maintenance${NORMAL}"
			printf '%s\n' "Delete orphans!"
			sudo pacman -Rns "$(pacman -Qtdq)"
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"			
			printf '%s\n' "Prune older packages from cache!"
			sudo paccache -r
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			printf '%s\n' "Writing installed package lists to files at :- "
			cd "$Dest3" || exitHandlerFunc dest3
			pwd
			pacman -Qqen > pkglist.txt
			pacman -Qm > pkglistAUR.txt
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"    
			
}

function CowerFunc
{
	         #AUR warning
	         printf '%s\n' "${RED}"	
	         cat <<-EOF
			 AUR WARNING: User Beware
			 The Arch User Repository (AUR) is a community-driven repository for Arch users
			 It is possible for a package to contain dangerous commands through malice 
			 or ignorance. Before installing packages or installing updates
			 Please Read wiki First
			 https://wiki.archlinux.org/index.php/Arch_User_Repository
			EOF
			printf '%s' "${GREEN} " 
			read -n 1 -r -s -p "Press any key to continue!"
			printf '%s\n' "${NORMAL}"
            clear
			
	         #make cower directory
	         cd "$Dest3" || exitHandlerFunc dest3
		     
		     printf '%s\n' "${GREEN}AUR by cower options${NORMAL}"
			cat <<-EOF
			(1)    Information for package with optional install
			(2)    Check for updates with optional install
			(*)    Return to main menu
			Press option followed by [ENTER]
			EOF
			read -r choiceCower
			#check that paths exist and change path to dest path
			case "$choiceCower" in    
						#search AUR with cower with optional install
						1)printf '%s\n\n' "${GREEN}Search AUR with cower with optional install ${NORMAL}"
						  printf '%s\n\n' "Type a AUR package name:-"
					      read -r cowerPac		
						  printf '%s\n' "$cowerPac" 
						  cower -i -c "$cowerPac" || return
						  #cower -cd optinal install 
						  cat <<-EOF
							Do you wish to download  build and install this package now?
							1) Yes"
							*) No"
							Press option number followed by [ENTER]"
							EOF
							read -r choiceIUI
								if [ "$choiceIUI" = "1" ]
									then
									printf '%s\n\n' "Building and installing cower package"	
									#build and install packages
									cower -d -c	 "$cowerPac"
									cd "$cowerPac" || return
									makepkg -si		
								fi	
						;;
						
						#check for updates cower and optional install            
						2)printf '%s\n\n' "${GREEN}Update AUR packages with cower ${NORMAL}"		
						TODAYSBACKUPDATE=$(date +%H-%d-%b-%Y)
			             mkdir "$TODAYSBACKUPDATE"
		                 cd "$TODAYSBACKUPDATE" || exitHandlerFunc dest4
		                 printf '%s\n' "Directory made at pwd below for AUR updates"
			             pwd		       
						cower -d -vuc 
						
						# look for empty dir (i.e. if no updates) 
						
						if [ "$(ls -A .)" ] 
						then
							printf '%s\n' "Package builds available"
							ls 
							printf '\n'
							cat <<-EOF
							Cower updates available for package build
							Do you wish to build and install  them now?
							1) Yes"
							*) No"
							Press option number followed by [ENTER]"
							EOF
							read -r choiceIU
								if [ "$choiceIU" = "1" ]
									then
									printf '%s\n\n' "Building and installing cower package updates"	
									#build and install packages
									find . -name PKGBUILD -execdir makepkg -si \;			
								fi	
						  else
							printf '%s\n\n' "No updates of AUR packages by Cower..."
						  fi	
						;;
				 *)  #exit to main menu 
					return
				 ;;
				 esac
			     printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
}

function SystemMaintFunc
{
	#system maintenance
	        # -systemd --failed:
			printf '%s\n' "${GREEN}All Failed Systemd Services${NORMAL}"
			systemctl --failed --all
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			
			printf '%s\n' "${GREEN}All Failed Active Systemd Services${NORMAL}"
			systemctl --failed
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			
			# -Logfiles:
			printf '%s\n' "${GREEN}Check log Journalctl for Errors${NORMAL}"
			cd "$Dest3" || exitHandlerFunc dest3
			printf '%s\n' "Errorfile written to :-"
			pwd
			journalctl -p 3 -xb >Journalctlerrlog
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			
			#check ssd trim ok
			printf '%s\n' "${GREEN}Check Journalctl for fstrim SSD trim${NORMAL}"
			cd "$Dest3" || exitHandlerFunc dest3
			printf '%s\n' "SSD trim report written to -"
			pwd
			echo "SSD trim" >> Journalctlerrlog
			journalctl -u fstrim >> Journalctlerrlog
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			
			# Checking for broken symlinks:
			printf '%s\n' "${GREEN}Checking for Broken Symlinks${NORMAL}"
			cd "$Dest3" || exitHandlerFunc dest3
			printf '%s\n' "log.txt written to -"
			pwd
			cd ~ || exitHandlerFunc dest4
            find . -type l -! -exec test -e {} \; -print > "$Dest3"symlinkerr
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			
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
			printf '%s\n' "${GREEN}Pick destination directory for backup${NORMAL}"
			cat <<-EOF
			(1)    "$Dest1"
			(2)    "$Dest2"
			(3)    "$Dest3"
			(4)    gdrive connect and sync to google drive
		(5)    Specify a path 
			(*)    Exit
			Press option followed by [ENTER]
			EOF
			read -r choiceBack
			#check that paths exist and change path to dest path
			case "$choiceBack" in
			1)  printf '%s\n' "$Dest1"
				  cd "$Dest1" || exitHandlerFunc dest1				
			;;
			2)  printf '%s\n'  "$Dest2"
				 cd "$Dest2"   || exitHandlerFunc dest2
						
			;;
			3)  printf '%s\n'  "$Dest3"
				  cd "$Dest3" || exitHandlerFunc dest3						
			;;
			4)  printf '%s\n' "${GREEN}gdrive sync with remote documents directory${NORMAL}"
					#This uses netcat (nc) in its port scan mode, 
					#a quick poke (-z is zero-I/O mode [used for 
					#scanning]) with a quick timeout 
					#(-w 1 waits at most one second
					#It checks Google on port 80 (HTTP).
					if nc -zw1 google.com 80; then
						printf '%s\n'  "we have connectivity to google.com"
					else
						exitHandlerFunc gdrive
					fi
				   	gdrive sync upload ./Documents 0B3_RVJ50UWFAaGxJSXg3NGJBaXc
				   	printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   	
				   	printf '%s\n' "${GREEN}gdrive sync with remote pictures directory${NORMAL}"
				   	gdrive sync upload  ./Pictures 0B3_RVJ50UWFAR3A2T3dZTU9TaTA
				   	printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   	return	
				   				
			;;				
			5)  printf '%s\n\n' "Type a custom destination path:-"
				read -r Path1		
				  printf '%s\n' "$Path1"
				  cd "$Path1" || exitHandlerFunc dest4				
			;;

			*) exitHandlerFunc exitout
			  ;;
			esac

			#make the backup directory
			TODAYSBACKUPDATE=$(date +%H-%d-%b-%Y)
			mkdir "$TODAYSBACKUPDATE"
			cd "$TODAYSBACKUPDATE" || exitHandlerFunc dest4
			printf '%s\n\n' "Backup Directory made at :- "
			pwd
			
			#begin the backup
			printf '%s\n' "${GREEN}Make copy of first 512 bytes MBR with dd${NORMAL}"
			sudo dd if=/dev/sdb1 of=hda-mbr.bin bs=512 count=1
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			
            printf '%s\n' "${GREEN}Make a copy of etc dir${NORMAL}"
			sudo cp -a -v -u /etc .
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			
            printf '%s\n' "${GREEN}Make a copy of home dir${NORMAL}"
			sudo cp -a -v -u /home .
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			sync

            printf '%s\n' "${GREEN}Make tarball of all except tmp dev proc sys run${NORMAL}"
			sudo tar --one-file-system --exclude=/tmp/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/run/* -pzcvf RootFS_backup.tar.gz /
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			sync

            printf '%s\n' "${GREEN}Make copy of package lists${NORMAL}"
			pacman -Qqen > pkglist.txt
			pacman -Qm > pkglistAUR.txt
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
}

function ClamAVFunc
{
	       #anti virus with clamscan
           # update clamscan virus definitions:
			
			printf '%s\n' "${GREEN}Updating clamavscan Databases${NORMAL}"
			sudo freshclam
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			
			printf '%s\n' "${GREEN}Scanning with Clamav${NORMAL}"
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
					printf '%s\n' "Clamavlogfile  at"
					pwd
					sudo clamscan -l clamavlogfile --recursive=yes --infected --exclude-dir='^/sys|^/proc|^/dev|^/lib|^/bin|^/sbin' /
					printf '%s\n\n' "${GREEN}DONE!${NORMAL}"			
				else
					printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
			fi
}

function SystemCleanFunc
{
		   #system clean with bleachbit
		   printf '%s\n' "${BLUE}System clean with bleachbit :- ${NORMAL}"
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
			printf '%s\n' "${BLUE}Press option number followed by [ENTER] ${NORMAL}"
			read -r choicebb
			case "$choicebb" in
				   
				   1)printf '%s\n' "${GREEN}Clean bash${NORMAL}"
				   bleachbit --clean bash.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   2)printf '%s\n' "${GREEN}Clean Epiphany${NORMAL}"
				   bleachbit --clean epiphany.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   3)printf '%s\n' "${GREEN}Clean Evolution${NORMAL}"
				   bleachbit --clean evolution.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   4)printf '%s\n' "${GREEN}Clean GNOME${NORMAL}"
				   bleachbit --clean gnome.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   5)printf '%s\n' "${GREEN}Clean Rhythmbox${NORMAL}"
				   bleachbit --clean rhythmbox.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   6)printf '%s\n' "${GREEN}Clean Thumbnails${NORMAL}"
				   bleachbit --clean thumbnails.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   7)printf '%s\n' "${GREEN}Clean Thunderbird${NORMAL}"
				   bleachbit --clean thunderbird.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   8)printf '%s\n' "${GREEN}Transmission${NORMAL}"
				   sudo bleachbit --clean transmission.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"	
				   ;;
				   
				   9)printf '%s\n' "${GREEN}Clean VIM${NORMAL}"
				   bleachbit --clean vim.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   0)printf '%s\n' "${GREEN}Clean VLC media player${NORMAL}"
				   bleachbit --clean vlc.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   a)printf '%s\n' "${GREEN}Clean X11${NORMAL}"
				   bleachbit --clean x11.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   b)printf '%s\n' "${GREEN}Clean Deep scan${NORMAL}"
				   bleachbit --clean deepscan.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   c)printf '%s\n' "${GREEN}Clean Flash${NORMAL}"
				   bleachbit --clean flash.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   d)printf '%s\n' "${GREEN}Clean libreoffice${NORMAL}"
				   bleachbit --clean libreoffice.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
				   ;;
				   
				   e)printf '%s\n' "${GREEN}Clean System${NORMAL}"
				   sudo bleachbit --clean system.*
				   printf '%s\n\n' "${GREEN}DONE!${NORMAL}"		
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
				printf '\n' 
			;;
			dest1)  
				  printf '%s\n\n' "${RED}Path not found to destination directory NOTE : The Hard drives  internal must be mounted${NORMAL}"	
				  printf '%s\n\n' "$Dest1"
			;;
			dest2)  
			      printf '%s\n\n' "${RED}Path not found to destination directory NOTE : The Hard drives  external must be mounted${NORMAL}"	
				  printf '%s\n\n' "$Dest2"
			;;			
			dest3)  
			     printf '%s\n\n' "${RED}Path not found to destination directory${NORMAL}"
			     printf '%s\n\n' "$Dest3"
			;;
			dest4)
				printf '%s\n\n' "${RED}Path not found to destination Custom directory${NORMAL}"
			;;
			 gdrive)
				printf '%s\n\n' "${RED}Internet connectivity test to google.com failed${NORMAL}"
			;;
	 esac
	printf '%s' "${GREEN} "      
	read -n 1 -r -s -p "Press any key to exit!"
	printf '\n' 
	printf '%s\n' "${BLUE}GOODBYE $USER !!${NORMAL}"
	exit
}


#Program details print
#print horizonal line 
printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
cat <<-EOF
Cylon.sh 25-06-16  Version 1.4-2 (090916)
Copyright (C) 2016  <glyons66@hotmail.com>
Aur package name = cylon
Arch Linux distro Maintenance program written in Bash script.
This script is a  maintenance, 
backup and system check menu driven optional script Command line program  
This script provides numerous tools 
to Arch Linux for maintenance, system checks and backups. 
EOF
printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =

#main program loop    
while true; do
    cd ~ || exitHandlerFunc dest4
    printf '%s\n' "${BLUE}Main Menu :- ${NORMAL}"
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
	printf '%s\n' "${BLUE}Press option number followed by [ENTER] ${NORMAL}"
    read -r choiceMain
    case "$choiceMain" in
		1)   #pacman update
			 PacmanFunc 		
		;;
		2)  printf '\n'
			#pacman maintenance
			PacmanMantFunc		
		;;
		3) printf '\n'
			#cower AUR
		    CowerFunc
		;;
		4) printf '\n'
			#system maintenance
			SystemMaintFunc			 
		;;
		5)  printf '%s\n' ""
		   	#Full system backup
		   	SystemBackFunc
		;;
		6) 	printf '\n'  
		   #system clean with bleachbit
		   SystemCleanFunc							  
		;;
		
		7)  printf '%s\n' "${GREEN}Deleting firefox history${NORMAL}"
			bleachbit --clean firefox.*
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"			
		;;
		
		8)  printf '%s\n' "${GREEN}Deleting Trash and Downloads folder${NORMAL}"
			rm -rv /home/gavin/.local/share/Trash/files
			rm -rv /home/gavin/Downloads
			mkdir /home/gavin/Downloads
			printf '%s\n\n' "${GREEN}DONE!${NORMAL}"
		;;
		
		9) 	printf '\n'
			#Anti-virus clam Av
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


