#!/usr/bin/bash

# Check if the hostname and username is provided as an argument
if [ $# -ne 2 ]; then
    echo "Usage: $0 <hostname> <username>"
    exit 1
fi

HOST=$1
USER=$2

find /etc/letsencrypt/live/"$HOST" -name "fullchain.pem" -exec cat '{}' > /home/"$USER"/gitea/data/custom/fullchain.pem \;
find /etc/letsencrypt/live/"$HOST" -name "privkey.pem" -exec cat '{}' > /home/"$USER"/gitea/data/custom/privkey.pem \;
find /etc/letsencrypt/live/"$HOST" -name "privkey.pem" -exec cat '{}' > /home/"$USER"/certs/privkey.pem \;
find /etc/letsencrypt/live/"$HOST" -name "fullchain.pem" -exec cat '{}' > /home/"$USER"/certs/fullchain.pem \;
find /etc/letsencrypt/live/"$HOST" -name "chain.pem" -exec cat '{}' > /home/"$USER"/certs/chain.pem \;
find /etc/letsencrypt/live/"$HOST" -name "cert.pem" -exec cat '{}' > /home/"$USER"/certs/cert.pem \;
