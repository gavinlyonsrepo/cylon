#!/bin/bash
# Written by G lyons 25-10-16 glyons66@hotmail.com
#see changelog for version control
#version 2.1-9  051016 
#Arch Linux distro maintenance Bash script. 
#Aur package name = cylon 
#A script to do as much maintenance, backups and system checks in 
#single menu driven optional script Command line program for Arch.  
#This script provides numerous tools to Arch Linux 
#for maintenance, system checks and backups. see readme for more info.
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
#folder for readme and config file
Dest5="$HOME/.config/cylon"
#prompt for select menus
PS3="${BLUE}Press option number + [ENTER] $ ${NORMAL}"
#functions list  14 functions + one main loop
function msgFunc
{
	#function for printing output of different colours anykey prompt and line 
	#also creates dirs for output checks for installation of packages 
	case "$1" in 
		line) #print blue horizontal line of =
			printf '\033[36;1m%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
		;;
		anykey) #any key prompt, appends second text input to prompt
		    printf '%s' "${GREEN}" 
			read -n 1 -r -s -p "Press any key to continue $2"
			printf '%s\n' "${NORMAL}"
		;;
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
			TODAYSDIR=$(date +%X-%d-%b-%Y)"$2"
			mkdir "$TODAYSDIR"
			cd "$TODAYSDIR" || exitHandlerFunc dest4
			msgFunc norm "Directory for output made at:-"
			pwd	 ;;
		checkpac) #check if package installed returns 1 or 0  appends text
			x=$(pacman -Qqs "$2")
			if [ -n "$x" ]
			then 
				printf '%s\n' "$2 is Installed $3"
				return 0
			else 
				printf '%s\n' "${RED}$2 is Not installed${NORMAL} $3"
				return 1
			fi ;;
		*) #debug for typos
			printf '%s\n' "Error bad input to msgFunc" ;;
	esac
}
function HelpFunc 
{
#Help function to display Help info
clear
msgFunc line
msgFunc green "cylon info and readme display" 
msgFunc line 
msgFunc norm "Written by G. lyons Reports to  <glyons66@hotmail.com>"
msgFunc norm "Version=$(pacman -Qs cylon | head -1 | cut -c 7-20)"
msgFunc norm "Cylon program location =  $(which cylon)"
msgFunc norm "Destination folder for Cylon data = $Dest3"
msgFunc norm "Location of cylonCfg.conf + cylonReadme.md files=$Dest5"
msgFunc norm "Checking optional dependencies installed..."
msgFunc checkpac cower "AUR package"
msgFunc checkpac gdrive "AUR package"
msgFunc checkpac lostfiles "AUR package"
msgFunc checkpac rmlint
msgFunc checkpac rkhunter
msgFunc checkpac gnu-netcat
msgFunc checkpac clamav
msgFunc checkpac bleachbit 
msgFunc anykey "and view the readme."
msgFunc line
msgFunc green "Displaying cylonReadme.md file at $Dest5"
cd "$Dest5"  || exitHandlerFunc dest5
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
		   msgFunc green "Pacman package manager. Number of packages installed = $(pacman -Q | wc -l) "
		   msgFunc line
		   msgFunc blue "Pacman package manager options:-"
			options=("Check for updates (no download)" "pacman -Syu Upgrade packages" \
			 "pacman -Si Display extensive information about a given package" "pacman -S Install Package" \
			 "pacman -Ss Search for packages in the database" \
			 "pacman -Rs Delete Package" "pacman -Qs Search for already installed packages" \
			 "pacman -Qi  Display extensive information for locally installed packages" "paccache -r Prune older packages from cache"\
			 "Write installed package lists to files" "Remove all packages not required as dependencies (orphans)" \
			 "Back-up the local pacman database" "Return to main menu")
			select choicep in "${options[@]}"
			do
			case "$choicep" in
					"${options[0]}")
					msgFunc green "Pacman updates ready:-.... "
						checkupdates | wc -l
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
					"${options[8]}")  msgFunc green  "Prune older packages from cache."
					#The paccache script, deletes all cached  package 
						#regardless of whether they're installed or not, 
						#except for the most recent 3, 
							sudo paccache -r
					;;
					"${options[9]}")msgFunc green "Writing installed package lists to files at :"
						cd "$Dest3" || exitHandlerFunc dest3
						msgFunc dir "-INFO"
						#all packages 
						pacman -Q  > pkglistQ.txt
						#native, explicitly installed package
						pacman -Qqen > pkglistQgen.txt
						#foreign installed (AUR etc))
						pacman -Qm > pkglistQm.txt
					;;
					"${options[10]}")   #delete orphans
						msgFunc green "Delete orphans!"
						#Remove all packages not required as dependencies (orphans)
						sudo pacman -Rns "$(pacman -Qtdq)"
					;;
					"${options[11]}") #backup the pacman database
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
			break
			done
			msgFunc green "Done!"	
			msgFunc anykey 
}
function lfFunc
{
#function LF uses lostfiles package from AUR 
#Search for files which are not part of installed Arch Linux packages
	#check if lostfiles installed
	msgFunc checkpac lostfiles
    if [ "$?" != 0 ]
	then
		msgFunc anykey 
	return
	fi
	clear
	msgFunc line
	msgFunc green "Lostfiles :-Search for files which are not part of installed Arch Linux packages"
	cd "$Dest3" || exitHandlerFunc dest3
	msgFunc dir "-INFO"
	msgFunc norm  "Lostfiles strict scan running, outputing to file"
	sudo bash -c "lostfiles strict  > lostfilesStrictlist.txt" 
	msgFunc green "Done!"
	msgFunc norm  "Lostfiles relaxed scan running, outputing to file"
    sudo bash -c  "lostfiles relaxed > lostfilesRelaxedlist.txt" 
	msgFunc green "Done!"
}
function readconfigFunc
{
	#read cylon.conf for system back up paths 
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
	cd "$Dest5"  || exitHandlerFunc dest5
	source ./cylonCfg.conf
	msgFunc norm "Custom paths read from file"
}
function CowerFunc
{
			#function to deal with installs and updates form AUR with 
			#package cower(AUR))
			 #check cower is installed
            msgFunc checkpac cower 
            if [ "$?" != 0 ]
				then
				msgFunc anykey 
				return
			fi
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
			clear
			msgFunc line
		   msgFunc green "AUR packages management by cower. Number of foreign packages installed = $(pacman -Qm | wc -l)"
		   msgFunc line
	        cd "$Dest3" || exitHandlerFunc dest3
		    msgFunc blue "AUR package install and updates by cower, options:-"
         	optionsC=("Information for package" "Search for package" \
         	"Download package" "Get updates for installed packages" \
         	"Check for updates, no downloads" "Return")
         	select choiceCower in "${optionsC[@]}"
			do
			case "$choiceCower" in    
						#search AUR with cower with optional install
						"${optionsC[0]}")msgFunc green "${GREEN}Information for AUR package , cower -i"
						  msgFunc norm "Type a AUR package name:-"
					      read -r cowerPac		
						  msgFunc norm " " 
						  cower -i -c "$cowerPac" || return
						  msgFunc anykey
						    ;;
						   
						  "${optionsC[1]}") msgFunc green "${GREEN}Search for AUR package, cower -s"
						  #cower -s 
						  msgFunc norm "Type a AUR package name:-"
					      read -r cowerPac		
						  msgFunc norm " " 
						  cower -s -c "$cowerPac" || return
						  msgFunc anykey
						  ;;
						  
						"${optionsC[2]}")#cower -d Download AUR package with an optional install
							msgFunc green "${GREEN}Download AUR package cower -d with an optional install"
							msgFunc dir "-AUR-DOWNLOAD"
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
						msgFunc dir "-AUR-UPDATES" 
						cower -d -vuc 
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
							#check that paths exist and change path to dest path
								msgFunc norm "Number of updates available for installed AUR packages :..."
								cower -u | wc -l
								msgFunc norm " "
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
function SystemMaintFunc
{
	#system maintenance
	        #change dir for log files
	        cd "$Dest3" || exitHandlerFunc dest3
			msgFunc dir "-INFO"
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
			#am I on sdd drive 0 for SDD 1 for HDD from command
			local SDX="$(df /boot/ --output=source | tail -1 | cut -c 6-8)"
			SDX=$(grep 0 /sys/block/"$SDX"/queue/rotational) 
			if [ "$SDX"=0 ] 
				then
				msgFunc green "Check Journalctl for fstrim SSD trim"
				echo "SSD trim" > JournalctlerrSDDlog
				journalctl -u fstrim > JournalctlerrSDDlog
				msgFunc green "Done!"
				else 
				msgFunc red "HDD detected no SSD trim check done"
			fi
			# Checking for broken symlinks:
			msgFunc green "Checking for Broken Symlinks"
            find /"$HOME" -type l -! -exec test -e {} \; -print > symlinkerr
			msgFunc green "Done!"
			msgFunc norm " "
}
function SystemBackFunc
{
			#Full system backup
			#get paths from config file if exists
			clear
			readconfigFunc
			msgFunc green "Done!"
			#get user input for backup
			optionsB1=("$Destination1" "$Destination2" "$Dest3" \
			"Custom" "gdrive" "Return")
			msgFunc blue "Pick destination directory for system backup or gdrive option"
			select  choiceBack in "${optionsB1[@]}"
			#check that paths exist and change path to dest path
			do
			case "$choiceBack" in
			
			"${optionsB1[0]}")  cd "$Destination1" || exitHandlerFunc dest1 ;;				
			"${optionsB1[1]}")  cd "$Destination2"   || exitHandlerFunc dest2 ;;
			"${optionsB1[2]}")  cd "$Dest3" || exitHandlerFunc dest3;;
			
			"${optionsB1[3]}")  #custom path read in 
						msgFunc norm "Type a custom destination path:-"
						read -r Path1		
						cd "$Path1" || exitHandlerFunc dest4 
						;;
			"${optionsB1[4]}")   #gdrive function sync with two dirs in google drive
					msgFunc green "gdrive sync with remote documents directory"
					 #check gnu-cat is installed
					msgFunc checkpac gnu-netcat "Accessing Network"
					if [ "$?" != 0 ]
					then
						msgFunc anykey 
					return
					fi
					#This uses netcat (nc) in its port scan mode, 
					#a quick poke (-z is zero-I/O mode [used for 
					#scanning]) with a quick timeout 
					#(-w 1 waits at most one second
					#It checks Google on port 80 (HTTP).
					if nc -zw1 google.com 80; then
						msgFunc norm   "**We have connectivity to google.com**"
					else
						exitHandlerFunc netdown "google"
					fi
					 #check gdrive is installed
					msgFunc checkpac gdrive 
					if [ "$?" != 0 ]
					then
						msgFunc anykey 
					return
					fi
					msgFunc green "gdrive sync with  remote directory path number one:-"
					gdrive sync upload "$gdriveSource1" "$gdriveDest1"
					msgFunc green "Done!"
					msgFunc green "gdrive sync with remote remote directory path number two:-"
					gdrive sync upload  "$gdriveSource2" "$gdriveDest2"
					msgFunc green "Done!"
					return ;;				
			*) return ;;
			esac
			break
			done
			
			#make the backup directory
			msgFunc dir "-BACKUP"
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
			;;&
			esac
			break 
			done
}
function SysinfoFunc
{
	#function to display various system information
clear
msgFunc line
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
msgFunc checkpac gnu-netcat "Accessing Network Database.."
if [ "$?" != 0 ]
then
	msgFunc anykey 
return
fi
#check network connectivity if good get updates numbers from arch
if nc -zw1 archlinux.org 80; 
	then
		msgFunc norm   "Number of Pacman updates ready...> $(checkupdates | wc -l)"
	else
	exitHandlerFunc netdown "archlinux.org"
fi
if	 nc -zw1 aur.archlinux.org 80;
	then
		msgFunc norm "Number of updates for installed AUR packages ready ...> $(cower -u | wc -l)"
	else
	exitHandlerFunc netdown "aur.archlinux.org"
fi
msgFunc anykey
}
function ClamAVFunc
{
	       #anti virus with clamscan
            #check clamav is installed
            msgFunc checkpac clamav
            if [ "$?" != 0 ]
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
			cd "$Dest3" || exitHandlerFunc dest3
			msgFunc dir "-INFO"
			sudo clamscan -l clamavlogfile --recursive=yes --infected --exclude-dir='^/sys|^/proc|^/dev|^/lib|^/bin|^/sbin' /
			msgFunc green "Done!"			
}
function SystemCleanFunc
{
		     #check bleachbit is installed
			msgFunc checkpac bleachbit 
			if [ "$?" != 0 ]
			then
				msgFunc anykey 
			return
			fi
		    clear
		   #system clean with bleachbit
		   msgFunc blue "System clean with Bleachbit:-"
			optionsbb=("bash" "Epiphany" "Evolution" "GNOME" "Rhythmbox" "Thumbnails" \
			"Thunderbird" "Transmission" "VIM" "VLC media player" "X11" "deepscan" \
			"flash" "libreoffice" "System" "Firefox" \
			"ALL bleachbit options" "Trash + Download folder clean (non bleachbit)" "Return")
			select choicebb in "${optionsbb[@]}"
			do
			case "$choicebb" in 
				   
				   "${optionsbb[16]}")
				   msgFunc green "ALL - Full Bleachbit clean"
				   ;;&  
				   "${optionsbb[0]}"|"${optionsbb[16]}")
				   msgFunc green "Clean bash"
				   bleachbit --clean bash.*
				   ;;&
				   "${optionsbb[1]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Epiphany"
				   bleachbit --clean epiphany.*
				   ;;&
				   "${optionsbb[2]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Evolution"
				   bleachbit --clean evolution.*
				   ;;&
				   "${optionsbb[3]}"|"${optionsbb[16]}")
				   msgFunc green "Clean GNOME"
				   bleachbit --clean gnome.*
				   ;;&
				   "${optionsbb[4]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Rhythmbox"
				   bleachbit --clean rhythmbox.*
				   ;;&
				   "${optionsbb[5]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Thumbnails"
				   bleachbit --clean thumbnails.*
				   ;;&
				   "${optionsbb[6]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Thunderbird"
				   bleachbit --clean thunderbird.*  
				   ;;&
				   "${optionsbb[7]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Transmission"
				   bleachbit --clean transmission.*
				   ;;&
				   "${optionsbb[8]}"|"${optionsbb[16]}")
				   msgFunc green "Clean VIM"
				   bleachbit --clean vim.*
				   ;;&
				   "${optionsbb[9]}"|"${optionsbb[16]}")
				   msgFunc green "Clean VLC media player"
				   bleachbit --clean vlc.*
				   ;;&
				   "${optionsbb[10]}"|"${optionsbb[16]}")
				   msgFunc green "Clean X11"
				   bleachbit --clean x11.*
				   ;;&
				   "${optionsbb[11]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Deep scan"
				   bleachbit --clean deepscan.*
				   ;;&
				   "${optionsbb[12]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Flash"
				   bleachbit --clean flash.*
				   ;;&
				   "${optionsbb[13]}"|"${optionsbb[16]}")
				   msgFunc green "Clean libreoffice"
				   bleachbit --clean libreoffice.*
				   ;;&
    			   "${optionsbb[14]}"|"${optionsbb[16]}")
    			   msgFunc green "Clean System"
				   sudo bleachbit --clean system.*
				   ;;&
				   "${optionsbb[15]}"|"${optionsbb[16]}")
				   msgFunc green "Clean Firefox"
					bleachbit --clean firefox.*
				   ;;&
				   "${optionsbb[17]}")  msgFunc green "Deleting  Trash + downloads folder"
						 rm -rvf /home/gavin/.local/share/Trash/*
						 rm -rvf "$HOME"/Downloads/*
					;;&
				    *)  #exit  
				     msgFunc green "Done!"	
				     msgFunc anykey
				     clear
					return
					;;
		esac
		done
		#msgFunc green "Done!"	
}

#function for rmlint software
#download with pacman
function RmLintFunc
{
	clear
			#check crmlint is installed
            msgFunc checkpac rmlint
            if [ "$?" != 0 ]
				then
				msgFunc anykey 
				return
			fi
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

#function for  ROOTKIT HUNTER software
function rootKitFunc
{
	#check rkhunter is installed
    msgFunc checkpac rkhunter
    if [ "$?" != 0 ]
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
}
function exitHandlerFunc
{
	#error handler deal with user exists and path not found errors
	case "$1" in
	        exitout) msgFunc norm " " ;;
			dest1) msgFunc red "Path not found to destination directory"	
				  msgFunc norm "$Destination1" ;;
			dest2) msgFunc red "Path not found to destination directory"
				  msgFunc norm "$Destination2" ;;			
			dest3) msgFunc red "Path not found to destination directory"
			     msgFunc norm "$Dest3" ;;
			dest4) msgFunc red "Path not found to directory" ;;
			dest5) msgFunc red "Path not found to destination directory"
			     msgFunc norm "$Dest5" ;;
			 netdown) msgFunc red "Internet connectivity test to $2 failed" ;;
	 esac
	msgFunc blue "GOODBYE $USER!!"
	msgFunc anykey "and exit."
	exit
}
#MAIN CODE
#print horizontal line 
msgFunc line
msgFunc green "***** CYLON (CYbernetic LifefOrm Node) (version 2.1-9) (25-09-16) *****" 
msgFunc line
msgFunc norm
#Program details print
cat <<-EOF
Cylon is an Arch Linux  maintenance CLI program written in Bash script.
This program provides numerous tools to Arch Linux users to carry 
out updates, maintenance, system checks and backups. 
AUR package name="cylon" at aur.archlinux.org by glyons.
EOF
date +%A-Week%U-%d-%B-%Y--%T
#main program loop    
while true; do
    msgFunc blue "Cylon Main Menu :-"
	optionsM=("Pacman options" "Cower options (AUR)" "Systems check" \
	 "System backup" "System clean" "System information" "Rmlint scan" \
	 "Lostfiles scan" "Clamav scan" "RootKit hunter scan" \
	 "Display cylon info and readme file to screen" "Exit")
	select choiceMain in "${optionsM[@]}"
	do
    case "$choiceMain" in
		"${optionsM[0]}")   #pacman update
			 PacmanFunc
			  ;;
		"${optionsM[1]}") #cower AUR helper
		    CowerFunc
		     ;;
		"${optionsM[2]}") #system maintenance
			SystemMaintFunc
			;;
		"${optionsM[3]}")  #Full system backup
		   	SystemBackFunc
		   	 ;;
		 "${optionsM[4]}") #system clean with bleachbit
		   SystemCleanFunc
		    ;;
		"${optionsM[5]}") #system info
		   SysinfoFunc
		    ;;
		"${optionsM[6]}") #rmlint 
		   RmLintFunc
		    ;;
		"${optionsM[7]}")#lostfiles(AUR))
		   lfFunc 
		   ;;
		"${optionsM[8]}") 	#Anti-virus clam Av
			ClamAVFunc  
			 ;;
		 "${optionsM[9]}")  #rootkit hunter 
			rootKitFunc 
			;;
		"${optionsM[10]}")  #display cylon info and cat readme file to screen 
			HelpFunc 
			 ;;
		*)  #exit  
			exitHandlerFunc exitout ;;
	esac
	break
	done
done


