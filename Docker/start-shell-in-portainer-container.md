# TIP
How to start a shell in a Portainer container:
``` sh
docker cp /usr/bin/busybox portainer:/
docker exec -it portainer /busybox sh
```
