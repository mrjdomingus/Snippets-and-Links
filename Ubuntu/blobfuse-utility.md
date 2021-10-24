# Blobfuse utility info

Also see:
* [https://docs.microsoft.com/en-us/azure/storage/blobs/storage-how-to-mount-container-linux#next-steps](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-how-to-mount-container-linux#next-steps)
* [https://github.com/Azure/azure-storage-fuse](https://github.com/Azure/azure-storage-fuse)

## Installation
**Configure the Microsoft package repository**
```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
```
**Install blobfuse**
```
sudo apt-get install blobfuse
```
**(Optional) Use a ramdisk for the temporary path**<br>
The following example creates a ramdisk of 16 GB and a directory for blobfuse. Choose the size based on your needs. This ramdisk allows blobfuse to open files up to 16 GB in size.
```
sudo mkdir /mnt/ramdisk
sudo mount -t tmpfs -o size=16g tmpfs /mnt/ramdisk
sudo mkdir /mnt/ramdisk/blobfusetmp
sudo chown <youruser> /mnt/ramdisk/blobfusetmp
```
**Use an SSD as a temporary path**<br>
In Azure, you may use the ephemeral disks (SSD) available on your VMs to provide a low-latency buffer for blobfuse. 
In Ubuntu distributions, this ephemeral disk is mounted on '/mnt'. In Red Hat and CentOS distributions, the disk is mounted on '/mnt/resource/'.

Make sure your user has access to the temporary path:
```
sudo mkdir /mnt/resource/blobfusetmp -p
sudo chown <youruser> /mnt/resource/blobfusetmp
```
**Configure your storage account credentials**
Blobfuse requires your credentials to be stored in a text file in the following format:
```
accountName myaccount
accountKey storageaccesskey
containerName mycontainer
```
The `accountName` is the prefix for your storage account - not the full URL.<br>
Create this file using:
```
touch ~/fuse_connection.cfg
```
Once you've created and edited this file, make sure to restrict access so no other users can read it.
```
chmod 600 ~/fuse_connection.cfg
```
**Create an empty directory for mounting**
```
mkdir ~/mycontainer
```
## Mount
To mount blobfuse, run the following command with your user. This command mounts the container specified in '/path/to/fuse_connection.cfg' onto the location '/mycontainer'.
```
sudo blobfuse ~/mycontainer --tmp-path=/mnt/resource/blobfusetmp  --config-file=/path/to/fuse_connection.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120
```
You should now have access to your block blobs through the regular file system APIs. The user who mounts the directory is the only person who can access it, by default, which secures the access. To allow access to all users, you can mount via the option `-o allow_other`.
```
cd ~/mycontainer
mkdir test
echo "hello world" > test/blob.txt
```
