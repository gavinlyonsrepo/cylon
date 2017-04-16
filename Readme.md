Cylon
--------------------------------------------
* Name: cylon 
* Date: 200417
* Version control: 3.6-1-8 See changelog.md for details
* Author: Gavin Lyons
* Contact: Upstream repository at github "gavinlyonsrepo"
* Upstream repository: https://github.com/gavinlyonsrepo/cylon
* Title : Arch Linux distro maintenance  a Bash shell script. 
* AUR package name : cylon
* AUR location: https://aur.archlinux.org/packages/cylon/
* Description: A menu driven script which provides updates, maintenance, 
backups and system checks for an Arch based linux distribution.
This script provides numerous tools 
to Arch Linux users. The program is menu-based and written in bash.
The program is mainly console text based but also uses dialog GUI's 
at a few points for directory and file selection.
A detailed list of features is provided below in features section.

Options
-------------------------------------------
Type cylon to run :- cylon [options]
options:
* -h --help Print cylon information and exit.
* -s --system  Print system information and exit
* -v --version Print version information and exit.
* -c --config Opens the cylon config file for editing and exit
* -d --default Bleachbit system clean. 
This will execute options selected in bleachbit GUI or bleachbit config file.
* -u --update Runs a full update report with option to execute and exit.
Report provides Arch news rss reader + arch-audit vulnerable 
packages output + number and type of updates available for all repos.

Files
-----------------------------------------
Cylon is a bash script installed to /usr/bin by package 
build.

