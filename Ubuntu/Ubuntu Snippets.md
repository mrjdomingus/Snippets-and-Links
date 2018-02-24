### ACCESS VMWARE WORKSTATION HOST FOLDERS FROM UBUNTU 17.10 GUEST MACHINES

Via: [https://websiteforstudents.com/access-vmware-host-folders-guest-machine-ubuntu-17-10/](https://websiteforstudents.com/access-vmware-host-folders-guest-machine-ubuntu-17-10/)

From VMware guest machines you can directly access the host computer shared folders. This is possible because of VMware Workstation folder sharing feature. With shared folders, you can easily share files among virtual machines and the host computer. Folder sharing exposes the host computer files and folders to the virtual machines.

To use shared folders, you must have the current version of VMware Tools installed in the guest operating system and you must configure your virtual machine settings to specify which directories are to be shared.

This brief tutorial shows students and new users how to enable VMware Workstation folder sharing so they can directly access folders shared on the host computer. Without this folder sharing feature, it would be very difficult getting huge files or folders to the guest machine.

With it, all you have to do is share the folder to the guest machine and from the virtual machine access the folder content easily.


**STEP 1: INSTALLING VMWARE GUEST TOOLS**<br>
To get this working, you must first install VMware Tools on the guest machine. For this tutorial we’re using Ubuntu 17.10 guest machine. To install the tool, select the VM and click Install VMware Tools…

This should mount a virtual CD/DVD drive on the Ubuntu guest machine. When that happens, run the commands below to extract the content from the CD/DVD drive to the /tmp drive by running the commands below.

`tar -xvf /media/$USER/"VMware Tools"/VMwareTools*.gz -C /tmp`

Next, run the commands below to install the guest tool using the default configuration.

`sudo /tmp/vmware-tools-distrib/vmware-install.pl -d`

After installing the tool, restart the Ubuntu Desktop.

**STEP 2: SHARE THE HOST FOLDER**<br>
Now that the guest tool is installed, edit the guest machine settings to add the folder you want to share with the host machine.

Then select the **Options** tab and pick the **Shared Folders** from the list. Then enable it and locate the folder you wish to add.

Save your changes and exit. Turn on the Ubuntu machine and browse to the  **/mnt/hgfs** folder and there you should see the shared host folder mounted on the Ubuntu guest machine.

This is how to share VMware host folder with Ubuntu guest machines.
