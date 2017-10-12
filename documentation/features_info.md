Features information
-------------

This file provides extra information for some features 
that are not explained on screen or in the readme.md file.
This document is newly created in version 4.3.
File is a work in progress.

**1: System update section**
* pacman options
	* 11 12 The paccache script, is provided by the pacman package itself.
	* 13 The command to delete orphans is sudo pacman -Rns $(pacman -Qtdq)
	* 15 The pacman database is located at path /var/lib/pacman/local
	* 16 The Arch linux news feed is fetched from this url https://www.archlinux.org/feeds/news/ 
by a Curl command and parsed using sed.
	* 18 pactree - package dependency tree viewer, A tool installed as part of pacman
	* 19 pacman config file is located at etc/pacman.conf
	* 20 pacman log is located at /var/log/pacman.log
	* 21 pacman-optimize is another tool included with pacman for 
improving database access speeds. pacman stores all package information in a collection of small files, 
one for each package. Improving database access speeds reduces the time taken in database-related tasks, 
e.g. searching packages and resolving package dependencies.  See pacman tips/tricks in Arch wiki for more information.

**2: System maintenance section**

**3: System backup section**

**4: System security section**

**5: Network section**

**6: Miscellaneous section**

