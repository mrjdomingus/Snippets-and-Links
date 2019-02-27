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
