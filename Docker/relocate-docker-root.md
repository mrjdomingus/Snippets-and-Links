To relocate the Docker root directory, complete the following steps as root or a user with “_sudo all_” authority:

Stop the Docker services:
```
sudo systemctl stop docker
sudo systemctl stop docker.socket
sudo systemctl stop containerd
```

Create the necessary directory structure into which to move Docker root by running the following command. This directory structure must reside on a file system with at least 50 GB free disk space.<br> 
Significantly more disk space might be required depending on your daily ingestion volumes and data retention policy.<br>
```
sudo mkdir -p /new_dir_structure
```
Move Docker root to the new directory structure:<br>
```
sudo mv /var/lib/docker /new_dir_structure
```
Edit the file /etc/docker/daemon.json. If the file does not exist, create the file by running the following command:<br>
```
sudo nano /etc/docker/daemon.json
```
Add the following information to this file:
```
{
  "data-root": "/new_dir_structure/docker"
}
```
After the /etc/docker/daemon.json file is saved and closed, restart the Docker services:<br>
```
sudo systemctl start docker
```
After you run the command, all Docker services through dependency management will restart.<br>
Validate the new Docker root location:
```
docker info -f '{{ .DockerRootDir}}'
```
