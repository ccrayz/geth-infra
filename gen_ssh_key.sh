#!/bin/bash

mkdir -p ssh
ssh_key_dir="ssh"
keypair_name="geth"

if [ -f "$ssh_key_dir/$keypair_name" ]; then
  echo "The $ssh_key_dir/$keypair_name file already exists."
  exit 1
fi

echo "generating SSH keypair..."
ssh-keygen -t rsa -b 4096 -C "Used as a keypair for Geth instances" -f "$ssh_key_dir/$keypair_name"

echo "SSH key generation is complete."
echo "pri key: $ssh_key_dir/$keypair_name"
echo "pub key: $ssh_key_dir/$keypair_name.pub"
