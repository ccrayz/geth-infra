#!/bin/bash
echo "Installing Docker..."

sudo apt-get upgrade -y
sudo apt-get update -y

sudo apt-get install -y \
    net-tools \
    unzip \
    htop \
    gcc \
    build-essential \
    ca-certificates \
    curl \
    gnupg \
    parted

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker ubuntu

echo Mounting NVMe SSD...
MOUNT_GETH_PATH=/data
sudo mkfs.xfs -f /dev/nvme1n1
sudo mkdir $MOUNT_GETH_PATH
sudo mount /dev/nvme1n1 $MOUNT_GETH_PATH

UUID=$(sudo blkid -s UUID -o value /dev/nvme1n1)
echo "UUID=$UUID $MOUNT_GETH_PATH xfs defaults 0 2" | sudo tee -a /etc/fstab

echo "Done!"