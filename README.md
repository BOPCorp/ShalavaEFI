# ![](https://cheddy.neocities.org/lime/limesmall.png)
## A simple and advanced boot manager for OpenComputers.

Lime is a fork/continuation of Cyan, a boot manager created by BrightYC for the OpenComputers mod.

**Installation Guide**

Install OpenOS if you don't have it installed already. An *Internet Card* is also required for installation. (If that wasn't obvious already, lol.). Paste the command below.

```
wget -f https://raw.githubusercontent.com/BOPCord/ShalavaEFI/master/installer.lua /tmp/installer.lua && /tmp/linstaller.lua
```
The installer will first ask you if you want to create a whitelist. 

![](https://cheddy.neocities.org/lime/whitelist.png)

A whitelist prevents unauthorized users from booting the computer. Hitting "y" will prompt you to put in a username to add to the whitelist. The whitelist will make it so the computer will boot with input from any user specified in the whitelist

![](https://cheddy.neocities.org/lime/whitelist2.png)

**WARNING!**: You WILL have to create a new EEPROM to re-flash if you type your username incorrectly! If you do not want a whitelist, hit "n" and press enter.

Next, the installer will ask you if you would like to make the EEPROM read only. Making the EEPROM read only will prevent you from re-flashing that EEPROM in the future.

![](https://cheddy.neocities.org/lime/readonly.png)

After letting the installer finish, you'll be prompted to reboot. You can either hit "Y" to reboot, or hit "N" to return to the command shell.

![](https://cheddy.neocities.org/lime/reboot.png)

# Features

**Lua Shell**

Lua REPL with implemented functions:

* os.sleep([timeout: number])
* proxy(componentName: string): component proxy or nil
* read(lastInput: string or nil): string or nil
* print(...)

**Network Boot**

Allows you to easily boot from any Lua file on the Internet. *An Internet Card is required to use this feature.*

**Drive Management**

Lime allows you to rename, and format your drives right from the boot manager.
