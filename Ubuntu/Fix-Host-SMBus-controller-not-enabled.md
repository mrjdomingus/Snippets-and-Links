# Fix Ubuntu Linux “Host SMBus controller not enabled!”

Ubuntu guest instances in VMware sometimes come up with the boot error message:

`piix4_smbus 0000:00:007.3: Host SMBus controller not enabled!`<br>
This error is being caused because VMware doesn’t actually provide that level interface for CPU access, but Ubuntu tries to load the kernel module anyway.

How to fix it:

* `sudo nano /etc/modprobe.d/blacklist.conf`<br>
add the line:
* `blacklist i2c-piix4`<br>
* **reboot**<br>
NOTE: for older versions use `blacklist i2c_piix4` instead.
