# Ubuntu network issues in 18.04 and up

## Network connection is lost after VM is put to sleep

Add the following line to `/etc/network/interfaces`:<br>
`iface ens33 inet dhcp`<br><br>
Switch it on (enable it):<br>

`sudo ifup ens33` <br><br>
Good to go:<br>

`ping google.com`<br><br>
Yay!
