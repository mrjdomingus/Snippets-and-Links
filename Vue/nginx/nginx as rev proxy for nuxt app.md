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

### Redirect nginx server_name to actual server
Redirect nginx to actual server by editing `/etc/hosts` if necessary, i.e. create record like:<br>
`127.0.0.1     mynuxt.com` 
to redirect to localhost.

### Navigate to website
In this example you should navigate to `http://mynuxt.com` which will be redirected to `http://172.0.0.1:3000` (the nuxt app).

### Instructions on how to enable HTTPS/SSL in nginx
See [Configuring HTTPS servers](http://nginx.org/en/docs/http/configuring_https_servers.html)
