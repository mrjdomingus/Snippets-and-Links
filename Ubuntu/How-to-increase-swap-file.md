Via [https://askubuntu.com/questions/927854/how-do-i-increase-the-size-of-swapfile-without-removing-it-in-the-terminal](https://askubuntu.com/questions/927854/how-do-i-increase-the-size-of-swapfile-without-removing-it-in-the-terminal)

First disable swap file:

`sudo swapoff /swapfile`

Replace original swap file:

`sudo fallocate -l 8G /swapfile`

Prevent prying eyes:

`sudo chmod 600 /swapfile`

Setup the file as a "swap file":

`sudo mkswap /swapfile`

enable swapping:

`sudo swapon /swapfile`

Verify it is working with: 

`sudo swapon --show`
