# Tips and issue resolution for Ubuntu on ASUS Z370-P II motherboard

## Slow download speed (slower than upload speed)

The solution is available at this [link](https://www.unixblogger.com/how-to-get-your-realtek-rtl8111rtl8168-working-updated-guide/).

In summary, here is what I did that solved the issue.

* Did: `sudo apt-get update`
* Did: `sudo apt-get install r8168-dkms` (presumably to install the r8168 kernel driver (suppressing the r8169 driver that came default with the kernel))
* Reboot the PC

After reboot the Wired Ethernet performed with the expected download speed.

## Switch default boot menu optie between Win10 and Ubuntu

* Add Win10 as first boot menu option in GRUB
* Add Ubuntu as second boot menu option in GRUB
* From Win 10 or Ubuntu edit `/boot/grub/grub.cfg`
* Change line with `set default="1"`, set default to **0** for first boot menu option, to **1** for second boot menu option.
* Save and reboot.

