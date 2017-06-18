Overview
--------------------------------------------
* Name: cylon 
* Title : Arch Linux distribution maintenance program.
* Description: A menu driven bash script which provides updates, maintenance, 
backups and system checks for an Arch based linux distribution.
This script provides numerous tools 
to Arch Linux users. The program is menu-based and written in bash.
The program is mainly console text based but also uses dialog GUI's 
at a few points for directory and file selection.
A detailed list of the over 100 options and features is 
provided below in features section.
* Author: Gavin Lyons

Installation
-----------------------------------------------
cylon is installed by PKGBUILD on a Arch based Linux system
The PKGBUILD file is available in the AUR Arch user repository.
Install it using an AUR helper program  or installations instructions 
on Arch user repository page of Arch linux wiki
* AUR package name : cylon
* AUR maintainer : glyons
* AUR location: https://aur.archlinux.org/packages/cylon/


Options/Usage
-------------------------------------------
The program installs an icon in system application menus under system.
It can be also run in a terminal by typing cylon: 

cylon -[options]

Options(standalone cannot be combined):
* -h --help , Print cylon information and exit.
* -s --system , Print system information and exit
* -v --version  , Print version information and exit.
* -c --config  , Opens the cylon config file for editing and exit
* -d --default , Bleachbit system clean. 
This will execute options selected in bleachbit GUI or bleachbit config file.
* -b --bleachbit , Opens the bleachbit select menus 
* -m --maint , Runs Automatic system maintenance scan
This carries many of the menu functions in system maintenance menu in 
a single sweep, It will not change system just create report files.
* -u --update , Runs a full update report with various execution options.
Report provides Arch news rss reader & arch-audit vulnerable 
packages output CVE data(Common Vulnerabilities and Exposures) 
& number and type of updates available for all repos.
* -p --print print the package lists (REF1)
* -r --rss print arch news reader with option to fetch number of items.
* -z --delete display the AUR package removal dialog menu function.
* -l --lint shortcut to open rmlint wrapper.

Files and setup
-----------------------------------------
Cylon files  installed  by package 
build are listed below.

