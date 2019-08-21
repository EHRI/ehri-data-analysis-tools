## Windows Subsystem for Linux (WSL): A convenient way to run Linux tools on a Windows 10 system

Linux is a popular operating system and is especially useful for projects involving command-line scripts and programming languages such as Python. Many tools and examples that are of interest to those wishing to explore, experiment,and develop projects for digital humanities or data analysis and other tasks are based on Linux. Mac laptops support Linux fairly easily, and there are many online resources that a Mac user may find helpful. However, until recently, people who have only Windows computers have had a relatively difficult time in accessing programs and techniques that require a Linux operating system. In the recent past, a common way to operate a Linux system on a Windows computer, while continuing to be able to access Windows (i.e., without having to reboot the computer into a Linux mode) was through installing VirtualBox, followed by installing a Linux operating system into the VirtualBox environment. At that point, under VirtualBox, it was not always easy or straightforward to configure the Linux system to access network resources that are accessible to the Windows system.

For most Windows 10 users, there is now an alternative method of running Linux programs and systems, through Windows Subsystem for Linux (WSL).

In 2016 Windows announced Windows Subsystem (WSL) for Linux; it has been much improved since then and WSL 2 was released in 2019. WSL runs on 64 bit versions of Windows 10, including on Windows 10 Home.

Note that Windows 10 "S Mode" does not support WSL.

Also note that Windows has announced and is beginning to provide preliminary support for a new command-line service called "Windows Terminal." This article does not cover Windows Terminal, but it is mentioned here as a work environment that may be useful in the near future.

WSL 2 provides access to other Linux distributions and any of those can be selected instead. This article focuses on on the Ubuntu 18.04 LTS (Long Term Support) distribution of Linux. This version of Linux is stable and has good support. Another article will focus in using OpenCV for certain computer-vision related activities, and at this time Ubuntu 18.04 is often cited in examples.

Many Windows functions can be accomplished in more than one way; for example, through command-line commands in a terminal window or through operations using Windows, your mouse and the graphic user interface. This article focuses on command-line activities because many Linux activities, such as running Python scripts, will also be launched via the command-line.

Some readers may be familiar with the Windows Command Window. This article focuses on using PowerShell to install Linux. PowerShell is a Windows tool that is an alternative and more powerful command line environment than the command shell.

One way to launch PowerShell is to press the Windows key on your keyboard or to click the Windows icon at lower left in the system tray. Immediately, begin to type PowerShell and you should see "Windows PowerShell" appear as an option in the Windows Start menu:

  ![](./Launching%20Windows%20Powershell.png?raw=true "Launching Windows PowerShell")
  
Click on "Windows PowerShell" and a PoweShell terminal window should appear:

  ![alt text](./Windows%20PowerShell%20Terminal.png?raw=true "Windows PowerShell terminal")
  
(Alternatively, if you know how to open a Windows Command window, do that and enter "powershell" and enter.)

Enable Linux by entering this into PowerShell, which you can also see in the image above:

```PowerShell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

You may be prompted to reboot your computer upon completion.

Download the installer for WSL 2 from Microsoft for Ubuntu 18.04 :

```PowerShell
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing
```

This may take some time. When complete you should see "Ubuntu 18.04" app appear in your Windows start menu as an item to launch. Select this. In the image below, the user has begun to type "Ubuntu" in the Windows application search:

  ![alt text](./Launch%20Ubuntu.png?raw=true "Launch Ubuntu 18.04 with WSL")

You may be prompted to enter a use account name and password the first time.

At this point you can confirm that you have a version of Ubuntu 18.04 by entering:

```bash
lsb_release -a
```
into the command line and you should see something like this:
```bash
myusername@myWindowsSystem:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.1 LTS
Release:        18.04
Codename:       bionic
mlevy@Desktop-7273:~$
```

  ![alt text](./Ubuntu%20Terminal%20Window.png?raw=true "Ubuntu running and confirming version 18.04 'bionic'")


If you see "Ubuntu 18.04 LTS" this will confirm that you now have a working version of this Ubuntu Linux distribution running on your Windows computer and is ready for installation of tools and subsystems.