* /usr/bin/cylon (the shell script)
* /usr/lib/cylon/modules/*_module (modular functions called by script)
* /usr/share/doc/cylon/Readme.md
* /usr/share/doc/cylon/changelog.md
* /usr/share/licenses/cylon/License.md
* $HOME/.config/cylon/cylonCfg.conf (optional, user made, not installed)
* /usr/share/pixmaps/cylonicon.png (icon)
* /usr/share/applications/cylon.desktop (desktop entry file)
* /usr/share/man/man7/cylon.7 (manpage)

Readme.md is displayed to screen by a menu option on cylon info page.
Type man cylon for manpage. 
The manpage is a truncated version of this readme file.

Config file: You can create an optional config file for custom system backup. 
* NAME: cylonCfg.conf 
* PATH: $HOME/.config/cylon/cylonCfg.conf.
* SETTINGS:
"DestinationX" is the path for backups.
"gdrivedestX" is remote google drive directory file ID
(see gdrive readme for setup and how to get file id numbers)
and "gdriveSourceX" is the local directory source.
"myccfile" is a setting for ccrypt utility, a path to a default file.
If config file missing the System uses hard-coded defaults.
The config file can be edited from a main menu option or by option -c

File setup example (Note:remove bullet points in actual file)

* Destination1="/run/media/$USER/Linux_backup"
* Destination2="/run/media/$USER/iomega_320"
* gdriveSource1="$HOME/Documents"
* gdriveSource2="$HOME/Pictures"
* gdriveSource3="$HOME/Videos"
* gdriveDest1="foo123456789"
* gdriveDest2="foo125656789"
* gdriveDest3="foo123666689"
* rsyncsource="$HOME/"
* rsyncDest="/run/media/$USER/Linux_backup/foo"
* myccfile="$HOME/TEST/test.cpt"

Output folder
-------------------------------------
Most system output (logfiles, backups, downloads and updates etc) 
is placed at below path, unless otherwise specified on screen.
Output folders are created with following syntax HHMM-DDMONYY-X where X
is output type i.e backup, update etc. The default path is:
$HOME/Documents/Cylon
Optional Environment variable
example= export CYLONDEST="$HOME/.cache/cylon"
This optional Environment variable is provided for users
who wish to use different destination path for program output folder
if variable is not set or does not exist, cylon uses the default path.

Dependencies
-------------------------------------
Some functions require various dependencies packages to be installed.
There are two dependencies and the rest are optional dependencies.
The optional dependencies are left to user discretion.
Software will check for missing dependencies and report if user 
tries to use a function which requires a missing one.
Software will display installed dependencies packages on cylon info page.
also "n/a" is displayed besides uninstalled options in menus
* dialog –  used for GUIs menus (Non-optional)
* expac –   used for create package lists (Non-optional)
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
* Arch-audit – Uses data collected by the Arch CVE Team.
* pacaur(AUR)  – for AUR helper functions 
* cower(AUR) – for AUR helper functions
* gdrive(AUR) – to sync to google drive
* lostfiles(AUR) – to scan for lostfiles

* Note1 : gnu-netcat and openbsd-netcat peform same function, 
only 1 can be or needs to be installed, both included because of conflicts.
* Note2 : cower and pacaur are both AUR helpers you can install 
just cower or both depending on preference. pacaur wraps cower 
and needs it installed.
* Note3 : the setting TargetDir in cower config file must not be used
cylon will check this and display warning.
* Note4 : gdrive readme for config https://github.com/prasmussen/gdrive
* Note5 : gdrive option Syncs will Delete extraneous remote files as of V3.4-5
* Note6 : dialog should already be installed in an arch linux system installed by
the arch linux installation guide on wiki. If you install Arch some other way
It may not be there, so included as depends.

Features and Functions 
----------------------
* pacman options
	* Check for updates (no download)
	* pacman -Syu Upgrade packages
	* pacman -Si Display extensive information 
	* pacman -S Install Package
	* pacman -Ss Search for packages in the database
	* pacman -Rs Remove Package
	* pacman -Qs Search for already installed packages
	* pacman -Qi  Display extensive information for 
	* pacman -Ql  List all files owned by a given package
	* pacman -Qkk Verify packages(option for one or all)
	* paccache -r Prune older packages from cache
	* Write installed package lists to files (REF1)
	* Remove all packages not required as dependencies 
	* Back-up the local pacman database  
	* Arch news rss reader 
	* arch-audit gather CVE data
	* pactree List a dependency tree of a package
	* pactree -r Show packages that depend on a package
	* Edit pacman config file
* AUR cower options 
	* Check for updates ( NO downloads)
	* Get Information for AUR package 
	* Search for AUR package
	* Download AUR package and install
	* Fetch and install AUR packages
	* Download package only, no install. 
	* Write installed package lists to files (REF1)
	* Read AUR Package comments
	* Edit cower config file
	* Remove foreign packages explicitly installed menu
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
	* Write installed package lists to files (REF1)
	* Remove foreign packages explicitly installed menu
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
	* Print sensors information
	* Vacuum journal files
	* Delete core dumps 
	* Shred specific files with bleachbit
	* Shred specific folders with bleachbit
	* Delete Trash 
	* Delete Download directory
	* Delete Cylon output folder $HOME/Documents/Cylon/ or $CYLONDEST
	* password generator
	* inxi - system information display with logging of results
* System backup
	* Optional destination path as defined in script or custom path
	* Make copy of first 512 bytes MBR with dd
	* Make a copy of etc dir
	* Make a copy of home dir
	* Make tarball of all except tmp dev proc sys run
	* Make copy of package lists (REF1)
	* Rsync backup option 
	* gdrive options
		* List all syncable directories on drive
		* Sync local directory to google drive (path 1)
		* Sync local directory to google drive (path 2)
		* Sync local directory to google drive (path 3)
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
* System and package information display
	* Function also run by -s standalone option.
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
* ccrypt - encrypt and decrypt files:
	* config file path option for ease of use.
	* Encrypt a file 		     
    * Decrypt a file
    * Edit decrypted file
    * Change the key of encrypted file
    * View encrypted file	
* Cylon information: Display cylon with depends installation check, info 
and readme file to screen (function can also run by option -h )
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
* System update runs the same report that is called by cylon option -u
* Config file view/edit option.

* REF1: packages list 
	* All installed packages: pkglistQ.txt
	* All native packages: pkglistQn.txt
	* All explicitly installed packages: pkglistQe.txt
	* ALL explicitly installed native packages that are
	not direct or optional dependencies: pkglistQgent.txt
	* All foreign installed packages: pkglistQm.txt
	* All foreign explicitly installed packages: pkglistQme.txt
	* All explicitly installed packages not in base nor base-devel with size"
		and description: pkglistNonBase.txt
	* All installed packages sorted by size: pkglistSize.txt
	* All installed packages sorted by install date: pkglistDate.txt

* Note1: The setting TargetDir in cower config file must not be used
cylon will check this and display warning.
* Note 2: NANO is used as default text editor for editing config files.

Media
-----------
There are screenshots of cylon in the upstream repo and a video demo
is available at  https://vid.me/eB6u

Bug reports and communication
-----------

If you should find a bug or any other query , 
please send a report to upstream repo 
suggestions for improvements and new features welcome
Upstream repo: https://github.com/gavinlyonsrepo/cylon

Copyright
---------

Copyright (C) 2016 G Lyons 

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, see license.md for more details



