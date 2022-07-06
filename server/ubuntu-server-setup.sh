set -ev

export USERNAME="awp"

useradd -m -s /bin/bash $USERNAME
usermod -aG sudo $USERNAME
rsync --archive --chown=$USERNAME:$USERNAME ~/.ssh /home/$USERNAME

# Install basic packages
apt-get -y update
apt-get -y install nginx make fzf

# Verify that nginx is serving on port 80
systemctl status nginx
curl localhost:80 2>/dev/null | grep nginx > /dev/null

ufw allow 'OpenSSH'
ufw allow 'Nginx Full'
ufw --force enable
ufw status

# Install node 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs
npm install -g pm2

# Login to $USERNAME and install dotfiles
sudo -i -u $USERNAME bash << EOF
git clone https://github.com/alexpetros/dotfiles
cd dotfiles && make
EOF

