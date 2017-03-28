Cylon
-----
* Date: 250317
* Version control: 3.4-5 See changlog.md for details
* Author: G Lyons, contact upstream repo or glyons66@hotmail.com
* Title : Arch Linux distro maintenance  a Bash shell script. 
* AUR package name : cylon
* Upstream repo: https://github.com/gavinlyonsrepo/cylon
* Name: cylon
* Description: The goal was to create a script to do as much updates maintenance, 
backups and system checks in a single menu driven optional script 
Command line program for an Arch linux distro as possible.
This script provides numerous tools 
to Arch Linux users for updates, maintenance, system checks and backups.  

Config
------
Type cylon to run :- cylon [options]
options:
* -h --help Print cylon information and exit.
* -s --system  Print system information and exit
* -v --version Print version information and exit.
* -c --config Opens the cylon config file for editing and exit
* -d --default Bleachbit system clean. Use the options set in the GUI
* -u --update runs a full update report with option to execute and exit.
Report provides Arch news rss reader + arch-audit vulnerable 
packages output + number and type of updates available. 

Cylon is a bash script installed to /usr/bin by package 
build. Some functions require software installed 
as listed below, see optdepends of PKGBUILD also. 
This is left to user discretion.
Software will display optdepends installed packages on cylon info page.
also "n/a" is displayed besides uninstalled options in menus
cylon files 

