---
title: "Moving to Fedora - Advice and Pitfalls"
date: 2022-06-16T12:15:16+01:00
draft: true
thumbnail: "/images/articles/tux.png"
thumbnail_size: "100x120"
sitemap:
    changefreq: monthly
    priority: 0.5
tags:
- Notes
---

During the past week, I begun work on moving my server from Debian to Fedora.
The main reason behind this was to get more up to date packages, as Debian's
whole package delivery model is based on having the most stable LTS packages. A
package in Debian (such as Podman) would be years behind the versions of other
distros. So I decided to 'upgrade'. This article will mainly focus on all the
traps and pitfalls I experienced when moving from Debian to Fedora, as the
differences between them can catch you by surprise.

## SELinux

The biggest obstacle in the transition was SELinux. For the uninitiated;
[this](https://www.redhat.com/en/topics/linux/what-is-selinux) RedHat's page
defines SELinux like so:

>Security-Enhanced Linux (SELinux) is a security architecture for Linux® systems
>that allows administrators to have more control over who can access the system.

You can turn off SELinux using `setenforce 0`, this will disable it until next
reboot. My personal advice for using SELinux is like so:
1. Turn SELinux off while adding a new site/service.
2. Add/modify the service.
3. Turn SELinux on.
4. Debug and see if the service and all it's features are fully functional.
5. Go into production.

## Firewalld

Firewalld was another temporary obstacle because coming from a Debian
installation; I assumed that it was turned off on install when I had
instantiated the box. For the firewall, I had to allow ports 80 and 443 through
only since everything is passed through NGINX.
