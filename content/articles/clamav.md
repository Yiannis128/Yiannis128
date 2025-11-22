---
title: "ClamAV Setup and Configuration Tutorial - Fedora 41"
date: 2025-02-16T17:56:55Z
draft: false
tags:
- Tutorial
---

Guide based on [this blog post by Daniel Aleksandersen](https://www.ctrl.blog/entry/how-to-periodic-clamav-scan.html) and the [ArchLinux Wiki](https://wiki.archlinux.org/title/ClamAV). None of these worked perfectly on their own and some modifications were made to accommodate for that. The setup that this configuration belongs to is:

* Laptop (This guide is not meant for servers, additional configuration is most likely required)
* Fedora 41

Fedora has some extra configuration that needs to happen before setting up ClamAV to work properly. The components are:

* `clamd`
* `freshclam`

Install the packages:

```sh
sudo dnf install clamav freshclam clamd
```

Start by enabling the antivirus scanning option of SELinux:

```sh
sudo setsebool -P antivirus_can_scan_system 1 
```

## freshclam

Start by generating initial configuration for freshclam. Freshclam is ran under the user `clamupdate`.

```sh
clamconf -g freshclam.conf > freshclam.conf
sudo mkdir /etc/freshclam.conf
sudo chown root:root /etc/freshclam.conf
sudo chmod u=rw,go=r /etc/freshclam.conf
```

Apply the following diff:

```diff
5,7d4
< # Comment out or remove the line below.
< Example
< 
14c11
< #LogFileMaxSize 5M
---
> LogFileMaxSize 100M
18c15
< #LogTime yes
---
> LogTime yes
45c42
< #DatabaseDirectory /var/lib/clamav
---
> DatabaseDirectory /var/lib/clamav
62c59
< #DatabaseOwner clamupdate
---
> DatabaseOwner clamupdate
80c77
< #DatabaseMirror database.clamav.net
---
> DatabaseMirror database.clamav.net
186c183
< #Bytecode yes
---
> Bytecode yes
```


Run a virus definition update and additionally enable the freshclam service:

```sh
sudo freshclam
sudo systemctl enable --now clamav-freshclam.service
```

Enabling the service will perform periodic updating. This is in contrast to the blog post that used cron for this functionality.

## clamd

Start by generating initial configuration for the daemon. The scanning service will be ran under the user `clamscan`.

```sh
clamconf -g clamd.d/scan.conf > scan.conf
sudo mkdir /etc/clamd.d/
sudo chown root:root /etc/clamd.d/scan.conf
sudo chmod u=rw,go=r /etc/clamd.d/scan.conf
```

The following options were changed in my file, which are based of the ArchLinux guide's recommended settings, however, not exact:

```diff
5,7d4
< # Comment out or remove the line below.
< Example
< 
35c32
< #LogFileMaxSize 5M
---
> LogFileMaxSize 50M
39c36
< #LogTime yes
---
> LogTime yes
48c45
< #LogSyslog yes
---
> LogSyslog yes
66c63
< #ExtendedDetectionInfo yes
---
> ExtendedDetectionInfo yes
88c85
< #LocalSocket /tmp/clamd.socket
---
> LocalSocket /var/run/clamd.scan/clamd.socket
92c89
< #LocalSocketGroup virusgroup
---
> LocalSocketGroup virusgroup
96c93
< #LocalSocketMode 660
---
> LocalSocketMode 660
100c97
< #FixStaleSocket yes
---
> FixStaleSocket yes
135c132
< #MaxThreads 20
---
> MaxThreads 8
176c173
< #MaxDirectoryRecursion 15
---
> MaxDirectoryRecursion 20
219c216
< #VirusEvent /opt/send_virus_alert_sms.sh
---
> VirusEvent /opt/clamav/virus-event.sh
250c247
< #User clamav
---
> User clamscan
254c251
< #Bytecode yes
---
> Bytecode yes
284c281
< #DetectPUA yes
---
> DetectPUA yes
307c304
< #ScanPE yes
---
> ScanPE yes
314c311
< #ScanELF yes
---
> ScanELF yes
320c317
< #ScanMail yes
---
> ScanMail yes
386c383
< #ScanHTML yes
---
> ScanHTML yes
393c390
< #ScanOLE2 yes
---
> ScanOLE2 yes
398c395
< #AlertBrokenExecutables yes
---
> AlertBrokenExecutables no
403c400
< #AlertBrokenMedia yes
---
> AlertBrokenMedia no
425c422
< #AlertOLE2Macros no
---
> AlertOLE2Macros yes
439c436
< #AlertPartitionIntersection yes
---
> AlertPartitionIntersection yes
445c442
< #ScanPDF yes
---
> ScanPDF yes
451c448
< #ScanSWF yes
---
> ScanSWF yes
457c454
< #ScanXMLDOCS yes
---
> ScanXMLDOCS yes
463c460
< #ScanHWP3 yes
---
> ScanHWP3 yes
469c466
< #ScanArchive yes
---
> ScanArchive yes
634c631,637
< #OnAccessIncludePath /home
---
> OnAccessIncludePath /home
> OnAccessIncludePath /mnt
> OnAccessIncludePath /media
> OnAccessIncludePath /etc
> OnAccessIncludePath /usr
> OnAccessIncludePath /opt
> OnAccessIncludePath /dev
656c659,660
< #OnAccessExcludeUname clamuser
---
> OnAccessExcludeUname clamupdate
> OnAccessExcludeUname clamscan
663c667
< #OnAccessMaxFileSize 5M
---
> OnAccessMaxFileSize 5M
671c675,676
< #OnAccessPrevention yes
---
> # Warning: Setting to yes can increase package install times by 1000x
> OnAccessPrevention no
675c680
< #OnAccessExtraScanning yes
---
> OnAccessExtraScanning yes
```

### VirusEvent

You might have noticed the `VirusEvent` option that triggers when a virus is found is set to execute `/opt/clamav/virus-event.sh`. Set it up by running the following commands:

```sh
sudo mkdir /opt/clamav
sudo nvim /opt/clamav/virus-event.sh
```

Save the following file contents:

<script src="https://gist.github.com/Yiannis128/68b6e1d6f24047bae4cd1c115ec344ce.js"></script>

Set permissions:

```sh
sudo chmod u=rwx,go= /opt/clamav/virus-event.sh
sudo chown clamscan:clamscan /opt/clamav/virus-event.sh
```

### Starting the Daemon

Controlled through SystemD unit files. The daemon has the possibility to freeze your system (a lot of times), so the blog post recommends to set system resource limits by overriding the systemd files.

```sh
sudo systemctl edit clamd@
```

Add the following overrides:

```
[Service]
Nice=18
IOSchedulingClass=idle
CPUSchedulingPolicy=idle
```

Activate the daemon:

```sh
systemctl daemon-reload
systemctl enable --now clamd@scan
systemctl status clamd@scan
```

### Enabling OnAccessScan

OnAccessScan allows ClamAV to scan files on demand as the users access them. This is useful to have as it provides constant security at the cost of speed. To enable the service that runs the OnAccessScan, edit the service to add passing file-descriptors instead of paths:

```sh
sudo systemctl edit clamav-clamonacc.service
```

Add the following overrides (the reason is explained in the ArchLinux guide):

```
[Service]
ExecStart=
ExecStart=/usr/sbin/clamonacc -F --fdpass --config-file=/etc/clamd.d/scan.conf
```

Reload and enable:

```sh
sudo systemctl daemon-reload
sudo systemctl enable --now clamav-clamonacc.service
```


## Testing

This will test if a fake virus is detected. The file in the URL is harmless (it's a txt file).

### Manual

```sh
curl https://secure.eicar.org/eicar.com.txt | clamscan -
```

### Realtime Protection

```
cd ~/Downloads
wget https://secure.eicar.org/eicar.com.txt
cat eicar.com.txt
```

Check the logs:

```sh
journalctl -eu clamav-clamonacc.service
```

If a notification did not appear, then please look at the workaround for VirusEvent below, as you may have encountered a ClamAV bug.

## Using clamdscan

With clamd running in the background, we can use clamdscan. It's like clamscan but uses the config from `/etc/clamd.d/scan.conf` as it uses the `clamd@scan` daemon we enabled previously:

```sh
clamdscan --multiscan --infected --log clamav.log $HOME
```

### File Permission Issues

You might notice that trying to use clamdscan, gives you a variety of errors:

```
--------------------------------------
/home/yiannis: File path check failure: Permission denied. ERROR

----------- SCAN SUMMARY -----------
Infected files: 0
Total errors: 1
Time: 0.002 sec (0 m 0 s)
Start Date: 2025:02:17 23:45:20
End Date:   2025:02:17 23:45:20
```

In order to fix this issue, the parameter `--fdpass` needs to be included; `clamdscan -mil clamav.log --fdpass $HOME`. This will make clamscan (ran under the `$USER`) pass the file descriptor to clamd (ran under clamscan), allowing the clamscan user to bypass the file permissions of the home folder.

### LocalSocket Issues

At this point, another error with local socket permissions should appear:

```
ERROR: Could not connect to clamd on LocalSocket /var/run/clamd.scan/clamd.socket
```

This is caused because the clamdscan process (ran under `$USER`) does not have permissions to access the socket; owned by clamscan and part of the virusgroup group. The solution to this:

```sh
sudo usermod -aG virusgroup $USER
``` 

Log out and log back in. Now clamdscan should work (don't forget to pass `--fdpass`.

## VirusEvent Workaround

There's an [issue](https://github.com/Cisco-Talos/clamav/issues/1062) that ClamAV is facing where `VirusEvent` is not working. A [user](https://github.com/Cisco-Talos/clamav/issues/1062#issuecomment-1771546865) suggested a workaround where we deploy an extra script to read the logs and trigger the virus event manually. Keep this while the issue is open. After the issue is resolved, you can delete all the work done in this section.

### Notifier Script

Start by creating a script the notifier script:

```sh
sudo nvim /opt/clamav/clamonacc-log-notifier.sh
```

This script is responsible for scanning the log file and creating the virus events.

<script src="https://gist.github.com/Yiannis128/2ad4e9d1c78dbda97d9711941540e7e1.js"></script>

### Monitor Script

Create the monitor script that will feed the log file to the notifier script. 

```sh
sudo nvim /opt/clamav/clamonacc-log-monitor.sh
```

This script pipes the output of the journal which contains the logs from the OnAccessScan service to the notifier script.

<script src="https://gist.github.com/Yiannis128/665b0cecb9bb0dc0ffaf57a55311b7d9.js"></script>

Set appropriate permissions for both scripts:

```sh
sudo chmod --reference=/opt/clamav/virus-event.sh /opt/clamav/clamonacc-log-notifier.sh /opt/clamav/clamonacc-log-monitor.sh
sudo chown --reference=/opt/clamav/virus-event.sh /opt/clamav/clamonacc-log-notifier.sh /opt/clamav/clamonacc-log-monitor.sh
```

### Service File

Now create a service file to run these two scripts:

```sh
sudo nvim /etc/systemd/system/clamav-clamonacc-notifier.service
```

This simply waits for all other services to start, then run the script as root:

```
[Unit]
Description=ClamAV On-Access Notifier (Workaround for VirusEvent being broken in ClamAV)
Requires=clamav-clamonacc.service
After=clamav-clamonacc.service syslog.target network.target
[Service]
Type=simple
User=root
ExecStart=/opt/clamav/clamonacc-log-monitor.sh
Restart=always
[Install]
WantedBy=multi-user.target
```

Enable the service:

```sh
sudo systemctl daemon-reload
sudo systemctl enable --now clamav-clamonacc-notifier
```

### Reversing the Workaround

Effort was put to make the VirusEvent workaround changes as minimal as possible. When the issue is fixed, reverse the changes by running the following commands:

```sh
sudo systemctl stop clamav-clamonacc-notifier
sudo systemctl disable clamav-clamonacc-notifier
sudo systemctl daemon-reload
sudo rm /etc/systemd/system/clamav-clamonacc-notifier.service /opt/clamav/clamonacc-log-monitor.sh /opt/clamav/clamonacc-log-notifier.sh
```

These commands stop and delete the service from the system and delete the remaining scripts that were created.

## Install GUI - ClamTK

ClamTK is a GUI front-end for ClamAV. Its main limitation is that it doesn't allow you to configure ClamAV in any meaningful way. It contains some basic utilities such as scanning files and directories. To install it run the following command:

```sh
sudo dnf install clamtk
```

I personally don't find it that useful.

## Existing Issues

While my research into this program has resolved most of the issues, I have still am facing the following problems. **If you know how to resolve them, please get in touch.**

### Duplicate Reports in clamav-clamonacc

* It can be observed that when running: `journalctl --follow -eu clamav-clamonacc`, and an infected file is accessed, multiple entries are created. I don't think this is intended behaviour.

### Running clamdscan

The following problems are produced when running the command:

```sh
clamdscan --quiet -mil clamav.log --fdpass -i $HOME
```

#### STDOUT

* The output of the command is a lot of these lines: `LibClamAV Warning: cli_realpath: Invalid arguments.`

#### LOG FILE

* When running clamdscan, I get a `WARNING: [FILE]: Not supported file type` on some entries. I thought that the `--infected` in conjunction with `--quiet` option would work. This is not the case!
* When running clamdscan, I get a `[FILE]: Failed to open file` on some entries. I thought that the `--infected` in conjunction with `--quiet` option would work. This is not the case!

