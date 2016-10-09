Cylon
-----
Date: 101016
Version control: 2.2.1 See changlog.md for details
Author g. lyons contact at glyons66@hotmail.com
Ttile : Arch Linux distro maintenance  Bash shell script. 
AUR package name : cylon
Upstream repo: https://github.com/gavinlyonsrepo/cylon
Description:
The goal was to create a script to do as much updates maintenance, 
backups and system checks in a single menu driven optional script 
Command line program for an Arch linux distro as possible.
This script provides numerous tools 
to Arch Linux users for updates, maintenance, system checks and backups.  

Config
------
Type cylon to run
Cylon is a bash script installed to user/bin by package 
build. Some functions require software installed 
as listed below, see optdepends of PKGBUILD also. 
This is left to user discretion.
Software will display optdepends installed packages on cylon info page.

cylon files 
* /usr/bin/cylon (the shell script)
* /usr/share/doc/cylon/Readme.md
* /usr/share/doc/cylon/changelog.md
* /usr/share/licenses/cylon/License.md
* $HOME/.config/cylon/cylonCfg.conf  (optional not installed)

Readme  is displayed to screen by a menu option
You can create an optional config file for custom system backup
cylonCfg.conf, "gdrivedest" is google drive target directory ID.
if missing system uses hard-coded defaults
File setup example
* Destination1="/run/media/$USER/Linux_backup"
* Destination2="/run/media/$USER/iomeaga_320"
* gdriveSource1="$HOME/Documents"
* gdriveSource2="$HOME/Pictures"
* gdriveDest1="foo123456789"
* gdriveDest2="foo123456789"

All system output (logsfiles, backups, outputs, downloads and updates) 
are placed below unless otherwise specified on screen
* $HOME/Documents/Cylon

Needs installed for certain functions
-------------------------------------
* ccrypt: used for encrypting
* bleachbit for system clean
* clamav for virus check
* gnu-netcat to check for internet connection
* rkhunter to check for rootkits
* rmlint  to check for lint and duplicates 
* cower(AUR) for AUR functions
* gdrive(AUR) to sync to google drive
* lostfiles(AUR) to scan for lostfiles


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
	* Arch news rss reader
* AUR cower options 
	* Get Information for AUR package 
	* search for AUR package
	* Download AUR  package
	* Fetch and install AUR packages
	* Check for updates ( NO downloads)
	
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
* password generator
* ccrypt - encrypt and decrypt files:
* Display cylon with optdepend installation check, info and readme file to screen

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



