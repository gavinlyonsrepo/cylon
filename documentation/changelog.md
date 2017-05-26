#Version control:
* version 1  010916  (first commit to AUR)
	* google drive function added 
	* Extra cower and pacman options added 
	* Options added for system backup function(dd and gdrive)
	* PKGBUILD display and readme install added
	* Config file added for custom backup paths
	* rootkithunter option 
	* Rmlint option.

* version 2  021016 
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

* version 3.0-1 101216. 
	* pacman -Ql added
	* pacaur with 8 options added. 
	* xterm, inxi, lynis and htop options added, 
	* Options for linux command line arguments inputs added
	* systemd-analyze - Analyze system boot-up performance added to system check.
 
* version 3.1-2 151216.
	* Added openbsd-netcat as optdepends due to conflict with gnu-netcat.
	* Added 3 new options to pacman menu 
	* Added 3 new options to pacaur 
	* Added 2 new options to cower 
	* Added two new runtime options -c and -u 

* version 3.2-3 211216
	* Added manpage and system icon
	* Modules added, split functions into separate files 
	* Changed system maintenance routine to menu select

* version 3.3-4 291216
	* Added "n/a" text to menu options for non installed packages,
	* Added old configuration file scan and Diskspace usage options
	* new icon added. 
	* Systemctl status show option added.

* version 3.4-5 250317
	* ccrypt file setting added to config file called myccfile,
	* add -d option for bleachbit system clean. Use the options set in the GUI/file.
	* changes to -u option, RSS feed added
	* rmlint menu 6 extra options added.
	* gdrive change --delete-extraneous option added to Sync local directory 

* version 3.5-6 050417
	* Uninstall AUR packages menu function added to cower and pacaur menus
	* Added extra gdrive option, requires two new option in config file for use.
	* Changed input for file/directory paths to a dialog GUI option 
	* Added new lists options  to package lists options. 
	* pactree and pactree -r options added in pacman.
	* Arch-Audit in cylon -u option now consists of two options -q & -u.
	* Arch-Audit was moved from AUR to main repos SW changed to reflect this.

* version 3.6-7 + 3.6.1-8 200417 
	* packages dialog and expac added as depends
	* new file misc_module added (coding optimisation)
	* cower -dc download only option added + AUR comment reader
	* package list function updated now 9 list generated.
	* warning check added for setting of TargetDir in cower config
	* new options added and others moved to System maintenance menu
	* Added environmental variable user can now set output directory path.
	
* version 3.7-9 050517
	* corrected minor issue of no pause at end after system update run 
	* Changed menu layout added system security option etc
	* added extra drive option to config file now 4 syncs options.
	* added -b flag to run bleachbit wrapper
	* added -m flag to run a auto scan of most maintenance menu functions.
	* xterm terminal now opens on cylon program output folder path.
	
* version 4.0-1 270517
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
