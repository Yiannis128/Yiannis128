---
title: "Installing SAModManager on Linux Bottles"
date: 2025-02-02T23:10:00+00:00
author: Yiannis Charalambous
draft: false
tags: 
- Games
- Tutorial
---

![Banner Image Source: SAModInstaller](images/samodinstaller.jpg)

This article shows you how to install SAModInstaller for Sonic Adventure DX on Linux. The main reason for this guide is because the installer is designed to use a lot of libraries from the .NET Framework and hence is not something that is cross-platform. It doesn't even work easily with wine. So this guide will show you what you need to do to install SADX in a Linux Bottle and be able to run it.

## Guide

This guide is based off of [Setting up Mods on Steam Deck (Updated 2023) ](https://gamebanana.com/tuts/16934#H1_3) - The main differences are that this guide will show you how to install SADX with SAModInstaller into a Linux bottle. The guide referenced is shows how to install SAModInstaller on top of the base SADX game on Steam, which means you need Steam to run it, which is entirely unnecessary and bloated. 

### Getting the files

1. Download from Steam "Sonic Adventure DX".
2. Copy the game contents into a separate folder where you want the game to exist (or keep it in the Steam directory if you don't want to override the base game).
3. Download [Bottles](https://usebottles.com/) and install.
4. Download [SADX Mod Installer](https://sadxmodinstaller.unreliable.network/).

### Setting up the Environment

Create a new Bottle that will be used to house SADX. Select the following settings:

* Type: Gaming
* Runner: Soda (soda-7.0-9)

In the "Dependencies" sub-menu, download and install the following dependencies: 

* `dotnetcoredesktop8`
* `dotnet452` - The installer annoyingly misguides you by stating ".NET 4.0" which won't work.
* `vcredist2022`

Go to "Settings" and "DLL Overrides" and add the following option: `d3d8=n,b`

### Running the Installer

Extract the SAModInstaller and run the EXE within the bottle. The images will appear upside-down for some compatibility reason, but that does not affect anything. Continue through the installer as required. Search for updates can be chosen.

After the installation has been completed, the game can now be run from within the bottle.