# Clean up dangling images
`docker rmi $(docker images -f "dangling=true" -q)`

# Add DNS to Docker
Instruct Docker to use the DNS available to the network. Start by verifying their addresses:
```
nmcli dev show | grep 'IP4.DNS'
IP4.DNS[1]:                             10.91.3.31
```
Add them to a new configuration file called `daemon.json`:
`sudo nano /etc/docker/daemon.json`
And insert the following:
```
{
    "dns": ["8.8.8.8", "10.91.3.31"]
}
```
Then restart the service:
`sudo service docker restart`

# Restart docker after VM sleep
docker stop $(docker ps -aq) && sudo systemctl restart NetworkManager docker

# Test NVIDIA Docker
`docker run --gpus all nvcr.io/nvidia/k8s/cuda-sample:nbody nbody -gpu -benchmark`

# Backup Docker image to compressed file
`docker save image:tag | bzip2 > /device/image_backups/image_tag.bz2`
