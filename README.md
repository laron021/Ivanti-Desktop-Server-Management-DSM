# PowerShell module for Ivanti Desktop and Server Management
![](https://github.com/laron021/SWD/blob/main/ivanti_dsm_script.png)

---
Module Name: DSMScript.psm1 
---

# DESCRIPTION
DSM helps IT departments manage and protect
endpoints throughout their lifecycle. This can increase
user productivity and improve business performance
at lower costs. DSM automatically packages and
deploys software and operating systems, patches
vulnerabilities, detects software and hardware assets,
and efficiently manages Windows operating system
migrations.

* About DSM: https://www.ivanti.com/resources/library/ivi/2569/b9a7812d0fb0/?ext=pdf
* InstallCore Module msgDSM7Module [www.powershellgallery.com](https://www.powershellgallery.com/packages/msgDSM7Module)
* Download my custom module from this repository: DSMScript.psm1

This soap interface module designed to automate software distribution, user and group management.

```powershell
PS> Import-Module "C:\location-of-the-module\DSMScript.psm1" -Force
```



## FUNCTIONS 
[QSA](QSA.md)

[PILOT](PILOT.md)

[INDI PILOT](INDIPILOT.md)

[PROD](PROD.md)

[INDI PROD](INDI%20PROD.md)

[WELLE](WELLE.md)

[CLEANUP](CLEANUP.md)

[TOTALCLEANUP](TOTALCLEANUP.md)

[CHECKMEMBERSHIP](CHECKMEMBERSHIP.md)

[CREATE GROUP](CREATEGROUP.md)

[LAST USER](LASTUSER.md)

[DELETE POLICY](DELETEPOLICY.md)

[ZUWEISUNG](ZUWEISUNG.md)


## NOTES
```
      _               ___                                   _ _             
 _   | |             / __)                                 | (_)            
| |_ | | _  _   _   | |__ ___   ____     ____ ____ ____  _ | |_ ____   ____ 
|  _)| || \( \ / )  |  __) _ \ / ___)   / ___) _  ) _  |/ || | |  _ \ / _  |
| |__| | | |) X (   | | | |_| | |      | |  ( (/ ( ( | ( (_| | | | | ( ( | |
 \___)_| |_(_/ \_)  |_|  \___/|_|      |_|   \____)_||_|\____|_|_| |_|\_|| |
                                                                     (_____| 
*respect uwefranke*
```