* /usr/bin/cylon (the shell script)
* /usr/lib/cylon/modules/*_module (modular functions called by script)
* /usr/share/doc/cylon/Readme.md
* /usr/share/doc/cylon/changelog.md
* /usr/share/licenses/cylon/License.md
* $HOME/.config/cylon/cylonCfg.conf (optional, user made, not install)
* /usr/share/pixmaps/cylonicon.png (icon)
* /usr/share/applications/cylon.desktop (desktop entry file)
* /usr/share/man/man7/cylon.7 (manpage)

Readme.md is displayed to screen by a menu option on cylon info page
A manpage is also installed together with menu entry and Icon.
You can create an optional config file for custom system backup called 
NAME: cylonCfg.conf, PATH: $HOME/.config/cylon/cylonCfg.conf
"DestinationX" is the path for backups
"gdrivedestX" is remote google drive  directory ID(see gdrive readme)
and "gdriveSourceX" is the local directory source.
"myccfile" is a setting for ccrypt utility, a path to a default file.
If config file missing the System uses hard-coded defaults.
File setup example (Note:remove md bullet points in actual file)

* Destination1="/run/media/$USER/Linux_backup"
* Destination2="/run/media/$USER/iomeaga_320"
* gdriveSource1="$HOME/Documents"
* gdriveSource2="$HOME/Pictures"
* gdriveDest1="foo123456789"
* gdriveDest2="foo123456789"
* rsyncsource="$HOME/"
* rsyncDest="/run/media/$USER/Linux_backup/foo"
* myccfile="$HOME/TEST/test.cpt"

Most system output (logfiles, backups, downloads and updates etc) 
is placed at below path , unless otherwise specified on screen
output folders are created with following syntax HHMM-DDMONYY-X where X
is output type i.e backup, update etc
* $HOME/Documents/Cylon

Packages cylon needs installed for certain functions
-------------------------------------
* ccrypt –  used for encrypting
* bleachbit – for system clean and shredding
* clamav –  for malware  check
* gnu-netcat – to check for internet connection 
* openbsd-netcat – to check for internet connection
* rkhunter – to check for rootkits
* rmlint – to check for lint and duplicates 
* rsync – for rsync backup function
* lynis – system audit
* inxi  – CLI system information script 
* htop – command line system information script 
* wavemon  – wireless network monitor 
* speedtest-cli  – testing internet bandwidth
* pacaur(AUR)  – for AUR helper functions 
* cower(AUR) – for AUR helper functions
* gdrive(AUR) – to sync to google drive
* lostfiles(AUR) – to scan for lostfiles
* Arch-audit(AUR) Uses data collected by the Arch CVE Team.

* Note1 : gnu-netcat and openbsd-netcat peform same function, 
only 1 can be or needs to be installed, both included due to conflicts
* Note2 : Cower and Pacaur are both AUR helpers you can install 
one or both depending on preference.
* Note3 : the setting TargetDir in cower config file must not be used.

Functions/menu options
----------------------
* pacman options
	* Check for updates (no download)
	* pacman -Syu Upgrade packages
	* pacman -Si Display extensive information 
	* pacman -S Install Package
	* pacman -Ss Search for packages in the database
	* pacman -Rs Delete Package
	* pacman -Qs Search for already installed packages
	* pacman -Qi  Display extensive information for 
	* pacman -Ql  List all files owned by a given package
	* pacman -Qkk Verify packages(option for one or all)
	* paccache -r Prune older packages from cache
	* Write installed package lists to files
	* Remove all packages not required as dependencies 
	* Back-up the local pacman database  
	* Arch news rss reader 
	* arch-audit gather CVE data
	* Edit pacman config file
* AUR cower options 
	* Check for updates ( NO downloads)
	* Get Information for AUR package 
	* search for AUR package
	* Download AUR  package
	* Fetch and install AUR packages
	* List all foreign packages
	* Edit cower config file
* AUR pacaur options
	* Check for updates ( NO downloads)
	* Get Information for AUR package 
	* Search for AUR package
	* Update AUR packages
	* Download build and install AUR package
	* Download and build only
	* Download only
	* Delete Pacaur cache files.
	* Edit pacaur config file
	* Update all packages in all repositories, pacaur -Syu
	* List of all foreign packages installed
* system maintenance check
	* All Failed Systemd Services and system status
	* All Failed Active Systemd Services
	* Check log Journalctl for Errors
	* Check log Journalctl for fstrim SSD trim (check for SSD in system)
	* Analyze system boot-up performance
	* Check for broken symlinks
	* Check for files not owned by any user or group
	* Lostfiles scan, relaxed and strict
	* Diskspace usage 
	* Old configuration files scan, output to files
* System backup
	* Optional destination path as defined in script or custom path
	* Make copy of first 512 bytes MBR with dd
	* Make a copy of etc dir
	* Make a copy of home dir
	* Make tarball of all except tmp dev proc sys run
	* Make copy of package lists
	* Rsync option 
	* gdrive options
		* List all syncable directories on drive
		* Sync local directory to google drive (path 1)
		* Sync local directory to google drive (path 2)
		* List content of syncable directory
		* Google drive metadata, quota usage
		* List files
		* Get file info
		* Note : Syncs Include Delete extraneous remote files as of V3.4-5
* Clean system with bleachbit
	* Preset option based on the same options as in the GUI 
	* Custom options involved for user to pick cleaners and options
		* preview
		* clean (without overwrite, BB checks the config in GUI).
		* clean + overwrite (with overwrite permanent deletion)
* System and package information displays 
	* Function also  run by -s  standalone
* Rmlint remove duplicates and other lint
	* Find bad UID, GID or files with both.
	* Find bad symlinks pointing nowhere.
	* Find empty directories.
	* Find empty files.
	* Find nonstripped binaries.
	* Find duplicate files.
	* Find duplicate directories.
	* option to view results file
	* option to execute shell script with results 
* ClamAv anti-malware scan (Check for updates feature)
* RootKit hunter scan (check for updates feature)
* password generator
* inxi - system information display with logging of results
* ccrypt - encrypt and decrypt files:
	* config file path option for ease of use.
	* Encrypt a file 		     
    * Decrypt a file
    * Edit decrypted file with NANO
    * Change the key of encrypted file
    * View encrypted file	
* Delete folders(bleachbit shred option) 
	* Shred specific files or folders with bleachbit
	* Deleting Trash 
	* Deleting Download directory
	* Delete Cylon output folder ($HOME/Documents/Cylon/
* Display cylon with optdepend installation check, info 
and readme file to screen (function can also run by -h by -help)
* Lynis system audit (summary of logfiles feature)
* 3 day weather forecast by wttr.in
* Option to open xterm terminal in new window
* Option to launch htop - interactive process viewer
* Network options
	* launch wavemon network monitor
	* Run speedtest-cli to measure bandwidth 
	with options for server list and file save
	* various misc network commands
	* firewall status and details check
	
Bug reports and communication
-----------

If you should find a bug or any other query , 
please send a report to upstream repo or mail glyons66@hotmail.com
suggestions for improvements and new features welcome

Copyright
---------

Copyright (C) 2016 G Lyons 

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, see license.md for more details



