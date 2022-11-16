---
title: "Use Metasploitable2 with KVM"
date: 2022-11-15T11:56:00+01:00
draft: false
tags:
- Tutorial
---

This guide will explore how to import, setup, and configure the [Metasploitable2 virtual hard disk file](https://information.rapid7.com/download-metasploitable-2017.html) provided by rapid7. The reason that this guide exists is that importing the virtual hard disk file is not as straight forward as one might think. Here are the steps:

 1. Download Metasploitable2 from the link above and extract the zip file.
 2. Open Virtual Machine Manager.
 3. Choose to create a new VM.
 4. Choose *Import existing disk image*.
 5. Select the VMDK file from the extracted zip file.
 6. For the OS type, select *Generic or unknown OS*.
 7. Go through the set-up guide normally, there are no additional items to configure through the setup. Make sure to select to configure the VM before boot.
 8. There is one last item to configure, remove the VirtIO storage media.
 9. Open the *Add Hardware* menu, and add a *Storage* device, **make sure that it is set as *SATA****.*
10. You can now click on *Begin Installation* and start using Metasploitable2 on KVM.

## TLDR

The main issue is that the storage device bus type is set to VirtIO instead of SATA. This causes the boot issues encountered when trying to run Metasploitable2 on KVM.