# Fixing broken NetworkManager (no IP4 via DHCP)

Run `sudo lshw -C network`

In my server this returns amongst other:
```
       product: 82545EM Gigabit Ethernet Controller (Copper)
       vendor: Intel Corporation
```

The following steps worked for me, the reloading of the kernel modules might not be required, but probably cannot hurt:

* unload /reload the kernel modules
* list the network adapters to get the name of the device (in my case it was „ens33“)
* get an ip for the device
* do an apt-get update / upgrade
* reinstall network-manager

```
sudo rmmod e1000
sudo rmmod e1000e
sudo rmmod igb

sudo modprobe e1000
sudo modprobe e1000e
sudo modprobe igb

ip addr show

sudo dhclient ens33

sudo apt-get update && sudo apt-get upgrade
sudo apt-get purge network-manager
sudo apt-get install network-manager
```

Also see [https://askubuntu.com/questions/1267043/virtual-machine-ubuntu-20-04-lts-connect-network-is-unreachable](https://askubuntu.com/questions/1267043/virtual-machine-ubuntu-20-04-lts-connect-network-is-unreachable)
