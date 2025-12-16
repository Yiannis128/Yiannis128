---
title: The Freedom Ecosystem
date: 2025-12-04T17:13:29Z
draft: false
tags:
  - self-host
  - freedom
  - app-ecosystem
---

In this article I will present what apps and services I use to provide myself as much freedom as possible. Over the last few months I have been transitioning to self-hosted services and open ecosystem apps. For services, I self host them on a home Raspberry Pi, but you can use a VPS to get started (although it's cheaper and offers a much slower experience). The goal of the ecosystem is this:

* Easy to setup - shouldn't require more than 10 minutes to setup and use.
* Easy to export data - should allow to export data without too many steps, the data should also be in an open format that can be read by you and other programs.
* Easy to backup - should allow to backup to your own server (not restrict you to their servers).
* Easy to upgrade - should automatically upgrade without user intervention.
* Low resource usage - run bloatfree (sorry NextCloud!).
* Ecosystem Integration - should offer a closely-coupled experience as you would expect from "closed" ecosystems.
* Open source - I try to stick to this rule, but I make some exceptions with some closed source apps since they are quite good and no open source alternative exists that meets all the requirements. Where I break this rule, I will use this "⛓️" emoji to mark the app as closed source.

Read [this](/articles/state-of-the-modern-web) for my motivation. I will return to this article and update it as I see fit. To see previous versions see [my git](https://github.com/Yiannis128/Yiannis128/commits/master/content/articles/freedom-ecosystem.md) commit history.

![[images/freedom.png]]

### Backend Core Services

The home server software used is the following:

* Cloudreve - Cloud instance (supports WebDAV)
* VaultWarden - Password manager - Can alternatively use BitWarden
* Stalwart - Email, CalDAV, CardDAV

#### Optional Backend Services

The following are backend services that are optional, but enhance the overall experience. A simpler service would be to use the WebDAV server - which I go in more detail below.

* Navidrome - Music
* Immich - Image Sync
### Client Apps

Use this table to find the apps you need for whatever service.

| **App**                                               | **Platform** | **App**                                                          | **Description/Notes**                                                                                                                                                                                                                                                                                                                                                | **Managed Hosting** |
| ----------------------------------------------------- | ------------ | ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| **File Sync**                                         | Android      | DAVx⁵                                                            |                                                                                                                                                                                                                                                                                                                                                                      |                     |
|                                                       | Android      | Cloudreve Web App                                                |                                                                                                                                                                                                                                                                                                                                                                      |                     |
|                                                       | Linux        | Linux:  [Rclone-sync](https://github.com/Yiannis128/rclone-sync) | File sync - my own easy-to-use solution since using mounts does not allow offline access of files - feel free to use!                                                                                                                                                                                                                                                |                     |
| **Mail / Calendar / Contacts / Tasks / Appointments** | Android      | DAVx⁵ and Thunderbird                                            | This will be managed through normal mail, CalDAV and CardDAV.                                                                                                                                                                                                                                                                                                        |                     |
|                                                       | Linux        | Integrated into DE and Thunderbird                               | Gnome automatically supports and integrates CalDAV and CardDAV into their apps.                                                                                                                                                                                                                                                                                      |                     |
| **Photos**                                            | Android      | FolderSync ⛓️                                                    | This app allows you to sync individual folders to WebDAV in your local storage on Android (in this case the ~/DCIM folder)                                                                                                                                                                                                                                           |                     |
|                                                       | ANY          | Immich                                                           | Need to host the "additional" service to use, does not support WebDAV                                                                                                                                                                                                                                                                                                |                     |
| **Passwords**                                         | ANY          | Bitwarden                                                        | Open source with a closed source backend, that's why we are using the self-hosted "VaultWarden" implementation. Just point it to your VaultWarden URL when signing in.                                                                                                                                                                                               |                     |
| **Bookmarks**                                         | ANY          | Floccus                                                          | Synced through WebDAV.                                                                                                                                                                                                                                                                                                                                               |                     |
| **Notes**                                             | ANY          | Obsidian ⛓️                                                      | These are just MD files so technically you can use the Cloudreve website, however, Obsidian is lightweight and very polished so it is included in the list.<br><br>On PC just set your vault path to your cloud directory where you want to keep your notes (mine is ~/Cloud/Notes). On <br><br>Android you will have to use the Obsidian extension "Save Remotely". |                     |
| **Music**                                             | Android      | Symfonium ⛓️                                                     | Paid but honestly worth it it's the best music app I've seen. Allows for WebDAV connections. Compatible with Navidrome as well.                                                                                                                                                                                                                                      |                     |
|                                                       | Linux        | Gapless                                                          | Point to your music folder (mine is ~/Cloud/Music).<br><br>If you use Navidrome, you can use the web app.                                                                                                                                                                                                                                                            |                     |

One thing you may have noticed is that all these client services like bookmarks and music can easily run on the client side and sync using WebDAV. There's no reason to over-complicate things by running their own services. As mentioned in [my other article](state-of-the-modern-web), the closed ecosystem services can easily be hosted on a file server and work just as well as a dedicated service, hence, they needlessly over-complicate things and keep you trapped. Notes, music, bookmarks, passwords, etc. all these can be hosted on a simple 2GB file server.

This may seem like quite a lengthy setup, however, it can truly be completed in under an hour (server setup + client apps). If you don't want to manage a server, you can alternatively use these apps private syncing functionality at the expense of slightly sacrificing your ecosystem.

---

## Don't Touch Nextcloud

![Nextcloud](images/nextcloud-logo-blue-transparent.svg)

It's quite incredible how unstable NextCloud feels to use. I have hosted it for 4 years and at least once a year something goes catastrophically wrong. Initially I set it up on an ArchLinux VPS using the [ArchLinux Wiki](https://wiki.archlinux.org/title/Nextcloud) guide, I then switched to using the NextCloud AIO docker image around 3 years later. Throughout my time as a user, I found the software to be quite unreliable and slow. It has a large resource footprint and is very fragile as well. This is probably because they have a lot of legacy components and rely on "old" technologies such as PHP and setting them up is a nightmare and can lead to vague error messages.

As an idea, NextCloud AIO seems good: Create a docker image that allows users to run in one command the entire service. However, due to the complexity of the software they chose to not simply run all the services using container compose services as most do. They seem to have chosen to create a "manager" service. This service is what runs when you start the compose initially. It presents a site that is not using any of their infrastructure (as NC is not running at this point) that allows you to start, stop or upgrade your actual NC containers. That's right, instead of creating a compose file that will run the stack, you run the manager service that runs the actual cloud services. This adds tremendous complexity to the entire stack, if something goes wrong, you have no idea how to solve it like usual, but now you don't even know how it's configured because it was automatically handled by the AIO manager and the errors shown are even more disconnected and vague.

Just so you understand how much complexity there is, I invite you to checkout their [GitHub README file](https://github.com/nextcloud/all-in-one) and as an exercise read through their FAQ. The whole idea is that container compose services should handle everything themselves, but in the FAQ, they give steps on rescuing the service from errors requiring you to go digging into the volumes. This is not resilient at all and **will cause you headaches**. Do not recommend. It's quite clear that NextCloud is not targeting self-hosting users and is targeting larger teams with IT staff that can resolve these issues and keep things running smoothly or delegate the issues to their enterprise support service.

I will not only negatively criticize NC however, I must compliment their "App Ecosystem" as they offer quite a lot of services through extensibility through their extensions, which I do miss as they were quite easy to install, manage and didn't break often at all (as opposed to the actual core service itself). At this point I recommend they completely rewrite the core in a language like Go and ensure that it can run using a single command without headaches. In fact, OwnCloud their competitor has done this already (but that is enterprise software not recommended for self-hosting due to the license from what I remember).

If NextCloud rewrites their core as a single Go application (or something equivalent), makes the setup process as easy as Cloudreve. Makes upgrading more stable. I will switch back because of their superior app extensibility. But I don't see it happening anytime soon 🫤.
