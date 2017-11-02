Features information
-------------

This file provides extra information for some features 
that are not fully explained on screen or in the readme/man page.
This document is newly created in version 4.3.
The numbers in sub-menus below represent the number menu options on screen.

NOTE: Some sections are not complete and file is a work in progress.

**1: System update section**
* pacman options
	* see "man pacman" for more details
	* 11 12 The paccache script, is provided by the pacman package itself.
	* 13 The command to delete orphans is sudo pacman -Rns $(pacman -Qtdq)
	* 15 The pacman database is located at path /var/lib/pacman/local
	* 16 The Arch linux news feed is fetched from this url https://www.archlinux.org/feeds/news/ 
by a Curl command and parsed using awk and sed.
	* 18 pactree - package dependency tree viewer, A tool installed as part of pacman
	* 19 pacman config file is located at etc/pacman.conf
	* 20 pacman log is located at /var/log/pacman.log
	* 21 pacman-optimize is another tool included with pacman for 
improving database access speeds. pacman stores all package information in a collection of small files, 
one for each package. Improving database access speeds reduces the time taken in database-related tasks, 
e.g. searching packages and resolving package dependencies.  See pacman tips/tricks in Arch wiki for more information.

* cower options
	* see "man cower" for more details
	* Downloads and updates are downloaded to the Output folders as defined in 
"Output and environment variables" section of readme.md. The setting "TargetDir" in cower config file must not be used
cylon will check this and display warning.
	* 4 The optional install after download consists of a display of the PKGBUILD
and prompt to install or not. 
	* 5 After update command, Cylon checks if output directory has child directories
to see if there is an update downloaded, Next it offers to view PKGBUILD of any updates
and finally asks do you want to install them. If you do not want to install some of the updates
for some reason you can manually delete their folder from output folder before this point.
	* 9 Config file
cower honors a config file which will be looked for first at:
$XDG_CONFIG_HOME/cower/config
and falling back to: $HOME/.config/cower/config
A documented example config file can be found at
/usr/share/doc/cower/config.
	* 10 The dialog package is used to create a GUI menu containing all foreign 
packages on system , output of pacman -Qmq , If ok pressed pacman -Rs is used to remove package.
	* 11 A AUR package without a maintainer or AUR Orphan Packages(not to be confused with system orphan see pacman section)
	Is a PKGBUILD in the AUR database with no maintainer. 
	This option loops thru all foreign packages on system (output of pacman -Qmq)
	and uses command "cower -i --format %m" to check for maintainer. It will show if any package on your system 
	is not maintained in the AUR system.
	
* pacaur options
	* see "man pacaur" for more details
	* 8 Delete pacaur cache
environment  variable AURDEST 
Determines where the packages build files (PKGBUILD, .SRCINFO and
install script files) will be cloned. 
If this environment variable is not defined, the clone directory
will be set to $XDG_CACHE_HOME/pacaur
with a fall back to $HOME/.cache/pacaur
	* 9 pacaur config file
User will be given option user to select user pacaur config file or the system one
system config $XDG_CONFIG_DIRS/pacaur/config
and falling back to /etc/xdg/pacaur/config
user config $XDG_CONFIG_HOME/pacaur/config
and falling back to $HOME/.config/pacaur/config
	* 12 see cower option 10 above.
	* 13 Desktop notifications are small, passive popup dialogs 
that notify the user of particular events in an asynchronous manner
cylon uses the command notify-send from libnotify to achive this. 
There is parallel output in the terminal. This is the same as running cylon -n
cylon -n can be used with a scheduling service like cron. If there is nothing to update
no desktop notification is displayed

**2: System maintenance section**
n/a

**3: System backup section**

* There is a main backup menu plus a gdrive and rsync option.
* The main backup menu first allows users to pick a backup destination
This can be custom, from config file or the program output folder.
Next it offers 5 options as outlined in readme. The first backs up the MBR or GPT
partition table. It can detect which drive the file system is mounted and which type of partition 
The bash command dd is used for this. It uses cp command for etc and home dir backup.
It also offers option to run package list generator. and finally it uses tar command to 
make a tarball of entire system excluding certain directories. 
* The rsync option takes source and destination from config file and uses following command
sudo rsync -aAXv --delete  --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} 
see man rsync for more information.

* gdrive options
gdrive is a backup client that connects to google drive.
gdrive readme for initial config https://github.com/prasmussen/gdrive ,
gdrive option syncs will Delete extraneous remote files.
There are nine gdrive options, see gdrive_module and the link above for detailed info
	* 1 uses the "gdrive sync list" command
	* 2-5 use the "gdrive sync upload --delete-extraneous" command
	* 6 uses "gdrive sync content" command
	* 7 uses the "gdrive about" command
	* 8 uses the "gdrive list" command after querying user for number of files, order and query
see these links for more information on queries and ordering 
https://developers.google.com/drive/search-parameters)
https://godoc.org/google.golang.org/api/drive/v3#FilesListCall.OrderBy
	* 9 uses command "gdrive info" to get file info.

**4: System security section**
n/a

**5: Network section**
n/a

**6: Miscellaneous section**

* 11 The system information display has two pages of output. The first page
displays some general information on system, the second displays information on 
your package usage.

* 12 The cylon information display function has three pages of output.
The first page displays some general information on cylon as well as
a the status of environment variables used by program. The second page 
checks the dependencies installation status. Dependencies not installed are 
displayed in red. The third option is yes or no prompt to display the programs readme.

* 13 The 3 day weather forecast by wttr.in. 
see: https://github.com/chubin/wttr.in 
The command is: curl wttr.in/"$mX" 
where X is City name, airport code, domain name or area code:- provided by user 
at prompt.



