﻿
![title](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/documentation/screenshots/cylon_ascii.png)

Overview
--------------------------------------------
* Name: cylon 
* Title : Arch Linux distribution maintenance program.

* Description: 

A TUI(terminal user interface) which provides updates and maintains 
an Arch based linux distribution.
This program provides numerous tools to Arch Linux users. 
The program is menu-based and written in bash.
It is mainly text based but also uses dialog GUI's 
at a few points mainly for directory and file selection.
It can also display desktop notifications. 
A detailed list of the dozens of options is 
provided below in features section.

* Main Author: Gavin Lyons

Table of contents
---------------------------

  * [Overview](#overview)
  * [Installation](#installation)
  * [Usage](#usage)
  * [Files and setup](#files-and-setup)
  * [Environment variables](#environment-variables)
  * [Dependencies](#dependencies)
  * [Features](#features)
  * [Screen Shots](#screen-shots)
 
Installation
-----------------------------------------------
cylon is installed by PKGBUILD on a Arch based Linux system.
The PKGBUILD file is available in the AUR - Arch user repository.
Install it using an AUR helper program  or installations instructions 
on Arch user repository page of Arch linux wiki.
The program should work on most arch based distributions. Arch, Manjaro, EndeavourOS etc.
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
| -u --update | Runs a full update report with various execution options. Report provides Arch news rss reader & arch-audit vulnerable packages output CVE data(Common Vulnerabilities and Exposures) & number and type of updates available for all repos |
| -p --print | print the package lists (REF1) |
| -r --rss | print arch news reader  |
| -z --delete | display the AUR package removal dialog menu function |
| -l --lint | shortcut to open rmlint wrapper menu |
| -n --notify | Display a desktop notifications with update information, also gives some terminal output |

Files and setup
-----------------------------------------
Cylon files installed by the package 
build are listed below:

| File Path | Description |
| ------ | ------ |
| /usr/bin/cylon | The main shell script |
| /usr/lib/cylon/modules/*_module | library files containing functions |
| /usr/share/doc/cylon/readme.md | Help file |
| /usr/share/man/man7/cylon.7 | manpage |
| /usr/share/licenses/cylon/license.md | copyright file |
| /usr/share/pixmaps/cylonicon.png | cylon icon |
| /usr/share/applications/cylon.desktop | desktop entry file |


README.md is displayed to screen by a menu option on cylon info page.
Type "man cylon" to display manpage. 
More information on the modules files can be found in modules_info.md
in documentation folder.
In the repository [documentation](documentation/help) folder, 

| File Name | description |
| ------ | ------ |
| cylon.7 | man page which is truncated version of readme.md |
| cylonCfg.conf | A dummy copy of config file for user setup convenience |
| modules_info.md | An overview of the modular library files and the functions |
| package_lists.md | An overview of the packages files list generated by program |
| features_info.md | More detailed information for some features |

Config file: config file is created and populated( hard-coded dummy defaults.) 
by software if it does not exist on startup . 
It contains a number of global variables/settings
This Path can be overwritten by environmental variable see next section.
The config file can be edited from a main menu option or by option -c
Config file settings: 

| Variable Name | Description | Default |
| ------ | ------ | ------ |
| CYLON_RSS_NUM | Number or arch news RSS items to fetch | 2 |
| CYLON_RSS_URL| Arch news URL |  https://archlinux.org/feeds/news/ |
| CYLON_UPDATE_CHOICE| Auto sys update 1=main only = 2=all 3=AUR only | 1 |

Environment variables
-------------------------------------

| Name | Description | Default |
| ------ | ------ | ------ |
| CYLONDEST | Cylon output path | $HOME/.cache/cylon |
| CYLON_CONFIG|  config file path  | $HOME/.config/cylon/cylonCfg.conf |
| CYLON_COLOR_OFF | if it does not exist or is not set cylon uses colored text | Color is on |
| EDITOR | Sets text editor (system EV) | Nano text editor |

Dependencies
-------------------------------------
Some functions require dependencies packages to be installed.
There are three dependencies and the rest are optional dependencies.
The optional dependencies are left to user discretion.
Software will check for missing dependencies and report if user 
tries to use a function which requires a missing one.
Software will display installed dependencies packages on cylon info page.
also "n/a" is usually displayed besides uninstalled options in menus.

gnu-netcat and openbsd-netcat perform same function, 
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
pacman_contrib contains numerous tools(checkupdates pacache etc)related to pacman.

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
| Arch-audit | Uses data collected by the Arch CVE team |
| lostfiles | to scan for lostfiles |
| trizen(AUR)  |  AUR helper  |
| auracle-git(AUR) |  AUR helper  |

Features
----------------------

The update section provides a wrapper for 
pacman, trizen and auracle. It provides an extension to auracle
to allow it to install and update packages. It also provides 
a full system update report function and various other options. 
The maintenance section provides a variety of scans and checks, it also 
a provides command line wrapper for rmlint and bleach-bit. 
Other misc functions include an option to edit config file, information menus for
system and cylon. 
Output folders are created with following time/date stamp syntax DDMONYY-HHMM-X 
where X is output type i.e download, update etc

**System update section**
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
	
**System maintenance section**

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
	
* System maintenance menu Two
	* password generator
	* Audit SUID/SGID Files in system 
	* check user password expiry information
	* Display real-time wifi information
	* various miscellaneous networking commands
	* firewall status and details check
	
**Miscellaneous section**

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

![main menu](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/documentation/screenshots/main_menu2.png)

Arch News

![Arch News](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/documentation/screenshots/arch_news_RSS.png)

Bleach bit CLI

![BB](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/documentation/screenshots/bleachbit_CLI_wrapper.png)

Desktop notification

![Desktop](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/documentation/screenshots/desktop_notification.jpg)

Pacman options menu

![Pacman](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/documentation/screenshots/pacman_utilities_menu.jpg)

Remove foreign packages menu 

![f menu](https://raw.githubusercontent.com/gavinlyonsrepo/cylon/master/documentation/screenshots/remove_foreign_pkgs_menu.png)
