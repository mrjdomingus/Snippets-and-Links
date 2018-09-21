# How to set up nginx as reverse proxy for a nuxt app

The following assumes deployment of the [next-community/express template](https://github.com/nuxt-community/express-template)
and deployment of a containerized [nginx](https://hub.docker.com/_/nginx/).

## Steps

### Change the supplied `nginx.conf`
Verify and change as desired:
* `listen`
* `server_name` 
* `location`
* `proxy_pass`

### Build a custom nginx image using the supplied `Dockerfile`
Execute `docker build -t nginx:custom .` 

During the build the custom `nginx.conf` will be imported into the image.

### Create container using network "host" 
Execute `docker run --network="host" nginx:custom`
(or use "bridge", but then you will have to change `nginx.conf`)

### Navigate to website
In this example you should navigate to `http://mynuxt.com` which will be redirected to `http://172.0.0.1:3000` (the nuxt app).
