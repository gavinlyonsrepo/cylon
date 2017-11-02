Packages files list generator.
-------------

The package list generator provides a snapshot of system by producing a group of 22 files
which describe the system.
These lists can be very useful, for example:
Reporting bugs, discussing installed packages, maintenance
, freeing space on your hard drive, backing up, restoring or migrating system etc.
This is created by program function "pkglistFunc".
The "pkglistFunc" is called at various places in program see (REF1) marker in readme.md

| Index | Contents | Filename |
| -------- | -------- | ----- |
| 1 | All .pacnew and .pacsave files on system | pacNewSaveFiles.txt |
| 2 | All installed packages | pkglistQ.txt |
| 3 | All native packages | pkglistQn.txt |
| 4 | All explicitly installed packages | pkglistQe.txt |
| 5 | All explicitly installed native packages that are not direct or optional dependencies | pkglistQent.txt |
| 6 | All foreign installed packages | pkglistQm.txt |
| 7 | All foreign explicitly installed packages | pkglistQme.txt |
| 8 | All packages not required as dependencies (orphans)| pkgOpn.txt |
| 9 | All modified by user system backup files | pkgSysBck.txt |
| 10 | All packages installed as dependencies | pkglistDep.txt |
| 11 | All explicitly installed native packages, quiet output for system restore | pkglistQqne.txt |
| 12 | All explicitly installed packages not in base nor base-devel with size and description | pkglistNonBase.txt |
| 13 | All packages that are optional dependencies and not installed explicitly | pkglistOptDep.txt |
| 14 | All installed packages sorted by size | pkglistSize.txt |
| 15 | All installed packages sorted by last install/update date | pkglistDate.txt |
| 16 | All installed groups | pkgGroups.txt |
| 17 | All packages in repository core | pkgCore.txt |
| 18 | All packages in repository extra | pkgExtra.txt |
| 19 | All packages in repository community | pkgComm.txt |
| 20 | All packages in repository multilib | pkgMulib.txt |
| 21 | All installed packages sorted by original install date | pkginstall.txt |
| 22 | System packages information summary | pkginfo.txt |


### Commands used by index number in table. 

1. find / -regextype posix-extended -regex ".+\.pac(new|save)" 2> /dev/null
2. pacman -Q
3. pacman -Qn
4. pacman -Qe
5. pacman -Qent
6. pacman -Qm
7. pacman -Qme
8. pacman -Qtdq
9. pacman -Qii | awk '/^MODIFIED/ {print $2}'
10. pacman -Qd 
11. pacman -Qqne 
12. expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort))
13. comm -13 <(pacman -Qdtq | sort) <(pacman -Qdttq | sort)
14. expac -H M '%m\t%n' | sort -hr
15. expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -hr 
16. expac -g '%G' | sort -u
17. paclist core 
18. paclist extra 
19. paclist community
20. paclist multilib
21. sed -n "/ installed "x" /{s/].*/]/p;q}" /var/log/pacman.log , see source code for source of "x"
22. wc -l ./*.txt | head -n -1 | sort
