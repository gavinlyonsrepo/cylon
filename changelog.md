#Version control:
* version 1.3-1  020916 google drive function added (first commit to AUR)
* version 1.4-2  080916 extra cower options added 
* version 1.5-3  100916 options added for system backup function(dd and gdrive)
* version 1.6-4  120916 Msgfunc, PKGBUILD display and readme install added
* version 1.7-5  140916 Config file added for custom backup paths
* version 1.8-6  180916 added rootkithunter option + update counters
* version 1.9-7  250916 added rmlint option. consolidated menu layout , added more pacman options
* version 2.0-8  011016 added option for lostfiles, system info page,various minor optimisations

* version 2.1-9  051016 added cylon info page with check for optdepends, added error handling for 
missing optdepends in the functions ,changed menus from cat displays to select arrays with prompt. 
Added licence.md and changlog.md, added optdepends array to PKGBUILD. 

* version 2.2-1  091016 added ccrypt & password generator options, 
added arch linux news feed option.
network checks optimisations, changed location from $HOME of readme file + 
added install of changlog to usr/share/doc/cylon


* version 2.3-2  201016 Added extra bleachbit functionality and options , 
added extra gdrive functionality and options, added an rsync option
(config file needs new options for rsync) 
added new shred  folder and files option. 
merged lostfiles function and menu option with system check

* version 3.0-1 101216. changed dir name output. pacman -Ql added
pacaur with 8 options added. inxi, lynis and htop added, 
weather forecast added.  Options for linux command line arguments 
passed to program on call added 3 of, help, system info, and version.
systemd-analyze - Analyze system boot-up performance added to system check.
open terminal added. 

* version 3.1-2 201216.
Added openbsd-netcat as optdepends due to conflict with gnu-netcat.
Added 3 new options to pacman menu ((arch-audit) (pacman -Qkk) 
and edit pacman conf)
added 3 new options to pacaur (edit config file, list packages, pacaur -Syu)
added 2 new options to cower (list packages, edit config file)
changed file directory name output syntax
Added firewall status check to Network menu
Added runtime options -c edit config file
Added runtime options -u update routine with optional execute

* version 3.2-3 271216
Added manpage, system icon added , modules added, split functions into separate 
files, changed system maintence rountine to menu select rather 
than pass through all options in one run.

* version 3.3-4 291216
added "n/a" text to menu options for non installed packages,
added old configuration file scan and Diskspace usage  options to system 
maintenance. inxi moved to separate option.
new icon added.  systemctl status show option added.

* version 3.4-5 250317
ccrypt file setting added to config file called myccfile,
add -d option for bleachbit system clean. Use the options set in the GUI/file.
changes to -u option RSS feed added and arch-audit chnaged from -q to -u.
rmlint menu 6 extra options added.
gdrive change --delete-extraneous option added to Sync local directory to drive
passive warning added not to use targetDir setting for cower and pacaur  
