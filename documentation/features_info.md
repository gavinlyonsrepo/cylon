Features information
-------------

This file provides extra information for some features 
that are not fully explained on screen or in the readme/man page.
The numbers in sub-menus below represent the numbered menu options on screen.

**1: System update section**
* pacman options
	* see "man pacman" for more details
	* 11 12 The paccache script, is provided by the pacman-contrib package.
	* 13 The command to delete orphans is sudo pacman -Rns $(pacman -Qtdq)
	* 15 The pacman database is located at path /var/lib/pacman/local
	* 16 The Arch linux news feed is fetched from this url https://archlinux.org/feeds/news/ 
by a Curl command and parsed using awk and sed.
	* 18 pactree - package dependency tree viewer, A tool installed as part of pacman-contrb
	* 19 pacman config file is located at etc/pacman.conf
	* 20 pacman log is located at /var/log/pacman.log

* Auracle options 
	* Auracle replaced cower in version 5.1 the original cower module file 
is still present in documentation directory TWIC. 
	* see "man auracle" for more details
	* Downloads and updates are downloaded to the Output folders as defined in 
"Output and environment variables" section of readme.md. 
	* 4 The optional install after download consists of a display of the PKGBUILD
and prompt to install or not. 
	* 6 After a combined outdated and download command, 
auracle outdated | awk  '{ print $1 }' | xargs auracle download
Cylon checks if output directory has child directories.
to see if there is an update downloaded, Next it offers to view PKGBUILD of any updates
and finally asks do you want to install them. If you do not want to install some of the updates
for some reason you can manually delete their folder from output folder at this point.
	* 7 A AUR package without a maintainer or AUR Orphan Packages
	(not to be confused with system orphan see pacman section)
	Is a PKGBUILD in the AUR database with no maintainer. 
	This option loops thru all foreign packages on system (output of pacman -Qmq)
	and uses command "Auracle info" to check for maintainer. It will show if any package on your system 
	is not maintained in the AUR system.
	* 11 The dialog package is used to create a GUI menu containing all foreign 
packages on system , output of pacman -Qmq , If ok pressed pacman -Rs is used to remove package.
	* 12 This option is the same as running cylon -n. 
Desktop notifications are small, passive popup dialogs 
that notify the user of particular events in an asynchronous manner
cylon uses the command notify-send from libnotify to achive this. 
There is parallel output in the terminal. 
cylon -n can be used with a scheduling service like cron. If there is nothing to update
no desktop notification is displayed. If running in a crontab. Cron does not run under the X.org server therefore 
it cannot know the environmental variable necessary to be able to start an X.org server application so they will have to be defined.
otify-send is just passing values to dbus. So, first of all, you need to tell dbus to connect to the right bus. 
You can find its address by examining DBUS_SESSION_BUS_ADDRESS environment variable and setting it to the same value. 
In this case to run cylon -n every half hour.

```sh
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
*/30 * * * * cylon -n

```
see: https://wiki.archlinux.org/index.php/Cron


* trizen options
	* 8 Delete trizen clone dir. 
Delete trizen clone dir files. default = /tmp/trizen-$USER
The clone dir is the clone_dir setting from config file.
The clone dir is the absolute path to the directory
where trizen clones and builds packages. The setting is parsed from config file

	* 9 trizen config file. 
Edit trizen config file $HOME/.config/trizen/trizen.conf

	* 12 see auracle 11 above.

**2: System maintenance section**

* Many of the functions that can be selected from this sub-menu can be run in a single 
sweep from the command line by running  cylon -m. This sweep will not change system
only report.

* 3 Checks if disk is SSD and then checks the Journal if fstrim is active.
see : https://wiki.archlinux.org/index.php/Solid_State_Drives#Periodic_TRIM 

* 7 This option runs a package (lostfiles) that identifies files not owned 
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

* There is a main backup menu plus a rsync option.
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


**4: System security section**

N/A

**5: Network section**

N/A

**6: Miscellaneous section**

* 11 The system information display has two pages of output. The first page
displays some general information on system, the second displays information on 
your package usage.

* 12 The cylon information display function has three pages of output.
The first page displays some general information on cylon as well as
a the status of environment variables used by program. The second page 
checks the dependencies installation status. Dependencies not installed are 
displayed in red. The third option is yes or no prompt to display the programs readme.
