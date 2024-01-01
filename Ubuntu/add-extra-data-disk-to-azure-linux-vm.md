1. Connect to your Ubuntu 23.10 VM via SSH.
1. Identify the new disk using `lsblk`. It should show up as something like `/dev/sda` if it's the first data disk.
1. Format the disk with a file system, e.g., ext4: `sudo mkfs.ext4 /dev/sda`.
1. Create a mount point for the new disk, e.g., `sudo mkdir /mnt2`.
1. Mount the disk to the mount point: `sudo mount /dev/sdb /mnt2`.
1. To ensure the disk is mounted automatically at boot, edit `/etc/fstab`. Get the UUID of the disk with `sudo blkid` and add a line like `UUID=[your-disk-UUID] /mnt2 ext4 defaults 0 2`. _Do not add the square brackets_.
1. Save changes and exit the editor. The disk is now ready for use.
