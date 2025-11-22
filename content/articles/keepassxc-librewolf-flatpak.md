---
title: "Setup KeePassXC with Librewolf using Flatpaks"
date: 2025-03-01T00:00:00Z
draft: false
tags:
- Tutorial
---

KeePassXC is a very nice and open-source password manager. Let's say you're running an instance of a Flatpak KeePassXC and an instance of a Flatpak Librewolf, you will have difficulties setting up the browser integration. This is because both of these apps are sandboxed and getting them to work together is a bidirectional effort. Searching throughout the internet will yield ugly solutions such as using scripts in directories owned by the system, or creating directories in your home folder (breaking away from the philosophy of Flatpaks storing user data in `~/.var/app`). This tutorial will show you how to achieve that.

This guide is based on these guides, read them for an explanation of why each step is needed. **All credit to them, I would not have figured it out at all**:

* https://unix.stackexchange.com/questions/584521/how-to-setup-firefox-and-keepassxc-in-a-flatpak-and-get-the-keepassxc-browser-ad - Provides a very good explanation for how this whole system works.
* https://gitlab.com/TomaszDrozdz/librewolf-firefox-keepassxc-flatpak - The actual guide, although it puts some stuff in the home folder, so that's why I created this guide.

## Instructions

### KeePassXC

Setting up KeePassXC is the easier step, so do that first. Start by going into Settings>Browser Integration>Advanced and ticking "Use a custom browser configuration location" and setting the value to:

> ~/.var/app/io.gitlab.librewolf-community/.librewolf/native-messaging-hosts/

In Flatseal give the following "Other files" file permissions:

* ~/.var/app/io.gitlab.librewolf-community/.librewolf/native-messaging-hosts:ro

We give read-only (ro) permission because we are going to edit the file it creates usually, so we don't want it to overwrite it.

### Librewolf

The real pain.

Build a custom version of the KeePassXC proxy, most guides suggest [this](https://github.com/varjolintu/keepassxc-proxy-rust) because it's standalone.

```sh
mkdir -p /tmp/kpxcp
cd /tmp/kpxcp
wget https://github.com/varjolintu/keepassxc-proxy-rust/archive/refs/heads/master.zip
unzip master.zip
cd keepassxc-proxy-rust-master/
cargo build --release
cp target/release/keepassxc-proxy ~/.var/app/io.gitlab.librewolf-community/.librewolf/native-messaging-hosts
```

Edit the file created by KeePassXC to specify the custom proxy (owned by Librewolf since we placed it in a directory the Flatpak owns):

```json
{
    "allowed_extensions": [
        "keepassxc-browser@keepassxc.org"
    ],
    "description": "KeePassXC integration with native messaging support",
    "name": "org.keepassxc.keepassxc_browser",
    "path": "/home/yiannis/.var/app/io.gitlab.librewolf-community/.librewolf/native-messaging-hosts/keepassxc-proxy",
    "type": "stdio"
}
```

Using Flatseal, add the following (Other files) file permissions:

* xdg-run/app/org.keepassxc.KeePassXC:ro

## Remaining Issues

The following are issues that I haven't figured out how to solve:

- [x] When starting KeePassXC we get the following error popup: "Browser Plugin Failure: Could not save the native messaging script file for custom.". Everything still works fine, but it's annoying. _To fix this issue go to KeePassXC>Options>Browser Integration>Advanced and untick "Update native messaging manifest files at startup_