# Checklist Ubunt VM in Azure

* Deploy suitable VM
* Optionally, `sudo do-release-upgrade`
* Add data disk, see [https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/attach-disk-portal)
* Add XFS filesystem, see [https://www.cyberciti.biz/faq/how-to-install-xfs-and-create-xfs-file-system-on-debianubuntu-linux/](https://www.cyberciti.biz/faq/how-to-install-xfs-and-create-xfs-file-system-on-debianubuntu-linux/)
* Optionally, create swap partition, see [https://linuxtechlab.com/create-swap-using-fdisk-fallocate/](https://linuxtechlab.com/create-swap-using-fdisk-fallocate/) or [https://help.ubuntu.com/community/SwapFaq](https://help.ubuntu.com/community/SwapFaq)
* Add firewall rules as necessary
* 
