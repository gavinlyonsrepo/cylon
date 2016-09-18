Cylon.sh  25-06-16 glyons glyons66@hotmail.com
Version 1.7-5(140916)  Arch Linux distro maintenance  Bash script. 
Aur package name = cylon

#version control:
#version 1.0 20-06-16
#verions 1.1 replace echo with printf functions.
#version 1.2 relative paths added 
#version 1.3-1 google drive function added 
#version 1.4-2 090916 extra cower options added
#version 1.5-3 options added for system backup function(dd and gdrive)
#version 1.6-4  120916 Msgfunc added PKGBUILD display added, 
readme install added
#version 1.7-5  140916 Config file added for custom backup paths
#version 1.8-6  180916 added rootkithunter option + update counters

What is Cylon:
The goal was to create a script to do as much maintenance, 
backups and system checks in a single menu driven optional script 
Command line program for an Arch as possible
This script provides numerous tools 
to Arch Linux for maintenance, system checks and backups.  

Config:
Cylon is a bash script installed to user/bin by package 
build. type cylon to run. Some function require software installed 
as listed below. this is left to user discretion.
Readme.md is installed to "$HOME"/.config/cylonReadme.md
this is displayed to screen by a menu option
You can create an optional config file for custom system backup
Name: cylonCfg.conf
Location:"$HOME/.config/"
File setup example:
Destination1="/run/media/$USER/Linux_backup"
Destination2="/run/media/$USER/iomeaga_320"
gdriveSource1="$HOME/Documents"
gdriveSource2="$HOME/Pictures"
gdriveDest1="0B3_RVJ50UWFAaGxJSXg3NGJBaXc"
gdriveDest2="0B3_RVJ50UWFAR3A2T3dZTU9TaTA"



Functions:
(1)Updates main Arch Repos with pacman
(2)Pacman maintenance routine.
Delete orphans + Prunes older packages from cache +
Writes installed package lists to files 
3)AUR cower options search and optional install + Updates AUR package
using  Cower with optional install requires cower  from AUR
(4) system maintenance check
All Failed Systemd Services
All Failed Active Systemd Services
Check log Journalctl for Errors
Check log Journalctl for fstrim SSD trim
Check for broken symlinks, 
(5)System backup
Optional destination path as defined in script or custom path
Make copy of first 512 bytes MBR with dd
Make a copy of etc dir
Make a copy of home dir
Make tarball of all except tmp dev proc sys run
Make copy of package lists
Also there is an option 
for gdrive sync with remote directory's on google drive requires netcat 
and gdrive(AUR) installed
(6)Clean system with bleachbit
Requires program bleachbit installed menu options
system
Deep scan Flash libreoffice Cleabash GNOME Epiphany
Evolution Rhythmbox Thumbnails
Thunderbird Transmission X11 VIM VLC media player X11
(7)Delete firefox history by bleachbit
(8)Deleting Trash and Downloads folder
(9)ClamAv anti virus scan  needs clamav SW
(0)Rootkithunter
(h) displays help info installed readme catted to screen

12 main menu options currently
    (1)     Get updates with Pacman
    (2)     Pacman maintenance
    (3)     Get updates from AUR with cower
    (4)     System maintenance check
    (5)     System backup
    (6)     System Clean by Bleachbit
    (7)     Delete Firefox history
    (8)     Empty Trash and Downloads folder
    (9)     ClamAv anti-virus check
    (0)     Rootkithunter
    (h)    Display Help
    (*)     Exit
    
Needs installed for certain functions:
Firefox for browser , 
cower for the AUR , 
bleachbit for system clean
clamAV for virus check
gdrive to sync to google drive
gnu-netcat to check for internet connection
rootkithunter

Bug reports
-----------

If you should find a bug or any other query , please send a report to glyons66@hotmail.com

Copyright
---------

Copyright (C) 2016 g Lyons <glyons66@hotmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.



