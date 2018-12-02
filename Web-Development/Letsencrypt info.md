# Interesting info re: Let's encrypt certificates

* How to create: [https://itnext.io/node-express-letsencrypt-generate-a-free-ssl-certificate-and-run-an-https-server-in-5-minutes-a730fbe528ca](https://itnext.io/node-express-letsencrypt-generate-a-free-ssl-certificate-and-run-an-https-server-in-5-minutes-a730fbe528ca)

## Handle automatic renewal of certificate with stop / restart of node

First using `cron` this is the content of my crontab:

`30 9 * * * certbot renew --standalone --pre-hook "pm2 stop server" --post-hook "pm2 start server"`

I don’t know how familiar you are with cron jobs so this is how I did:

`$ crontab -e` : Lets you edit the cron jobs using nano or anything else

`30 9 * * *` : Means that what follows will be run each day at 9:30 AM.

`certbot renew --standalone`: Issues a new certificate if needed, at the exact same place as the existing one, without asking any information.

`--pre-hook / --post-hook ”command"` : Before / Once the certificate is renewed, run this command

As I’m using `pm2` to manage my server, I simply call `pm2 stop / start server` and everything should go alright.

All this stuff assumes you’re on Linux, having `certbot` available globally, and using `pm2`. 
Changing the `pm2` command should be easy enough in case you’re dealing with another process manager.
