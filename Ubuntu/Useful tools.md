# Useful tools to install on Ubuntu

## Curl
`sudo apt install curl`

## Chrome for Desktop

[https://www.google.com/chrome/](https://www.google.com/chrome/)

## Node Version Manager
[https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04)

## Docker and Docker Compose
[https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)

[https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04)

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
* vscode-icons
* npm
* Quokka.js
* Auto Close Tag
* REST Client (by Huachao Mao)
* Paste JSON as Code
* jmespath (by jamesls)
* Bracket Pair Colorizer 2
* Sort lines (by Daniel Imms)
* GitLens
* Todo Tree (by Gruntfugggly)
* DotENV (by mikestead)
* Excel Viewer
* ExpressJs 4 Snippets (by Güray Yarar)

* [Fira Code Font](https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions)

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

## NVidia-Docker
* [https://devblogs.nvidia.com/gpu-containers-runtime/](https://devblogs.nvidia.com/gpu-containers-runtime/)
* [https://github.com/NVIDIA/nvidia-docker](https://github.com/NVIDIA/nvidia-docker)

## CUDA 10 update to TF GPU support for Linux
Also see: [https://www.tensorflow.org/install/gpu](https://www.tensorflow.org/install/gpu)

```
# Add NVIDIA package repository
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
sudo apt install ./cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
sudo apt update

# Install CUDA and tools. Include optional NCCL 2.x
sudo apt install cuda10.0 cuda-cublas-10-0 cuda-cufft-10-0 cuda-curand-10-0 \
    cuda-cusolver-10-0 cuda-cusparse-10-0 libcudnn7=7.4.2.24-1+cuda10.0 \
    libnccl2=2.3.7-1+cuda10.0 cuda-command-line-tools-10-0
```

## Installing Ubuntu 18.04 along with Windows 10 (Dual Boot Installation) for Deep Learning
* [https://hackernoon.com/installing-ubuntu-18-04-along-with-windows-10-dual-boot-installation-for-deep-learning-f4cd91b58557](https://hackernoon.com/installing-ubuntu-18-04-along-with-windows-10-dual-boot-installation-for-deep-learning-f4cd91b58557)


## xRDP
For a script that will install xRDP to enable remote access via RDP, see here:
* [https://github.com/mrjdomingus/Snippets-and-Links/blob/master/Ubuntu/Std-Xrdp-Install-0.2.sh](https://github.com/mrjdomingus/Snippets-and-Links/blob/master/Ubuntu/Std-Xrdp-Install-0.2.sh)

## KeePass
* [http://ubuntuhandbook.org/index.php/2018/09/keepass-password-safe-2-40-released-new-features/](http://ubuntuhandbook.org/index.php/2018/09/keepass-password-safe-2-40-released-new-features/)

## Bookworm (e-book reader)

* [https://babluboy.github.io/bookworm/](https://babluboy.github.io/bookworm/)

# MS SQL Server container
* [https://hub.docker.com/_/microsoft-mssql-server](https://hub.docker.com/_/microsoft-mssql-server)

## Azure Data Studio
* [https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017](https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017)

## NoSQLBooster
* [https://www.nosqlbooster.com/downloads](https://www.nosqlbooster.com/downloads)
