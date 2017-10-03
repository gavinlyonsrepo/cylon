
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
* Main Author: Gavin Lyons

Table of contents
---------------------------

  * [Overview](#overview)
  * [Table of contents](#table-of-contents)
  * [Installation](#installation)
  * [Usage](#usage)
  * [Files and setup](#files-and-setup)
  * [Output and environment variables](#output-and-environment-variables)
  * [Dependencies](#dependencies)
  * [Features](#features)
  * [Return codes](#return-codes)
  * [See Also](#see-also)
  * [Communication](#communication)
  * [History](#history)
  * [Copyright](#copyright)

Installation
-----------------------------------------------
cylon is installed by PKGBUILD on a Arch based Linux system.
The PKGBUILD file is available in the AUR - Arch user repository.
Install it using an AUR helper program  or installations instructions 
on Arch user repository page of Arch linux wiki.
The program will work on any arch based system. Arch, manjaro, antergos etc.
* AUR package name : cylon
* AUR maintainer : glyons
* AUR location: https://aur.archlinux.org/packages/cylon/

Usage
-------------------------------------------
The program installs an icon in system application menus under system.
It can be also run in a terminal by typing cylon: 

cylon -[options]

Options list (standalone cannot be combined):

| Option          | Description     |
| --------------- | --------------- |
| -h --help | Print cylon information and exit |
| -s --system | Print system information and exit |
| -v --version  | Print version information and exit |
| -c --config   | Opens the cylon config file for editing and exit |
| -d --default  | Bleachbit system clean , this will execute options selected in bleachbit GUI or bleachbit config file |
| -b --bleachbit  | Opens the bleachbit select menus |
| -m --maint | Runs Automatic system maintenance scan This carries many of the menu functions in system maintenance menu in a single sweep, It will not change system just create report files|
| -u --update     | Runs a full update report with various execution options. Report provides Arch news rss reader & arch-audit vulnerable packages output CVE data(Common Vulnerabilities and Exposures) & number and type of updates available for all repos |
| -p --print | print the package lists (REF1) |
| -r --rss | print arch news reader with option to fetch number of items |
| -z --delete     | display the AUR package removal dialog menu function |
| -l --lint | shortcut to open rmlint wrapper menu |

Files and setup
-----------------------------------------
Cylon files installed by package 
build are listed below:

| File Path | Description |
| ------ | ------ |
| /usr/bin/cylon | The main shell script |
| /usr/lib/cylon/modules/*_module |12 library files containing functions |
| /usr/share/doc/cylon/readme.md |Help file |
| /usr/share/doc/cylon/changelog.md | History file |
| /usr/share/licenses/cylon/license.md | copyright file |
| /usr/share/pixmaps/cylonicon.png | cylon icon |
| /usr/share/applications/cylon.desktop | desktop entry file |
| /usr/share/man/man7/cylon.7 | manpage |
| $HOME/.config/cylon/cylonCfg.conf | config file, optional, user made, not installed |

README.md is displayed to screen by a menu option on cylon info page.
Type "man cylon" to display manpage. 
The manpage is a truncated version of the readme file.
More information on the modules files can be found in modules_info.md
in documentation folder.

Config file: The user can create an optional config file, used mainly 
for custom system backup. If the user is not using the system backup option 
or ccrypt menu function or custom clamav scan option,
the user does not need config file.
* NAME: cylonCfg.conf 
* PATH: ``` $HOME/.config/cylon/cylonCfg.conf ```
This Path can be overwritten by environmental variable see next section.
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
alternatively a config file template with dummy values is in documentation folder
of the repository.

> Destination1="/run/media/$USER/Linux_backup"
>
> Destination2="/run/media/$USER/iomega_320"
>
> gdriveSource1="$HOME/Documents"
>
> gdriveSource2="$HOME/Pictures"
>
> gdriveSource3="$HOME/Videos"
>
> gdriveSource4="$HOME/.config"
>
> gdriveDest1="foo123456789"
>
> gdriveDest2="foo125656789"
>
> gdriveDest3="foo123666689"
>
> gdriveDest4="foo123662222"
>
> rsyncsource="$HOME/"
>
> rsyncDest="/run/media/$USER/Linux_backup/foo"
>
> myccfile="$HOME/TEST/test.cpt"
>
> clamav_customdir="$HOME/Downloads/foo"

Output and environment variables
-------------------------------------

CYLONDEST and CYLON_CONFIG are two custom environmental variables used by program.
If variable CYLONDEST and CYLON_CONFIG are not set or do not exist, 
cylon uses the default path.


CYLONDEST

Most system output (logfiles, downloads and updates etc) 
is placed at below path, unless otherwise specified on screen.
Output folders are created with following time/date stamp syntax HHMM-DDMONYY-X 
where X is output type i.e download, update etc. The default path is:
```sh
$HOME/Documents/Cylon
```
Optional Environment variable: $CYLONDEST
How to set example: 
```sh
export CYLONDEST="$HOME/.cache/cylon"
```
This optional Environment variable is provided for users
who wish to use different destination path for program output folder.


CYLON_CONFIG

The default path for config file is 
```sh
$HOME/.config/cylon/cylonCfg.conf
```
Optional Environment variable: $CYLON_CONFIG
How to set example: 
```sh
export CYLON_CONFIG="$HOME/TEST/cylon/config"
```
This optional Environment variable is provided for users
who wish to use different destination path for program config file.


EDITOR

"nano" is used as default text editor for editing config files 
IF $EDITOR user environment variable is not set. 
```sh
$EDITOR
```

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
gdrive readme for config https://github.com/prasmussen/gdrive ,
gdrive option syncs will Delete extraneous remote files as of V3.4-5.
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
| htop  | interactive process viewer |
| inxi  | CLI system information script |
| wavemon  | wireless network monitor |
| speedtest-cli  | testing internet bandwidth |
| Arch-audit | Uses data collected by the Arch CVE team |
| pacaur(AUR)  | for AUR helper functions |
| cower(AUR) | for AUR helper functions |
| gdrive(AUR) | to sync to google drive |
| lostfiles(AUR) | to scan for lostfiles |

Features
----------------------

The program functions are divided into 6 sections:
update, maintenance, backup, security, network and miscellaneous.
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
The security section provides a wrapper for ccrypt and an extended launcher 
for various security tools as well as a password generator.
The network section provides various tools to check network and configuration.
Other misc functions include an option to edit config file, information menus for
system and cylon. Weather forecast and terminal launcher. 

**1: System update section**
* pacman options
	* Check for updates (no download)
	* Upgrade packages
	* Display extensive information for package in database
	* Install Package
	* Search for packages in the database
	* Remove Package
	* Search for already installed packages
	* Display extensive information for installed package 
	* List all files owned by a given package
	* Verify packages(option for one or all)
	* Prune older packages from cache with paccache 
	* Prune all uninstalled packages from cache with paccache
	* Write installed package lists to files (REF1)
	* Remove all packages not required as dependencies 
	* Back-up the local pacman database  
	* Arch news rss reader 
	* arch-audit gather CVE data
	* List a dependency tree of a package with pactree
	* Show packages that depend on a package with pactree 
	* Edit pacman config file
	* View pacman log
	* optimise pacman 
	
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
	* Runs the same report that is called by cylon -u , see usage section
	
**2: System maintenance section**
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
	* Find system inode usage
	* Find largest files
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
	 
**3: System backup section**
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
		
**4: System security section**
* System security menu
	* Lynis system audit (summary of logfiles feature)
	* ClamAv anti-malware scan 
		*malware testfile fetch and scan function
		*Check for updates and logging feature
		*Various options for scan location and type.
	* RootKit hunter scan (check for updates feature)
	* ccrypt - encrypt and decrypt files:
		* config file path option for ease of use.
		* Encrypt a file 		     
		* Decrypt a file
		* Edit decrypted file
		* Change the key of encrypted file
		* View encrypted file	
	* password generator
	* Audit SUID/SGID Files in system 
	* check user password expiry information

	
**5: Network section**
* Network options
	* launch wavemon network monitor
	* Run speedtest-cli to measure bandwidth 
	with options for server list and file save
	* various miscellaneous networking commands
	* firewall status and details check
	
**6: Miscellaneous section**
* Option to open xterm terminal at output folder path in new window

* Config file view/edit option.

* Computer information display
	* Displays detailed information on system and package setup
	* Function also run by -s standalone option.

* Cylon information: 
	* Dependencies installation check, info and display readme file to screen 
	* Function can also run by option -h 

* 3 day weather forecast by wttr.in


Return codes
---------------------
* 0 - Normal non-error controlled exit.
* 1 - Error occurred and was handled by exithandlerFunc function.


See Also
-----------
(REF1): Packages files list referenced above at marker REF1 can be viewed 
in package_lists.md, which is in the sub-folder documentation of repository. 
The package files list is a collection of 20 plus lists describing the system.

There are screenshots in the repository screenshot folder and 
various support documents in the repository documentation folder.

Communication
-----------
If you should find a bug or you have any other query, 
please send a report.
Pull requests, suggestions for improvements
and new features welcome.
* Contact: Upstream repo at github site below or glyons66@hotmail.com
* Upstream repository: https://github.com/gavinlyonsrepo/cylon

History
------------------
* First Commit to AUR: version 1.3-1 08-09-16
* Latest Version release : version 4.3-4 03-10-17 
* See changelog.md in documentation section for version control history
* Contributors: "binaryplease"  "uros-stegic" 
 
Copyright
---------
Copyright (C) 2016 Gavin Lyons 
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public license published by
the Free Software Foundation, see LICENSE.md in documentation section 
for more details
