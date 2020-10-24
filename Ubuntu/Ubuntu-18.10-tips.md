## VMware Workstation Ubuntu 18.10 Full Screen Problem

Edit this file using your preferred editing tool

`/etc/systemd/system/multi-user.target.wants/open-vm-tools.service`<br>
Add these lines to the end of the "Unit" section
```
Requires=graphical.target
After=graphical.target
```
Save the file and the next time you restart you should be good to go.

You can apply the changes immediately without restarting by running
```
sudo systemctl daemon-reload
sudo service open-vm-tools restart
```
## How to install the NVIDIA drivers on Ubuntu 18.04 Bionic Beaver Linux
[https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-18-04-bionic-beaver-linux](https://linuxconfig.org/how-to-install-the-nvidia-drivers-on-ubuntu-18-04-bionic-beaver-linux)

## How to solve double-click does not Open Folder in Nautilus or VS Code
* Open **Settings** and click on the left tab **Universal Access**.
* In the bottom you will find **Double-Click Delay**
* If slider on zero or very low, increase to first minor tick
