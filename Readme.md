Cylon
-----
25-06-16 glyons glyons66@hotmail.com
See changlog.md for version control.
Arch Linux distro maintenance  Bash script. 
Aur package name = cylon
The goal was to create a script to do as much maintenance, 
backups and system checks in a single menu driven optional script 
Command line program for an Arch as possible
This script provides numerous tools 
to Arch Linux for maintenance, system checks and backups.  

Config
------
Cylon is a bash script installed to user/bin by package 
build. type cylon to run. Some function require software installed 
as listed below see optdepends also. this is left to user discretion.
software will display installed packages on cylon info page.
cylonReadme.md is installed to "$HOME"/.config/cylonReadme.md
this is displayed to screen by a menu option
You can create an optional config file for custom system backup
cylonCfg.conf, "gdrivedest" is google drive target directory ID.
Location"$HOME/.config/cylon"
File setup example
* Destination1="/run/media/$USER/Linux_backup"
* Destination2="/run/media/$USER/iomeaga_320"
* gdriveSource1="$HOME/Documents"
* gdriveSource2="$HOME/Pictures"
* gdriveDest1="foo123456789"
* gdriveDest2="foo123456789"

All backups outputs downloads and updates are placed in $HOME/Documents/Cylon

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
	* paccache -r Prune older packages from cache
	* Write installed package lists to files
	* Remove all packages not required as dependencies 
	* Back-up the local pacman database  
* AUR cower options 
	* Get Information for AUR package with optional install
	* search for AUR package
	* Download AUR  package
	* Fetch and install AUR packages
	* Check for updates ( NO downloads)
	* Write installed AUR/foreign package list to file.
* system maintenance check
	* All Failed Systemd Services
	* All Failed Active Systemd Services
	* Check log Journalctl for Errors
	* Check log Journalctl for fstrim SSD trim (check for SSD)
	* Check for broken symlinks, 
* System backup
	* Optional destination path as defined in script or custom path
	* Make copy of first 512 bytes MBR with dd
	* Make a copy of etc dir
	* Make a copy of home dir
	* Make tarball of all except tmp dev proc sys run
	* Make copy of package lists
	* Also there is an option for gdrive sync 
* Clean system with bleachbit
* System and package information displays 
* Rmlint remove duplicates and other lint
* Lostfiles scan
* ClamAv anti-malware scan
* RootKit hunter scan
* Display cylon with optdepend installation check, info and readme file to screen 

Needs installed for certain functions
-------------------------------------
* bleachbit for system clean
* clamav for virus check
* gnu-netcat to check for internet connection
* rkhunter to check for rootkits
* rmlint  to check for lint and duplicates 
* cower(AUR) for AUR functions
* gdrive(AUR) to sync to google drive
* lostfiles(AUR) to scan for lostfiles

Bug reports
-----------

If you should find a bug or any other query , 
please send a report to glyons66@hotmail.com

Copyright
---------

Copyright (C) 2016 g Lyons <glyons66@hotmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, see license.md for more details



