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
* Indented Block Highlighting
* Python Docstring Generator
* Pylance
* Trailing Spaces (by Shardul Mahadik)
* Duplicate action
* Git Graph
* reStructuredText 

* [Fira Code Font](https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions)
* Ligatures Limited

### Note 1
Set below setting to prevent locks when updating VS Code (on Windows)<br>
```"update.enableWindowsBackgroundUpdates": false```

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
* [How to Install Xrdp Server (Remote Desktop) on Ubuntu 20.04](https://linuxize.com/post/how-to-install-xrdp-on-ubuntu-20-04/)
* [xRDP – The Infamous “Authentication Required to Create Managed Color Device” Explained](https://c-nergy.be/blog/?p=12073)
* [xRDP – Infamous “Authentication required to refresh system repositories” popup on Ubuntu 19.04 – The correct fix !!](https://c-nergy.be/blog/?p=14051)
* [https://github.com/mrjdomingus/Snippets-and-Links/blob/master/Ubuntu/xrdp-installer-1.1.sh](https://github.com/mrjdomingus/Snippets-and-Links/blob/master/Ubuntu/xrdp-installer-1.1.sh)

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

# How to install ip and ping command
```
sudo apt-get update && \
sudo apt-get install -y iproute2 && \
sudo apt-get install -y iputils-ping
```

or

```
apt-get update && \
apt-get install -y iproute2 && \
apt-get install -y iputils-ping
```

# Aliveness check for Redis using netcat
`(printf "PING\r\n";) | nc redis_c3 6379` # redis_c3 is hostname of Redis server

# Defreitas Docker DNS proxy
See [http://mageddo.github.io/dns-proxy-server/latest/en/](http://mageddo.github.io/dns-proxy-server/latest/en/)

# apt-file Wiki
See [https://wiki.debian.org/apt-file](https://wiki.debian.org/apt-file)<br>
Example how to search for ip-utility: `apt-file search --regexp 'bin/ip$'`

# Container discovery when using Docker Swarm
Run DNS lookup (within running container) for tasks.service name i.e. `nslookup tasks.c3_redis_c3` 

# Portainer
Home page: [https://www.portainer.io/](https://www.portainer.io/)<br>
How-To-Install: [https://www.portainer.io/installation/](https://www.portainer.io/installation/)<br>
Documentation: [https://www.portainer.io/documentation/](https://www.portainer.io/documentation/)<br>
```
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
```
You'll just need to access the port **9000** of the Docker engine where portainer is running using your browser.<br><br>
_Note: Port 9000 is the general port used by Portainer for the UI access. Port 8000 is used exclusively by the EDGE agent for the reverse tunnel function. If you do not plan to use the edge agent, you do not need to expose port 8000_<br>

# Swap info
* [SwapFaq](https://help.ubuntu.com/community/SwapFaq)

# Regenerate APT lists cache
```
sudo apt-get clean
cd /var/lib/apt
sudo mv lists lists.old
sudo mkdir -p lists/partial
sudo apt-get clean
sudo apt-get update
sudo apt update
```
