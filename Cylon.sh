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
#version 1.7-5  140916 Config file added for custom backup paths
#version 1.8-6  180916 added rootkithunter option + update counters
#version 1.9-7  250916 added option for rmlint , menu layout option 

#colours for printf
RED=$(printf "\033[31;1m")
GREEN=$(printf "\033[32;1m")
BLUE=$(printf "\033[36;1m")
NORMAL=$(printf "\033[0m")

clear 
#make the path for the logfiles/AUR downloads and updates etc
mkdir -p "$HOME/Documents/Tech/Linux/MyLinux/Cylon/"
#set logfilepath + cower updates + conf file + custom backup
Dest3="$HOME/Documents/Tech/Linux/MyLinux/Cylon/"
Dest5="$HOME/.config/"
 
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
				#just change colour
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

function PacmanFunc 
{
	clear
		   #Pacman package manager options:
		   msgFunc line
		   msgFunc norm "Number of Package updates ready ...."
		   checkupdates | wc -l
		   msgFunc line
		   msgFunc blue "Pacman package manager options:-"
			cat <<-EOF
			(1)     pacman -Syu Upgrade packages
			(2)     pacman -Rs Delete Package
			(3)     pacman -S Install Package
			(4)     pacman -Si Display extensive information about a given package
			(5)     pacman -Qs Search for already installed packages
			(6)     pacman -Ss Search for packages in the database
			(7)     paccache -r Prune older packages from cache
			(8) 	Write installed package lists to files
			(9)     Remove all packages not required as dependencies (orphans)
			(0) 	Back-up the local pacman database  
			(*) 	return to main menu
			EOF
			msgFunc blue "Press option number followed by [ENTER]"
			read -r choicep
			case "$choicep" in
					
					1) #update pacman
						msgFunc green "Update system with Pacman."
						sudo pacman -Syu
					;;
					2) #pacman -Rs Delete Package
						msgFunc green "Delete Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        sudo pacman -Rs "$pacString"
					;;
					
					3) #pacman -S Install Package
						msgFunc green "Install package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        sudo pacman -S "$pacString"
					;;
					
					4) #pacman -Si Display extensive information about a given package
						msgFunc green "Display information  for Package."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Si "$pacString"
					;;
					
					5)   #pacman -Qs Search for already installed packages
						msgFunc green "Search for already installed packages."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Qs "$pacString"
					;;
					
					6)   #pacman -Ss Search Repos for Package
						msgFunc green "Search for packages in the database."
						msgFunc norm "Please enter package name"
						read -r pacString
                        pacman -Ss "$pacString"
					;;
					
					7)  msgFunc green  "Prune older packages from cache."
						#The paccache script, deletes all cached  package 
						#regardless of whether they're installed or not, 
						#except for the most recent 3, 
							sudo paccache -r
					;;
					
					8)msgFunc green "Writing installed package lists to files at :"
						cd "$Dest3" || exitHandlerFunc dest3
						msgFunc dir "-INFO"
						pacman -Qqen > pkglist.txt
						pacman -Qm > pkglistAUR.txt
					;;
					
					9)   #delete orphans
						msgFunc green "Delete orphans!"
						#Remove all packages not required as dependencies (orphans)
						sudo pacman -Rns "$(pacman -Qtdq)"
					;;

					0) #backup the pacman database
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
		Dest1="/run/media/$USER/Linux_backup"
		#path for an external hard drive backup
		Dest2="/run/media/$USER/iomeaga_320"
		#default paths for gdrive 
		gdriveSource1="$HOME/Documents"
		gdriveSource2="$HOME/Pictures"
		gdriveDest1="0B3_RVJ50UWFAaGxJSXg3NGJBaXc"
		gdriveDest2="0B3_RVJ50UWFAR3A2T3dZTU9TaTA"
		return
	fi
	cd "$Dest5"  || exitHandlerFunc dest4
	source ./cylonCfg.conf
	Dest1="$Destination1"
	Dest2="$Destination2"
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
	         #check that paths exist and change path to dest path
	         msgFunc norm "Number of updates available for installed AUR packages :-"
		     cower -u | wc -l
	         cd "$Dest3" || exitHandlerFunc dest3
		     msgFunc green "AUR package install and updates by cower, options:-"
			cat <<-EOF
			(1)    Get Information for AUR package with optional install
			(2)    Fetch  updates to installed AUR packages with optional install
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
									 msgFunc dir "-AUR-DOWNLOAD"
									#build and install packages
									msgFunc norm "Downloading Package $cowerPac"	
									cower -d -c	 "$cowerPac"
									cd "$cowerPac" || return
									msgFunc green "$cowerPac PKGBUILD: Please read"
									cat PKGBUILD
									msgFunc green "PKGBUILD displayed above" 
									msgFunc norm "Press n to quit, press y to install" 
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
									msgFunc green "PKGBUILDS displayed above. ^" 
									msgFunc norm "Press n to quit, press y to install all" 
									read -r choiceIU1
									if [ "$choiceIU1" != "n" ]
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
			#get paths form config file if exists
			clear
			readconfigFunc
			msgFunc green "Done!"
			
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
			
			
			msgFunc green "Make copy of first 512 bytes MBR with dd"
			#get /dev/sdxy where currenty filesystem is mounted 
			myddpath="$(df /boot/ --output=source | tail -1)"
			msgFunc norm "$myddpath"
			sudo dd if="$myddpath" of=hda-mbr.bin bs=512 count=1
			msgFunc green "Done!"
			
			msgFunc anykey
			
            msgFunc green "Make a copy of etc dir"
			sudo cp -a -v -u /etc .
			msgFunc green "Done!"
			
			msgFunc anykey
			
            msgFunc green "Make a copy of home dir"
			sudo cp -a -v -u /home .
			msgFunc green "Done!"
			
			msgFunc anykey
			
			sync
			msgFunc green "Make copy of package lists"
			pacman -Qqen > pkglist.txt
			pacman -Qm > pkglistAUR.txt
			msgFunc green "Done!"
            
            msgFunc anykey
            
            msgFunc green "Make tarball of all except tmp dev proc sys run"
			sudo tar --one-file-system --exclude=/tmp/* --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/run/* -pzcvf RootFS_backup.tar.gz /
			msgFunc green "Done!"
			sync

        
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
			(f)     Firefox
			(g)     Trash + Download folder clean (non bleachbit)     
			(*) 	return to main menu
			EOF
			msgFunc blue "Press option number followed by [ENTER]"
			read -r choicebb
			case "$choicebb" in
				   
				   1)msgFunc green "Clean bash"
				   bleachbit --clean bash.*
				   ;;
				   
				   2)msgFunc green "Clean Epiphany"
				   bleachbit --clean epiphany.*
				   ;;
				   
				   3)msgFunc green "Clean Evolution"
				   bleachbit --clean evolution.*
				   ;;
				   
				   4)msgFunc green "Clean GNOME"
				   bleachbit --clean gnome.*
				   ;;
				   
				   5)msgFunc green "Clean Rhythmbox"
				   bleachbit --clean rhythmbox.*
				   ;;
				   
				   6)msgFunc green "Clean Thumbnails"
				   bleachbit --clean thumbnails.*
				   ;;
				   
				   7)msgFunc green "Clean Thunderbird"
				   bleachbit --clean thunderbird.*  
				   ;;
				   
				   8)msgFunc green "Transmission"
				   sudo bleachbit --clean transmission.*
				   ;;
				   
				   9)msgFunc green "Clean VIM"
				   bleachbit --clean vim.*
				   ;;
				   
				   0)msgFunc green "Clean VLC media player"
				   bleachbit --clean vlc.*
				   ;;
				   
				   a)msgFunc green "Clean X11"
				   bleachbit --clean x11.*
				   ;;
				   
				   b)msgFunc green "Clean Deep scan"
				   bleachbit --clean deepscan.*
				   ;;
				   
				   c)msgFunc green "Clean Flash"
				   bleachbit --clean flash.*
				   ;;
				   
				   d)msgFunc green "Clean libreoffice"
				   bleachbit --clean libreoffice.*
				   ;;
				   
				   e)msgFunc green "Clean System"
				   sudo bleachbit --clean system.*
				   ;;
				    
				   f)msgFunc green "Deleting firefox history"
					  bleachbit --clean firefox.*
				    ;;
				    
				    g)  msgFunc green "Deleting  Trash + downloads folder"
						 rm -rv /home/gavin/.local/share/Trash/files
						 rm -rv "$HOME"/Downloads
						 mkdir "$HOME"/Downloads
					;;
					
				    *)  #exit  
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
			msgFunc green "Press g to Run Rmlint with progress bar, any other key for file list" 
			read -r choicermlint
			if [ "$choicermlint" = "g" ]
				then
					# run with progress bar 
					rmlint -g
				else
					rmlint
			fi
			#display the results file option? 
			msgFunc green "Press r to display result file  to screen, any other key quit" 
			read -r choicermlint1
			if [ "$choicermlint1" = "r" ]
			then
				msgFunc green  "rmlint output file"
				more rmlint.json		
				msgFunc line
				msgFunc anykey
				#run the shell option?
				msgFunc red "Press e to execute rmlint.sh file, any other key to quit " 
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
				  msgFunc norm "$Dest1"
			;;
			dest2)  
			      msgFunc red "Path not found to destination directory"
				  msgFunc norm "$Dest2"
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
	msgFunc anykey
	msgFunc blue "GOODBYE $USER!!"
	exit
}



#print horizontal line 
msgFunc line
msgFunc norm 
#Program details print
cat <<-EOF
****** cylon version 1.9-7 (25-09-16) ******
Copyright (C) 2016  Reports to  <glyons66@hotmail.com>
Aur package name="cylon" , repo="github.com/whitelight999/cylon"
Arch Linux distro maintenance CLI program written in Bash script.
This  program provides numerous tools to Arch Linux users to carry 
out updates maintenance, system checks and backups. 
EOF
msgFunc line
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
	(6)     Rmlint remove duplicates and other lint
	(7) 	ClamAv anti-malware scan
	(8) 	RootKit hunter scan
	(9)     Display readme file to screen
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
		
		6) #rmlint 
		   RmLintFunc
		;;
		
		7) 	#Anti-virus clam Av
			ClamAVFunc  			
		;;
		8)  #rootkit hunter 
			rootKitFunc
		;;
		9)  #cat readme file to screen 
			HelpFunc
		;;
		
		*)  #exit  
		exitHandlerFunc exitout
		;;
	esac

done


