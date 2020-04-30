
![title](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/screenshots/cylon_ascii.png)

Overview
--------------------------------------------
* Name: cylon 
* Title : Arch Linux distribution maintenance program.

* Description: 
A TUI(terminal user interface) which provides updates, maintenance, 
and backups for an Arch based linux distribution.
This program provides numerous tools to Arch Linux users. 
The program is menu-based and written in bash.
It is mainly text based  but also uses dialog GUI's 
at a few points mainly for directory and file selection.
It can also display desktop notifications. 
A detailed list of the dozens of options is 
provided below in features section.

* Main Author: Gavin Lyons
* Communication: [Upstream repository](https://github.com/gavinlyonsrepo/cylon) or email at glyons66@hotmail.com
* History: See [changelog.md](documentation/changelog.md) in documentation section for version control history
* Github Contributors: "binaryplease"  "uros-stegic" 
* Copyright: Copyright (C) 2016 Gavin Lyons , see [LICENSE.md](documentation/LICENSE.md) in documentation section.

Table of contents
---------------------------

  * [Overview](#overview)
  * [Installation](#installation)
  * [Usage](#usage)
  * [Files and setup](#files-and-setup)
  * [Output and environment variables](#output-and-environment-variables)
  * [Dependencies](#dependencies)
  * [Features](#features)
  * [Screen Shots](#screenshots)
 
Installation
-----------------------------------------------
cylon is installed by PKGBUILD on a Arch based Linux system.
The PKGBUILD file is available in the AUR - Arch user repository.
Install it using an AUR helper program  or installations instructions 
on Arch user repository page of Arch linux wiki.
The program will work on any arch based system. Arch, manjaro, endeavourOS etc.
* AUR package name : cylon
* AUR maintainer : glyons
* AUR location: https://aur.archlinux.org/packages/cylon/

Usage
-------------------------------------------
The program installs an icon in system application menus under system.

![icon](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/desktop/cylonicon.png)

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
| -n --notify | Display a desktop notifications with update information, also gives some terminal output |

Files and setup
-----------------------------------------
Cylon files installed by the package 
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
| $HOME/.config/cylon/cylonCfg.conf | config file, optional, user made, NOT installed |

README.md is displayed to screen by a menu option on cylon info page.
Type "man cylon" to display manpage. 
The manpage is a truncated version of the readme file.
More information on the modules files can be found in modules_info.md
in documentation folder.

Config file: The user can create an optional config file, used  
for custom system backup. If the user is not using the system backup option 
the user does NOT need config file.

* NAME: cylonCfg.conf 
* PATH: $HOME/.config/cylon/cylonCfg.conf
This Path can be overwritten by environmental variable see next section.
* SETTINGS:
"DestinationX" is the path for backups.
"rsyncsource" and "rsyncdest" provide the source and destination paths 
for rsync option in backup menu.
 
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
> rsyncsource="$HOME/"
>
> rsyncDest="/run/media/$USER/Linux_backup/foo"
>

Packages files list can be viewed in package_lists.md, which is in the sub-folder documentation of repository. 
The package files list is a collection of 26 lists describing the system.

In the repository [documentation](documentation) folder, there are various support documents.

| File Name | description |
| ------ | ------ |
| changelog.md | version control history file |
| license.md | copyright details file |
| cylon.7 | man page which is truncated version of readme.md |
| cylonCfg.conf | A dummy copy of config file for user setup convenience |
| modules_info.md | An overview of the modular library files and the functions |
| package_lists.md | An overview of the packages files list generated by program |
| features_info.md | More detailed information for some features |


Output and environment variables
-------------------------------------

CYLONDEST, CYLON_CONFIG and CYLON_COLOR_OFF are three optional custom environmental variables 
used by program. If variable CYLONDEST and CYLON_CONFIG are not set or do not exist, 
cylon uses the default path. CYLON_COLOR_OFF is used for turning off colored text output.
For information on setting environment variables see arch linux wiki.

CYLONDEST

Most system output (logfiles, downloads and updates etc) 
is placed at below path, unless otherwise specified on screen.
Output folders are created with following time/date stamp syntax HHMM-DDMONYY-X 
where X is output type i.e download, update etc. The default path is:
```sh
$HOME/.cache/cylon
```

This optional Environment variable is provided for users
who wish to use different destination path for program output folder.

CYLON_CONFIG

The default path for config file is 
```sh
$HOME/.config/cylon/cylonCfg.conf
```

This optional Environment variable is provided for users
who wish to use different destination path for program config file.

CYLON_COLOR_OFF

if it does not exist or is not set cylon uses colored output. 
This optional Environment variable is provided for users
who wish to see no colour in terminal. Set it equal to "on"

EDITOR

"nano" is used as default text editor for editing config files 
IF $EDITOR user environment variable is not set. 
```sh
$EDITOR
```

Dependencies
-------------------------------------
Some functions require dependencies packages to be installed.
There are three dependencies and the rest are optional dependencies.
The optional dependencies are left to user discretion.
Software will check for missing dependencies and report if user 
tries to use a function which requires a missing one.
Software will display installed dependencies packages on cylon info page.
also "n/a" is usually displayed besides uninstalled options in menus.

gnu-netcat and openbsd-netcat peform same function, 
only 1 can be or needs to be installed, both included because of conflicts.
There are used to check that network is "up" at various points in program.

Auracle and trizen are both AUR helpers you can install 
one or both depending on preference. Auracle is a more minimalist helper. 
trizen is more fully featured. 
Auracle is used for -u and -n functions, plus step 24 of the package list maker
Auracle is new and still in development hence the -git extension.

libnotify should be installed on the vast majority of Arch systems already.

dialog should already be installed in an arch linux system installed by
the arch linux installation guide on wiki. If you install Arch some other way
It may not be there, so included as depends. 

expac is used a lot and will be already installed on many systems. 

pacman_contrib contains numerous tools(checkupdates pacache etc)related to pacman , used to be part 
of pacman before version 5.0. In cylon 5.3 added as a dependency.

| Non-Optional Dependencies | Usage |
| ------ | ------ |
| dialog | used to make file select menus  |
| expac |  used to create package lists |
| pacman-contrib | Misc pacman related tools |

| Optional Dependencies | Usage |
| ------ | ------ |
| libnotify | used for desktop notifications | 
| bleachbit | for system clean and shredding |
| netcat | to check for internet connection (either gnu or openbsd) | 
| rmlint | to check for lint and duplicates | 
| rsync | for rsync backup function |
| Arch-audit | Uses data collected by the Arch CVE team |
| lostfiles | to scan for lostfiles |
| trizen(AUR)  |  AUR helper  |
| auracle-git(AUR) |  AUR helper  |

Features
----------------------

The program functions are divided into 6 sections:
update, maintenance, backup, security, network and miscellaneous.

The update section is the core of the program and provides a wrapper for 
pacman, trizen and auracle. It provides an extension to auracle
to allow it to install and update packages. It also provides 
a full system update report function and various other options. 

The maintenance section provides a variety of scans and checks, it also 
a provides command line wrapper for rmlint and bleach-bit. 

The backup section provides ability to backup system using various tools.

Other misc functions include an option to edit config file, information menus for
system and cylon. Terminal launcher at path of cache output. 

There is more detailed information in documentation 
folder, see "see also" section.

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
	* Write installed package lists to files 
	* Remove all packages not required as dependencies 
	* Back-up the local pacman database  
	* Arch news rss reader 
	* arch-audit gather CVE data
	* List a dependency tree of a package with pactree
	* Show packages that depend on a package with pactree 
	* Edit pacman config file
	* View pacman log
	* optimise pacman 
	
* AUR helper auracle options 
	* Check arch url and for AUR updates  ( NO downloads)
	* Get Information for AUR package 
	* Search for AUR package
	* Download AUR package and install
	* Download AUR package no install
	* Sync and download AUR packages, i.e. update AUR packages on system. 
	* Display AUR packages with no Maintainer
	* Display Foreign packages not in AUR
	* Write installed package lists to files 
	* Read AUR Package comments
	* Desktop and terminal notifications same as cylon -n option
	* Remove foreign packages menu
	
* AUR helper trizen options
	* Check arch url and for AUR updates ( NO downloads)
	* Search for AUR package
	* Get Information for AUR package 
	* Update AUR packages
	* Download build and install AUR package
	* Download and build only
	* Download only
	* Delete trizen clone dir files. default = /tmp/trizen-$USER
	* Edit trizen config file $HOME/.config/trizen/trizen.conf
	* Update all packages in all repositories, trizen -Syu
	* Write installed package lists to files 
	* trizen statistics display page
	* Remove foreign packages menu
	* Read AUR Package comments
	* Display the AUR packages maintained by a given user
	* Display the PKGBUILD of a given AUR package

	
* Full System update 
	* Runs the same report that is called by cylon -u, see usage section, uses auracle
	
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
	* Display hardware information
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
	* List all open files
	 
**3: System backup section**
* System backup
	* Optional destination path as defined in script or custom path
	* Make copy of  MBR or GPT primary partition with dd
	* Make a copy of etc dir
	* Make a copy of home dir
	* Make tarball of all except tmp dev proc sys run
	* Make copy of package lists 
	* Rsync backup option 
	
**4: System security section**
* System security menu	
	* password generator
	* Audit SUID/SGID Files in system 
	* check user password expiry information

**5: Network options section**
* Network options
	* Display real-time wifi information
	* various miscellaneous networking commands
	* firewall status and details check
	
**6: Miscellaneous section**
* Option to open terminal at output folder path in new window

* Config file view/edit option.

* System information display
	* Displays detailed information on system and package setup
	* Function also run by -s standalone option.

* Cylon information: 
	* Dependencies installation check, info and display readme file to screen 
	* Function can also run by option -h 


Return codes

* 0 - Normal non-error controlled exit.
* 2 - Error occurred and was handled by exithandlerFunc function. 


Screen Shots
-------------------------

Main Menu

![main menu](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/screenshots/main_menu.png)

Arch News

![Arch News](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/screenshots/arch_news_RSS.png)

Bleach bit CLI

![BB](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/screenshots/bleachbit_CLI_wrapper.png)

Desktop notification

![Desktop](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/screenshots/desktop_notification.jpg)

Pacman options menu

![Pacman](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/screenshots/pacman_utilities_menu.jpg)

Remove foreign packages menu 

![f menu](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/screenshots/remove_foreign_pkgs_menu.png)
