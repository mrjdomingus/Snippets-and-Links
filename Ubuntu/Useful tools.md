# Useful tools to install on Ubuntu

## Curl
`sudo apt install curl`

## Chrome for Desktop

[https://www.google.com/chrome/](https://www.google.com/chrome/)

## Node Version Manager
[https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04)

## Docker
[https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)

To prevent the following message from Docker: _Your kernel does not support swap limit capabilities_ <br>
Update `/etc/default/grub` and set:<br>
`GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"` <br>
run `update-grub` && **reboot** <br>

## Visual Studio Code for Insiders

[https://code.visualstudio.com/insiders/](https://code.visualstudio.com/insiders/)

### Useful VSC extensions
* Vetur
* Vue 2 Snippets
* Vue VSCode Snippets
* vue-beautify
* JavaScript (ES6) code snippets (by Charalampos Karypidis)
* Debugger for Chrome
* ESLint
* Docker
* Beautify
* npm
* Quokka.js
* Auto Close Tag
* REST Client (by Huachao Mao)
* Paste JSON as Code
* jmespath (by jamesls)

## Gitkraken

[https://www.gitkraken.com/](https://www.gitkraken.com/)<br>
If GitKraken does not start after install:
* install libgnome-keyring: `sudo apt install libgnome-keyring0` (via [https://unix.stackexchange.com/questions/447589/gitkraken-does-not-start-anymore-on-ubuntu-18-04](https://unix.stackexchange.com/questions/447589/gitkraken-does-not-start-anymore-on-ubuntu-18-04))

## Postman
[https://www.ceos3c.com/open-source/install-postman-ubuntu-18-04/](https://www.ceos3c.com/open-source/install-postman-ubuntu-18-04/)

## SQLite 3
[https://www.techinfected.net/2018/01/how-to-install-sqlite3-in-ubuntu-linux-mint.html](https://www.techinfected.net/2018/01/how-to-install-sqlite3-in-ubuntu-linux-mint.html)

Install by executing:<br>
```
sudo apt-get update
sudo apt-get install sqlite3 libsqlite3-dev
```
## CUDA Toolkit
* [https://docs.nvidia.com/cuda/index.html](https://docs.nvidia.com/cuda/index.html)
* [https://www.pugetsystems.com/labs/hpc/How-To-Install-CUDA-10-together-with-9-2-on-Ubuntu-18-04-with-support-for-NVIDIA-20XX-Turing-GPUs-1236/](https://www.pugetsystems.com/labs/hpc/How-To-Install-CUDA-10-together-with-9-2-on-Ubuntu-18-04-with-support-for-NVIDIA-20XX-Turing-GPUs-1236/)


