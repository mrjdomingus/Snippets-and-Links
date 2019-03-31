# Ubuntu network issues in 18.04 and up

## Network connection is lost after VM is put to sleep

Add the following line to `/etc/network/interfaces`:<br>
`iface ens33 inet dhcp`<br><br>

Add both `auto` and your `interface name` on a separate line BEFORE your interface configuration in order to bring it up at startup.<br>
`auto ens33`<br>
`iface ens33 inet dhcp`<br><br>

Otherwise you have to switch the interface on manually:<br>
`sudo ifup ens33` <br><br>
Good to go:<br>

`ping google.com`<br><br>
Yay!

# Change network interface name ens33 back to eth0

[https://www.itzgeek.com/how-tos/mini-howtos/change-default-network-name-ens33-to-old-eth0-on-ubuntu-16-04.html](https://www.itzgeek.com/how-tos/mini-howtos/change-default-network-name-ens33-to-old-eth0-on-ubuntu-16-04.html)