* /usr/bin/cylon (the main shell script)
* /usr/lib/cylon/modules/*_module (12 module files containing functions)
* /usr/share/doc/cylon/README.md
* /usr/share/doc/cylon/changelog.md
* /usr/share/licenses/cylon/LICENSE.md
* $HOME/.config/cylon/cylonCfg.conf (optional, user made, not installed)
* /usr/share/pixmaps/cylonicon.png (icon)
* /usr/share/applications/cylon.desktop (desktop entry file)
* /usr/share/man/man7/cylon.7 (manpage)

README.md is displayed to screen by a menu option on cylon info page.
Type "man cylon" to display manpage. 
The manpage is a truncated version of the readme file.

Config file: The user can create an optional config file, used mainly 
for custom system backup. If the user is not using the system backup 
or ccrypt menu functions the user does not need config file.
* NAME: cylonCfg.conf 
* PATH: 
```sh
$HOME/.config/cylon/cylonCfg.conf.
```
* SETTINGS:
"DestinationX" is the path for backups.
"gdrivedestX" is remote google drive directory file ID
(see gdrive readme for setup and how to get file id numbers)
and "gdriveSourceX" is the local directory source.
"rsyncsource" and "rsyncdest" provide the source and destination paths 
for rsync option in backup menu.
"myccfile" is a setting for ccrypt utility, 
a path to a default file for ease of use.
If config file missing the System uses hard-coded dummy defaults.
The config file can be edited from a main menu option or by option -c

cylonCfg.conf file setup example:
Just copy and paste this into file and change paths for your setup.

> Destination1="/run/media/$USER/Linux_backup"
> Destination2="/run/media/$USER/iomega_320"
> gdriveSource1="$HOME/Documents"
> gdriveSource2="$HOME/Pictures"
> gdriveSource3="$HOME/Videos"
> gdriveSource4="$HOME/.config"
> gdriveDest1="foo123456789"
> gdriveDest2="foo125656789"
> gdriveDest3="foo123666689"
> gdriveDest4="foo123662222"
> rsyncsource="$HOME/"
> rsyncDest="/run/media/$USER/Linux_backup/foo"
> myccfile="$HOME/TEST/test.cpt"

Output folder and environment variables
-------------------------------------
Most system output (logfiles, backups, downloads and updates etc) 
is placed at below path, unless otherwise specified on screen.
Output folders are created with following time/date stamp syntax HHMM-DDMONYY-X 
where X is output type i.e backup, update etc. The default path is:

```sh
$HOME/Documents/Cylon.
```

Optional Environment variable: $CYLONDEST
How to set example: 
```sh
export CYLONDEST="$HOME/.cache/cylon"
```

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
also "n/a" is displayed besides uninstalled options in menus.

gnu-netcat and openbsd-netcat peform same function, 
only 1 can be or needs to be installed, both included because of conflicts.

cower and pacaur are both AUR helpers you can install 
just cower or both depending on preference. pacaur wraps cower 
and needs it installed. 
The setting TargetDir in cower config file must not be used
cylon will check this and display warning.

gdrive readme for config https://github.com/prasmussen/gdrive
gdrive option syncs will Delete extraneous remote files as of V3.4-5

dialog should already be installed in an arch linux system installed by
the arch linux installation guide on wiki. If you install Arch some other way
It may not be there, so included as depends. expac is used a lot and will 
be already installed on many systems.

| Dependencies| Usage |
| ------ | ------ |
| dialog |  used to make GUIs menus (Non-optional) |
| expac |   used to create package lists (Non-optional) |
| ccrypt |  used for encrypting |
| bleachbit | for system clean and shredding |
| clamav |  for malware check |
| gnu-netcat | to check for internet connection | 
| openbsd-netcat | to check for internet connection |
| rkhunter | to check for rootkits |
| rmlint | to check for lint and duplicates | 
| rsync | for rsync backup function |
| lynis | system audit |
| inxi  | CLI system information script |
| htop | command line system information script |
| wavemon  | wireless network monitor |
| speedtest-cli  | testing internet bandwidth |
| Arch-audit | Uses data collected by the Arch CVE team |
| pacaur(AUR)  | for AUR helper functions |
| cower(AUR) | for AUR helper functions |
| gdrive(AUR) | to sync to google drive |
| lostfiles(AUR) | to scan for lostfiles |

Features and Functions 
----------------------

The program functions are divided into 6 main sections:
update, maintenance, backup, security, network and misc.

The update section is the core of the program and provides a wrapper for 
pacman, pacaur and cower. It provides an extension to cower 
to allow it to install and update packages. It also provides 
a full system update report function and various other options. 
The setting TargetDir in cower config file must not be used
cylon will check this and display warning.
The maintenance section provides a variety of scans and checks, it also 
a provides command line wrapper for rmlint and bleach-bit. 
The backup section provides a wrapper for gdrive program. as well as ability
to backup system using various tools.
The security section provides a wrapper for ccrypt and a extended launcher 
for various security tools as well as a password generator.
The network section provides various tools to check network and configuration.
Other misc functions include an option to edit config file, information menus for
system and cylon. Weather forecast and terminal launcher. NANO is used 
as default text editor for editing config files.

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
	* Remove foreign packages  menu
	
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
	* Remove foreign packages  menu
	
* Full System update 
	* Runs the same report that is called by cylon -u , see options section
	
* System maintenance menu
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
	* inxi - system information display with logging of results
	* Clean system with bleachbit
		* Preset option based on the same options as in the GUI 
		* Custom options involved for user to pick cleaners and options
			* preview
			* clean (without overwrite, BB checks the config in GUI).
			* clean + overwrite (with overwrite permanent deletion)
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
	* Option to launch htop - interactive process viewer
	 
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
		* Sync local directory to google drive (path 4)
		* List content of syncable directory
		* Google drive metadata, quota usage
		* List files
		* Get file info
		
* System security menu
	* Lynis system audit (summary of logfiles feature)
	* ClamAv anti-malware scan (Check for updates and logging feature)
	* RootKit hunter scan (check for updates feature)
	* ccrypt - encrypt and decrypt files:
		* config file path option for ease of use.
		* Encrypt a file 		     
		* Decrypt a file
		* Edit decrypted file
		* Change the key of encrypted file
		* View encrypted file	
	* password generator
	
* Network options
	* launch wavemon network monitor
	* Run speedtest-cli to measure bandwidth 
	with options for server list and file save
	* various misc network commands
	* firewall status and details check
	
* Option to open xterm terminal in new window

* Config file view/edit option.

* System and package information displays
	* Displays detailed information on system and package setup
	* Function also run by -s standalone option.

* Cylon information: 
	* Dependencies installation check, info and display readme file to screen 
	* Function can also run by option -h 

* 3 day weather forecast by wttr.in


(REF1): packages list referenced above
>All installed packages: pkglistQ.txt
>All native packages: pkglistQn.txt
>All explicitly installed packages: pkglistQe.txt
>All explicitly installed native packages that are
not direct or optional dependencies: pkglistQgent.txt
>All foreign installed packages: pkglistQm.txt
>All foreign explicitly installed packages: pkglistQme.txt
>All explicitly installed packages not in base nor base-devel with size"
and description: pkglistNonBase.txt
>All installed packages sorted by size: pkglistSize.txt
>All installed packages sorted by install date: pkglistDate.txt
>All .pacnew and .pacsave files on system. pacNewSaveFiles.txt

See Also
-----------
There are screenshots in the screenshot folder and 
various support documents in the documentation folder.

Bug reports and communication
-----------
If you should find a bug or you have any other query, 
please send a report.
Pull requests, suggestions for improvements
and new features welcome.
* Contact: Upstream repo at github site below or glyons66@hotmail.com
* Upstream repository: https://github.com/gavinlyonsrepo/cylon

History
------------------
* First Commit to AUR: v1.3-1 08-09-16
* Latest Version release : v4.0-1 26-05-17 
* See changelog.md for version control history

Copyright
---------
Copyright (C) 2016 G Lyons 
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public license published by
the Free Software Foundation, see LICENSE.md for more details
