Via: [https://gist.github.com/darrenpmeyer/b69242a45197901f17bfe06e78f4dee3](https://gist.github.com/darrenpmeyer/b69242a45197901f17bfe06e78f4dee3)

(**NB:** adapted from [this Ask Ubuntu thread](https://askubuntu.com/questions/580319/enabling-shared-folders-with-open-vm-tools) -- tested to work with **Ubuntu 16 LTS** branches and **Ubuntu 17.10**)

Unlike using **VMWare Tools** to enable Linux guest capabilities, the `open-vm-tools` package doesn't auto-mount shared VMWare folders. This can be frustrating in various ways, but there's an easy fix.

# TL;DR

Install `open-vm-tools` and run:

  ```
  sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other
  ```
  
(Make sure `/mnt/hgfs` exists and is empty)

You can put configuration stanzas in `/etc/fstab` to facilitate this, and then `mount /mnt/hgfs` will work.

See the **Setting up auto-mounting** section for setting up auto-mounting instead.

# Pre-work

Make sure `open-vm-tools` (and `open-vm-tools-desktop` if you're using a desktop environment) are installed, and that you've rebooted after their installation.

  ```
  sudo apt update
  sudo apt install open-vm-tools open-vm-tools-desktop
  ```
  
Make sure you have a `/mnt/hgfs` directory made and empty. If not:

  ```
  sudo mkdir -p /mnt/hgfs
  ```
  
# Mounting

To mount the filesystem, run:

  ```
  sudo mount -t fuse.vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other
  ```

The shared folders will now be in subdirectories of `/mnt/hgfs`


# Setting up auto-mounting 

1. Add the following line to `/etc/fstab`:

    ```
    .host:/	/mnt/hgfs	fuse.vmhgfs-fuse	auto,allow_other	0	0
    ```

Browse `/mnt/hgfs` at will.
