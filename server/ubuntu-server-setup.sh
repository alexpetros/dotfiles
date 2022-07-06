set -ev

export USERNAME="awp"

useradd -m -s /bin/bash $USERNAME
usermod -aG sudo $USERNAME
rsync --archive --chown=$USERNAME:$USERNAME ~/.ssh /home/$USERNAME

# Install basic packages
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get -y update
apt-get -y install nginx make fzf nodejs

# Verify that nginx is serving on port 80
systemctl status nginx
curl localhost:80 2>/dev/null | grep nginx > /dev/null

# Install node 18.x
sudo apt-get install -y nodejs

ufw allow 'OpenSSH'
ufw allow 'Nginx Full'
ufw --force enable
ufw status

# Login to $USERNAME and install dotfiles
sudo -i -u $USERNAME bash << EOF
git clone https://github.com/alexpetros/dotfiles
cd dotfiles && make
EOF

