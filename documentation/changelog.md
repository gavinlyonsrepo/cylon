# Version control:

### Version 1  010916  (first commit to AUR)

	* google drive function added 
	* Extra cower and pacman options added 
	* Options added for system backup function(dd and gdrive)
	* PKGBUILD display and readme install added
	* Config file added for custom backup paths
	* rootkithunter option 
	* Rmlint option.

### Version 2  021016 
	*.Added option for lostfiles, system info page.
	* Added cylon info page with check for optdepends
	* Added error handling for missing optdepends in the functions 
	* Changed menus from cat displays to select arrays with prompt. 
	* Added licence.md and changlog.md 
	* Added optdepends array to PKGBUILD. 
	* Added ccrypt & password generator options 
	* Added arch linux news feed option.
	* Changed location from $HOME of readme file + 
	* Added install of changlog to usr/share/doc/cylon
	* Added extra bleachbit functionality and options
	* Added extra gdrive functionality and options 
	* Added an rsync option(config file needs new options for rsync) 
	* Added new shred folder and files option. 

### Version 3.0-1 101216. 
	* pacman -Ql added
	* pacaur with 8 options added. 
	* xterm, inxi, lynis and htop options added, 
	* Options for linux command line arguments inputs added
	* systemd-analyze - Analyze system boot-up performance added to system check.
 
### Version 3.1-2 151216.
	* Added openbsd-netcat as optdepends due to conflict with gnu-netcat.
	* Added 3 new options to pacman menu 
	* Added 3 new options to pacaur 
	* Added 2 new options to cower 
	* Added two new runtime options -c and -u 

### Version 3.2-3 211216
	* Added manpage and system icon
	* Modules added, split functions into separate files 
	* Changed system maintenance routine to menu select

### Version 3.3-4 291216
	* Added "n/a" text to menu options for non installed packages,
	* Added old configuration file scan and Diskspace usage options
	* new icon added. 
	* Systemctl status show option added.

### Version 3.4-5 250317
	* ccrypt file setting added to config file called myccfile,
	* add -d option for bleachbit system clean. Use the options set in the GUI/file.
	* changes to -u option, RSS feed added
	* rmlint menu 6 extra options added.
	* gdrive change --delete-extraneous option added to Sync local directory 

### Version 3.5-6 050417
	* Uninstall AUR packages menu function added to cower and pacaur menus
	* Added extra gdrive option, requires two new option in config file for use.
	* Changed input for file/directory paths to a dialog GUI option 
	* Added new lists options  to package lists options. 
	* pactree and pactree -r options added in pacman.
	* Arch-Audit in cylon -u option now consists of two options -q & -u.
	* Arch-Audit was moved from AUR to main repos SW changed to reflect this.

### Version 3.6-7 + 3.6.1-8 200417 
	* packages dialog and expac added as depends
	* new file misc_module added (coding optimisation)
	* cower -dc download only option added + AUR comment reader
	* package list function updated now 9 list generated.
	* warning check added for setting of TargetDir in cower config
	* new options added and others moved to System maintenance menu
	* Added environmental variable user can now set output directory path.
	
### Version 3.7-9 050517
	* corrected minor issue of no pause at end after system update run 
	* Changed menu layout added system security option etc
	* added extra drive option to config file now 4 syncs options.
	* added -b flag to run bleachbit wrapper
	* added -m flag to run a auto scan of most maintenance menu functions.
	* xterm terminal now opens on cylon program output folder path.
	
### Version 4.0-1 270517
	* Various code optimizations 
	* added menu to update function
	* added -p flag print the package lists 
	* added -r flag print arch news rss reader 
	* added a user input count to Arch news Rss reader for # of items to fetch
	* added -z flag display the AUR package removal dialog menu function.
	* added -l flag shortcut to open rmlint wrapper.
	* change AUR package delete menu  to include all foreign packages
	* added pacnew list to package list function
	* added CYLONDEST check on cylon information page
	* added more data to system information page

### Version 4.1-2 280617
	* Now using $EDITOR variable to pick text editor
	* Loop the bleachbit options menu -b for user convenance.
	* New Clamavscan options and configfile setting.
	* Two new maintenance options, find inodes usage and find biggest files
	* Ascii art added 
	* 3 new pacman option added(view log, optimise and paccache -ruk0) 
	* Auditing SUID/SGID Files added to security + chage -l option
	* Various new network options added.

### Version 4.2-3 200717
	* Package list expanded from 10 to 20 items
	* Extra information added to system display.
	* Pull request by "uros-stegic" to fix typo on system display page added
	* Dependency array code optimisation to HelpFunc instead of long list
	* prompt and information display for orphan delete option added
	* CowerFunc new option to search AUR packages by orphan maintainer.
	* Ascii art placed in function AsciiArtFunc.

### Version 4.3-4 / 4-3-1-5 : 031017
	* Added optional environmental variable for config file location CYLON_CONFIG.
	* changed 6 menus so they loop until user return.
	* return codes added

### Version 5.0-1 / 5.0.1-2 : 031117 / 201117
	* Four new package lists added to package list generator.
	* New optional environment variable to allow for no colour "CYLON_COLOR_OFF".
	* System information display optimisations and more information.
	* New system maintenance option added "List All Open Files", htop removed as dependency.
	* Option to backup GPT partition added in addition to MBR. also rsync option optimised.
	* New command line option added "notify -n" to enable desktop notifications.

### Version 5.1-3 100218
	* Optdepends AUR helper "Cower" replaced by "Auracle", as cower is obsolete see here.
	* https://www.reddit.com/r/archlinux/comments/6ktsqg/auracle_the_next_generation_of_cower/
	* package list generator size increased from 24 to 25.
	
### Version 5.2-4 170218
	* Optdepends AUR helper "pacaur" replaced by "trizen", as pacaur is now unmaintained.

