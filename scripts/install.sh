#!/usr/bin/env bash

log()
{
  echo -e "\033[1;36m$1\033[0m"
}

log "Set TimeZone to Asia/Seoul"
sudo timedatectl set-timezone 'Asia/Seoul'

log "Update Packages & Set .bash_profile"
sudo apt-get update
sudo apt-get upgrade -y
cd ~ && touch .bash_profile
echo -e '\n# Include .bashrc\nif [ -f "$HOME/.bashrc" ]; then\n  . "$HOME/.bashrc"\nfi' >> ~/.bash_profile

# Install Pyenv
log "Install Pyenv"
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile
source ~/.bash_profile

# Install Pyenv Dependencies
log "Install Pyenv Dependencies"
sudo apt-get install -y gcc g++ build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

# Install Python 3.8.5 with Pyenv
log "Install Python 3.8.5 with Pyenv"
pyenv install 3.8.5
pyenv global 3.8.5

# Install Nginx
log "Install Nginx"
sudo apt-get install -y nginx

# Upgrade pip
log "Upgrade pip"
python3 -m pip install --upgrade pip

# Install Django & Pillow
log "Install Django & Pillow"
python3 -m pip install Django
python3 -m pip install Pillow

# Install Gunicorn
log "Install Gunicorn"
python3 -m pip install gunicorn

source ~/.bash_profile
log "[Nginx - Gunicorn - Python Django] Installation Successful"
