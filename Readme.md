Cylon.sh  
25-06-16 
Version 1.3
Arch Linux distro maintenance  Bash script. 
Aur package name = cylon

What is Cylon?
The goal was to create a script to do as much maintenance, 
backups and system checks in a single menu driven optional script Command line program for an Arch as possible
This script provides numerous tools 
to Arch Linux for maintenance, system checks and backups.  


Funtions:
(1)Updates Offical Arch Repos with pacman
(2)Pacman maintenance routine.
Delete orphans + Prunes older packages from cache +
Writes installed package lists to files 
(3)Updates AUR packages using  Cower with optional install
requires cower installed from AUR
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
for gdrive sync with remote documents directory on google drive requires netcat and gdrive(AUR) installed
(6)Clean system with bleachbit
Requires program bleachbit installed
Clean Deep scan
Clean Flash
Clean libreoffice
Clean System
(7)Delete firefox history by bleachbit
(8)Deleting Trash and Downloads folder
(9)ClamAv anti virus scan 
(0) displays help info

11 main menu options currently
    (1)     Get updates with Pacman
    (2)     Pacman maintence
    (3)     Get updates from AUR with cower
    (4)     System maintence check
    (5)     System backup
    (6)     System Clean by Bleachbit
    (7)     Delete Firefox history
    (8)     Empty Trash and Downloads folder
    (9)     ClamAv anti-virus check
    (10)    Display Help
    (*)     Exit
Needs installed for certain functions:
Firefox for browser , 
cower for the AUR , 
bleachbit for system clean
clamAV for virus check
gdrive to sync to google drive
gnu-netcat to check for internet connection
Bug reports
-----------

If you should find a bug, please send a report to <whitelight999@live.ie>.


Copyright
---------

Copyright (C) 2016 Gavin Lyons <whitelight999@live.ie>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.



