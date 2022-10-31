# deva.cloud

deva.cloud is a highly modified tbaMUD, CircleMUD, DikuMUD server turned into an Aritficial Intelligence Multi-Agent System.

## Access

The deva.cloud can be accessed using any standard `telnet` client at:  
`arjika.deva.world port:9003`

To access the realm from your [deva.world](https://indra.ai/deva.world) interface add the configuration to your `./data/client.json` file. The #mud deva comes intalled by default in the interface.

Change the `*your*username*` to your chosen username, and chang `*your*password*` to your password. We recommend using the `!uid` command to generate a random number password to be stored here.

```json
"mud": {
  "key": "*your*username*",
  "host": "arjika.deva.cloud",
  "port": 9003,
  "user": {
    "login": "*your*username*",
    "password": "*your*password*"
  }
},
```
## Source

[Github Repository](https://github.com/indraai/deva.cloud)

First clone the repository. Then do the install stuff that comes later.

`> git clone https://github.com/indraai/deva.cloud.git`


All requests for help or bugs should be reported to: arjika.deva.cloud:9003.

Information about deva.cloud can be found at the indra.ai Home Page:
https://indra.ai

The archives contain many great ideas in the `/contrib/` section.

## Compiling

deva.cloud compiles under a large number of operating systems; instructions
for compiling on each platform is can be found in the file doc/README.*system*

- [AMIGA](doc/README.AMIGA.md) - If you are using an Amiga running AmigaDOS. (If you're running NetBSD or Linux on an Amiga, use README.UNIX instead.)  
- [ARC](doc/README.ARC.md) - If you are using an Acorn running RiscOS.  
- [BORLAND](doc/README.BORLAND.md) - For those using Borland under Windows.  
- [CYGWIN](doc/README.CYGWIN.md)  - If you are using Cygwin shell in Windows.  
- [MSVC4](doc/README.MSVC4.md) - If you are using MSVC 4.  
- [MSVC5](doc/README.MSVC5.md) - If you are using MSVC 5.  
- [MSVC6](doc/README.MSVC6.md) - If you are using MSVC 6.  
- [MSVC8](doc/README.MSVC8.md) - If you are using MSVC 8.  
- [OS2](doc/README.OS2.md) - If you are using OS/2 Warp Connect v3.0 or OS/2 v2.x.  
- [UNIX](doc/README.UNIX.md) - If you have any type UNIX system, including Linux, MkLinux, Ultrix, HP/UX, Solaris, SunOS, IRIX, FreeBSD, OpenBSD, NetBSD, BSDi, Macintosh OS X, etc.  
- [VMS](doc/README.VMS.md) - If you happen to be on OpenVMS.  
- [WATCOM](doc/README.WATCOM.md)  - If using WATCOM under Windows.  
- [WIN](doc/README.WIN.md) - If you are using Windows.

If you are interested in porting deva.cloud to a new platform, see the file
[porting](doc/porting.md) for some tips.

## Other Documentation

[Administrator Guide](doc/admin.md) -  Gives an overall description of how deva.cloud works, how to get it to compile and run for the first time, information about customizing and configuration options and command-line arguments, and tips on maintenance and day-to-day
MUD administration.

[Builder Manual](doc/building.md) - This documents the world-file format and describes how to create new rooms, objects, and monsters. Also, it describes how to add new areas to the MUD and gives some tips about game balance and world-file debugging.

[Code Manual](doc/coding.md) - For the coders in your group, a technical reference describing some of the more basic coding tasks such as how to add new commands, spells, skills, socials, and classes.

[Files](doc/files.md) - Overview of the deva.cloud file structure.

[Debugging](doc/debugging.md) -  For information on debugging the application please read the debugging file.

[Message Editor](doc/msgedit.md) - The Message Editor is an OLC style editor for modifying the in-game combat messages.

[Socials](doc/socials.md) - A social is the easiest command to add to the game thanks to the social editor; aedit.

[SYSERR](doc/syserr.md) - A list of SYSERR messages and a description of what can cause each problem and how to solve it.  An excellent guide for troubleshooting and area debugging.


-

[Back to indra.ai](https://indra.ai)  
&copy;2022 Quinn Michaels; All Rights Reserved.
