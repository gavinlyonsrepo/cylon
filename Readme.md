Cylon
-----
Date: 201016 
Version control: 3.0-1 See changlog.md for details
Author G Lyons, contact upstream repo or glyons66@hotmail.com
Ttile : Arch Linux distro maintenance  a Bash shell script. 
AUR package name : cylon
Upstream repo: https://github.com/gavinlyonsrepo/cylon
Name:cylon
Description:
The goal was to create a script to do as much updates maintenance, 
backups and system checks in a single menu driven optional script 
Command line program for an Arch linux distro as possible.
This script provides numerous tools 
to Arch Linux users for updates, maintenance, system checks and backups.  

Config
------
Type cylon to run
options:
-h --help -help print help and exit.
-s --system  print system information and exit
-v --versiom print version information and exit.
Cylon is a bash script installed to /usr/bin by package 
build. Some functions require software installed 
as listed below, see optdepends of PKGBUILD also. 
This is left to user discretion.
Software will display optdepends installed packages on cylon info page.

cylon files 

* /usr/bin/cylon (the shell script)
* /usr/share/doc/cylon/Readme.md
* /usr/share/doc/cylon/changelog.md
* /usr/share/licenses/cylon/License.md
* $HOME/.config/cylon/cylonCfg.conf (optional, user made, not install)

Readme.md is displayed to screen by a menu option in cylon info

You can create an optional config file for custom system backup called 
NAME: cylonCfg.conf, PATH: $HOME/.config/cylon/cylonCfg.conf
"DestinationX" is the path for backups
"gdrivedestX" is remote google drive  directory ID(see gdrive readme)
and "gdriveSourceX" is the local directory source.
If config file missing the System uses hard-coded defaults.
File setup example (Note:remove bullet points in actual file)

* Destination1="/run/media/$USER/Linux_backup"
* Destination2="/run/media/$USER/iomeaga_320"
* gdriveSource1="$HOME/Documents"
* gdriveSource2="$HOME/Pictures"
* gdriveDest1="foo123456789"
* gdriveDest2="foo123456789"
* rsyncsource="$HOME/"
* rsyncDest="/run/media/$USER/Linux_backup/foo"

Most system output (logsfiles, backups, downloads and updates etc) 
is placed at below path , unless otherwise specified on screen
output folders are created with following syntax HHMMDAYMONYY-X where X
is output type i.e backup, info etc
* $HOME/Documents/Cylon

Packages cylon needs installed for certain functions
-------------------------------------
* ccrypt: used for encrypting
* bleachbit for system clean and shredding
* clamav for virus check
* gnu-netcat to check for internet connection
* rkhunter to check for rootkits
* rmlint  to check for lint and duplicates 
* rsync  for rsync backup function
* pacaur  – AUR package for AUR work
* inxi  – CLI system information script 
* htop  Command line system information script 
* wavemon  – wireless network monitor 
* speedtest-cli  – testing internet bandwidth
* cower(AUR) for AUR helper functions
* gdrive(AUR) to sync to google drive
* lostfiles(AUR) to scan for lostfiles
* pacaur(AUR) alternate AUR helper

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
	* paccache -r Prune older packages from cache
	* Write installed package lists to files
	* Remove all packages not required as dependencies 
	* Back-up the local pacman database  
	* Arch news rss reader
* AUR cower options 
	* Get Information for AUR package 
	* search for AUR package
	* Download AUR  package
	* Fetch and install AUR packages
	* Check for updates ( NO downloads)
* AUR pacaur options
	* Get Information for AUR package 
	* search for AUR package
	* Download build and install AUR package
	* update AUR packages
	* Check for updates ( NO downloads)
	* Download only
	* Download and build only
	* Delete Pacaur cache files.
* system maintenance check
	* All Failed Systemd Services
	* All Failed Active Systemd Services
	* Check log Journalctl for Errors
	* Check log Journalctl for fstrim SSD trim (check for SSD in system)
	* Analyze system boot-up performance
	* Check for broken symlinks
	* Check for files not owned by any user or group
	* Lostfiles scan, relaxed and strict
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
* Clean system with bleachbit
	* Preset option based on the same options as in the GUI 
	* Custom options involved for user to pick cleaners and options
		* preview
		* clean (without overwrite, BB checks the config in GUI).
		* clean + overwrite (with overwrite permanent deletion)
* System and package information displays 
	* Function also  run by -s or --system standalone
	* inxi program feature
* Rmlint remove duplicates and other lint
	* option to view results file
	* option to execute shell script with results 
* ClamAv anti-malware scan (Check for updates feature)
* RootKit hunter scan (check for updates feature)
* password generator
* ccrypt - encrypt and decrypt files:
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
	* Run speedtest-cli to measure bandwith 
	with options for server list and file save
	* various misc network commands
	
	
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



