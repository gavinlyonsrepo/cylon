Packages files list generator.
-------------

The package files list generator provides a snapshot of system by producing a group of 24 files
which describe the system.
These lists can be very useful, for example:
Reporting bugs, discussing installed packages, maintenance
, freeing space on your hard drive, backing up, restoring or migrating system etc.
This is created by program function "pkglistFunc".
The "pkglistFunc" is called at various places in program see (REF1) marker in readme.md

| Index | Contents | Filename |
| -------- | -------- | ----- |
| 1 | All .pacnew and .pacsave files on system | pacNewSaveFiles.txt |
| 2 | All installed packages | pkgQ.txt |
| 3 | All native packages | pkgQn.txt |
| 4 | All explicitly installed packages | pkgQe.txt |
| 5 | All explicitly installed native packages that are not direct or optional dependencies | pkgQent.txt |
| 6 | All foreign installed packages | pkgQm.txt |
| 7 | All foreign explicitly installed packages | pkgQme.txt |
| 8 | All packages not required as dependencies (orphans)| pkgOpn.txt |
| 9 | All modified by user system backup files | pkgSysBck.txt |
| 10 | All packages installed as dependencies | pkgQd.txt |
| 11 | All explicitly installed native packages, quiet output for system restore | pkgQqne.txt |
| 12 | All packages that are optional dependencies and not installed explicitly | pkgOptDep.txt |
| 13 | All explicitly installed packages not in base nor base-devel with size and description | pkgNonBase.txt |
| 14 | All explicitly installed packages that are not direct or opt dependencies not in base/base-devel with size & desc: pkgexpNonBase.txt  | pkgexpNonBase |
| 15 | All installed packages sorted by size | pkgSize.txt |
| 16 | All installed packages sorted by last install/update date | pkgDate.txt |
| 17 | All installed groups | pkgGroups.txt |
| 18 | All packages in repository core | pkgCore.txt |
| 19 | All packages in repository extra | pkgExtra.txt |
| 20 | All packages in repository community | pkgComm.txt |
| 21 | All packages in repository multilib | pkgMulib.txt |
| 22 | All installed packages sorted by original install date | pkginstall.txt |
| 23 | All development/unstable packages(cvs svn git hg bzr darcs) | pkgdevel.txt |
| 24 | System packages information summary | pkginfo.txt |


### Commands used by index number in table. 

1. find / -path /run/media -prune -o -path /mnt -prune -o -regextype posix-extended -regex ".+\.pac(new|save)" \
-fprint pacNewSaveFiles.txt -exec echo -n "." \; 2> /dev/null 
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
12. comm -13 <(pacman -Qdtq | sort) <(pacman -Qdttq | sort)
13. expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort))
14. expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort))
15. expac -H M '%m\t%n' | sort -hr
16. expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -hr 
17. expac -g '%G' | sort -u
18. paclist core 
19. paclist extra 
20. paclist community
21. paclist multilib
22. sed -n "/ installed "x" /{s/].*/]/p;q}" /var/log/pacman.log , see source code for source of "x"
23  pacman -Qq | awk '/^.+(-cvs|-svn|-git|-hg|-bzr|-darcs)$/'
24. wc -l ./*.txt | head -n -1 | sort
