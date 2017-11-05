Features information
-------------

This file provides extra information for some features 
that are not fully explained on screen or in the readme/man page.
The numbers in sub-menus below represent the numbered menu options on screen.

NOTE: Some sections are not complete.

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
	* 13 This option is the same as running cylon -n. 
Desktop notifications are small, passive popup dialogs 
that notify the user of particular events in an asynchronous manner
cylon uses the command notify-send from libnotify to achive this. 
There is parallel output in the terminal. 
cylon -n can be used with a scheduling service like cron. If there is nothing to update
no desktop notification is displayed. If running in a crontab. Cron does not run under the X.org server therefore 
it cannot know the environmental variable necessary to be able to start an X.org server application so they will have to be defined.
otify-send is just passing values to dbus. So, first of all, you need to tell dbus to connect to the right bus. 
You can find its address by examining DBUS_SESSION_BUS_ADDRESS environment variable and setting it to the same value. 
In my case to run cylon -n every half hour.
```sh
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
*/30 * * * * cylon -n

```
see:

https://wiki.archlinux.org/index.php/Cron



**2: System maintenance section**

* Many of the functions that can be selected from this sub-menu can be run in a single 
sweep from the command line by running  cylon -m. This sweep will not change system
only report.

* 3 Checks if disk is SSD and then checks the Journal if fstrim is active.
see : https://wiki.archlinux.org/index.php/Solid_State_Drives#Periodic_TRIM 

* 7 This option runs a simple script(lostfiles) that identifies files not owned 
and not created by any Arch Linux package. The script is run as root with both the strict and relaxed setting. 
 In strict mode, every file not owned by a package is listed; in relaxed mode, common required 
or present files are omitted from the output. Care should be taken in deciding which files might be extraneous, 
particularly when running in strict mode.

* 10 The inode is a data structure in a Unix-style file system that describes a filesystem object such as a file or a directory. 
Each inode stores the attributes and disk block location(s) of the object's data
This option scans your system and shows which folders are taking up inodes space.
du / -Sh --inodes 2>/dev/null | sort -nr | head -2000 >fileinodescan

* 11 Old configuration scan. Old configuration files may conflict with newer software versions,
or corrupt over time. Remove unneeded configurations periodically, 
This option will scan three folders and compare names of dirs with
names of installed packages and output result to files.
~/.config/ -- where apps stores their configuration
~/.cache/ -- cache of some programs may grow in size
~/.local/share/ -- old files may be lying there
The user can then inspect these files and remove anything unwanted with care.

* 13 systemd has its own logging system called the journal; #journalctl
This can grow quite large this option trims it to 100M using command. 
sudo journalctl --vacuum-size=100M


* 14 Deletes the core dump folder at /var/lib/systemd/coredump/* 
Core dumps consists of the recorded state of the working memory of a computer program at a specific time, 
generally when the program has crashed or otherwise terminated abnormally. They can take up a lot of space.


* 15 There is a delete files sub folder with 4 options. The user can use the bleachbit shred function
to delete folders or files. Bleachbit can shred files to hide their contents and prevent data recovery
3 folder options allow for clearing trash, downloads and the cylon output folder.

* 17 This sub menu contains an option to run the bleachbit CLI wrapper. BleachBit has many useful 
features designed to help you easily clean your computer to free space and maintain privacy. 
First you are prompted 
if you wish to run the preset option based on the same options as in the bleachbit GUI
These are also stored in the bleachbit config file at /$HOME/.config/bleachbit/ 
under Tree sub heading. Next cylon scans system and sees which cleaners you have installed 
cross references them with available bleachbit cleaners and then displays these to the user. 
Typically each cleaner represents an application for example firefox. Next it displays available 
options for user selected cleaner, for example an option for firefox would be cookies. 
The user can also select all options. 
Next the user is prompted for an action on selected cleaner and option. They can preview,
delete or delete and overwrite. 
More information here on these.
https://www.bleachbit.org/features

* 18 There is also an rmlint wrapper. You are prompted to select the directory you wish to scan 
There are 8 scanning options as per readme.md. After a scan two files are created
in the scanned directory and summary of results is outputed to screen
	* rmlint.json : a detailed report of the scan
	* rmlint.sh : a script which will act on the report and change your system.
At this point the user is prompted if they wish to view the report. Next the user
is prompted if they wish to run the rmlint.sh file. 



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

WIP

**5: Network section**

WIP

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



