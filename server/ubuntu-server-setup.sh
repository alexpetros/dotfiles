set -ev

export USERNAME="awp"

# Create non-root user with the authorized ssh keys; note that this is a passwordless account
useradd -m -s /bin/bash $USERNAME
usermod -aG sudo $USERNAME
rsync --archive --chown=$USERNAME:$USERNAME ~/.ssh /home/$USERNAME

# Install basic packages
add-apt-repository ppa:certbot/certbot
apt-get -y update
apt-get -y upgrade
apt-get -y install nginx make fzf python-certbot-nginx

# Verify that nginx is serving on port 80
systemctl status nginx
curl localhost:80 2>/dev/null | grep nginx > /dev/null

# Setup firewall to only allow nginx and ssh access
ufw allow 'OpenSSH'
ufw allow 'Nginx Full'
ufw --force enable
ufw status

# Disable password authentication on ssh (yes I'm using ed)
ed /etc/ssh/sshd_config << EOF
%s/^PasswordAuthentication.*/PasswordAuthentication no
%s/^ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no
wq
EOF

# Install node 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs
npm install -g pm2

# Login to $USERNAME and install dotfiles
sudo -i -u $USERNAME bash << EOF
git clone https://github.com/alexpetros/dotfiles
cd dotfiles && make
EOF
