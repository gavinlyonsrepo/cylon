Modules files overview
------------------
There are 10 module library files containing 30+ functions.
installed to 
```sh
/usr/lib/cylon/modules/
```
These files contain the functions used by script.
Function headers in the files contain more information.

| File name | Functions |
| ------ | ------ |
| trizen_module | trizenFunc DelQmeFunc |
| System_back_module | SystemBackFunc |
| Misc_module | checkinputFunc AsciiArtFunc DisplayFunc exitHandlerFunc HelpFunc msgFunc readconfigFunc makeDirFunc |
| Pacman_module | pacmanFunc pkglistFunc updateFunc checkPacFunc rssFunc  |
| System_clean_module | SystemCleanFunc |
| Auracle_module | auraFunc aurupdateFunc notifyFunc |
| Network_module | networkFunc checknetFunc |
| Rmlint_module | RmLintFunc |
| Security_module | SystemSecFunc intchkFunc |
| System_maint_module | SystemMaintFunc SystemMaintAutoFunc configFileScanFunc |

| Function name | Description |
| ------ | ------ |
| SystemSecFunc | Display security options menu |
| intchkFunc | Checks if string input is an integer |
| trizenFunc | trizen wrapper |
| SystemBackFunc | System backup options |
| checkinputFunc| Check options from command line passed to program on start |
| DisplayFunc | Displays main menu options |
| exitHandlerFunc | Error handler to with deal with user errors and exits |
| HelpFunc | Displays cylon and system information pages |
| msgFunc  | Prints to screen: lines, text, 'anykey' prompt and 'yes or no' prompt |
| readconfigFunc | Deals with viewing and editing of cylonCfg.conf config file |
| makeDirFunc | Creates the directories for program output folder |
| pacmanFunc | pacman wrapper + various utilities |
| pkglistFunc | Creates a list of files containing package information |
| updateFunc | Handles the full system update routine |
| checkPacFunc | Checks if package installed  |
| rssFunc | Arch Linux News reader of the Rss feed https://www.archlinux.org/feeds/news/ |
| SystemCleanFunc | bleachbit wrapper |
| DelQmeFunc | Delete foreign packages display menu |
| auraFunc | auracle wrapper + extended functionality |
| aurupdateFunc | update installed packages AUR |
| networkFunc | Handles the network options |
| checknetFunc | Checks if network has connectivity with netcat |
| RmLintFunc | rmlint wrapper |
| SystemMaintFunc | Carries out maintenance checks from menu selection |
| SystemMaintAutoFunc | Carries out most maintenance checks in a single pass |
| configFileScanFunc | Scans home folder for old configuration files |
| AsciiArtFunc | Display the Ascii art to screen |
| notifyFunc | Handles display of system updates desktop notifications with libnotify |
