#!/usr/bin/sh

# init varriables
USERNAME=auto  
USERPATH=/home/$USERNAME

# install tailscale
which tailscale || curl -fsSL https://tailscale.com/install.sh | sh
sleep 2
sudo tailscale up --advertise-tags=tag:ansible --accept-routes >> tailscale.log &

#create user with proper keys
sudo useradd $USERNAME
sudo mkdir -p /home/$USERNAME/.ssh
grep -q "$USERNAME ALL=(ALL:ALL) NOPASSWD:ALL" /etc/sudoers || sudo sh -c "echo '$USERNAME ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers"

sudo chmod go-w $USERPATH || sudo mkdir -p $USERPATH ; sudo chmod go-w $USERPATH 
# download public key for ssh 
curl -fsSL https://raw.githubusercontent.com/arouzing/mainframe/main/gh-actions.pub -o /home/$USERNAME/.ssh/authorized_keys
# permission verification
sudo chown $USERNAME "$USERPATH/.ssh/authorized_keys"
sudo chmod 700 "$USERPATH/.ssh"
sudo chmod 600 "$USERPATH/.ssh/authorized_keys"
sudo systemctly enable --now sshd

# display logs from before
cat ./tailscale.log
