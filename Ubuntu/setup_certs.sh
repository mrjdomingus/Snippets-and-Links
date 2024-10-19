#!/usr/bin/bash

# Check if the username is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USER=$1

# Create the 'certs' directory
mkdir -p ~/"certs"

# Set ownership
chown "$USER:$USER" ~/"certs"

# Create the files with specified permissions and ownership
touch ~/"certs/cert.pem"
chmod 644 ~/"certs/cert.pem"
chown "$USER:$USER" ~/"certs/cert.pem"

touch ~/"certs/chain.pem"
chmod 644 ~/"certs/chain.pem"
chown "$USER:$USER" ~/"certs/chain.pem"

touch ~/"certs/fullchain.pem"
chmod 644 ~/"certs/fullchain.pem"
chown "$USER:$USER" ~/"certs/fullchain.pem"

touch ~/"certs/privkey.pem"
chmod 600 ~/"certs/privkey.pem"
chown "$USER:$USER" ~/"certs/privkey.pem"

# Create the symbolic link
ln -s /home/"$USER"/gitea/data/custom/ ~/"certs/gitea_custom"

# Set the permissions for the 'certs' directory
chmod 700 ~/"certs"
