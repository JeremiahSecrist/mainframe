#!/usr/bin/sh
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --advertise-tags=tag:provis,gh

sudo useradd auto
sudo 

curl -fsS: https://raw.githubusercontent.com/arouzing/mainframe/main/gh-actions.pub 
