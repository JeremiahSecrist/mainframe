#!/usr/bin/sh
USERNAME=auto  

curl -fsSL https://tailscale.com/install.sh | sh
sleep 2
sudo tailscale up --advertise-tags=provision --accept-routes

sudo useradd $USERNAME
sudo mkdir -p /home/$USERNAME/.ssh
sudo sh -c "echo '$USERNAME ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers"

curl -fsSL https://raw.githubusercontent.com/arouzing/mainframe/main/gh-actions.pub -o /home/$USERNAME/.ssh/authorized_keys
