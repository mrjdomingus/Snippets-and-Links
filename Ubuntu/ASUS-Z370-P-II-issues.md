# Tips and issue resolution for Ubuntu on ASUS Z370-P II motherboard

## Slow download speed (slower than upload speed)

The solution is available at this [link](https://www.unixblogger.com/how-to-get-your-realtek-rtl8111rtl8168-working-updated-guide/).

In summary, here is what I did that solved the issue.

* Did: `sudo apt-get update`
* Did: `sudo apt-get install r8168-dkms` (presumably to install the r8168 kernel driver (suppressing the r8169 driver that came default with the kernel))
* Reboot the PC

After reboot the Wired Ethernet performed with the expected download speed.

