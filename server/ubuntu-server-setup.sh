set -ev

export USERNAME="awp"

useradd -m -s /bin/bash $USERNAME
usermod -aG sudo $USERNAME
rsync --archive --chown=$USERNAME:$USERNAME ~/.ssh /home/$USERNAME

# Install nginx and verify that it's serving on localhost:80
apt-get -y update
apt-get -y install nginx make fzf
systemctl status nginx
curl localhost:80 2>/dev/null | grep nginx > /dev/null

ufw allow 'OpenSSH'
ufw allow 'Nginx Full'
ufw --force enable
ufw status

# Login to $USERNAME and install dotfiles
sudo -i -u $USERNAME bash << EOF
git clone https://github.com/alexpetros/dotfiles
cd dotfiles && make && cd ..
EOF

