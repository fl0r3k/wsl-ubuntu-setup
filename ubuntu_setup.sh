#!/bin/bash

USER_NAME=`whoami`

# Add package repositories
sudo add-apt-repository -r -y -n ppa:neovim-ppa/unstable
sudo add-apt-repository -y -n ppa:neovim-ppa/unstable

# Ugrade all installed packages
sudo apt update
sudo apt upgrade -y

# Install packages
sudo apt install -y \
	build-essential \
	curl \
	fd-find \
	fzf \
	git \
	jq \
	libbz2-dev \
	libffi-dev \
	liblzma-dev \
	libncursesw5-dev \
	libreadline-dev \
	libsqlite3-dev \
	libssl-dev \
	libxml2-dev \
	libxmlsec1-dev \
	neovim \
	python3 \
	python3-pip \
	python-is-python3 \
	ripgrep \
	stow \
	tk-dev \
	tmux \
	unzip \
	xz-utils \
	zlib1g-dev \
	zsh

# pyenv
rm -rf ~/.pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src
cd

# Install Python with pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
pyenv install 3.10
pyenv global 3.10

# nvm
rm -rf ~/.nvm
git clone https://github.com/nvm-sh/nvm.git .nvm

# Install node with nvm
export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
nvm install node

# bitwarden-cli
sudo rm -f /usr/local/bin/bw
wget -O /tmp/bw-linux.zip "https://vault.bitwarden.com/download/?app=cli&platform=linux"
sudo unzip /tmp/bw-linux.zip -d /usr/local/bin

# Change shell to zsh
sudo usermod -s zsh $USER_NAME

# Get and setup dotfiles
rm -rf .dotfiles
git clone git@github.com:fl0r3k/dotfiles.git .dotfiles
cd .dotfiles
stow .
cd

# Install oh-my-zsh
rm -rf ~/.oh-my-zsh
RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Tmux Plugin Manager and setup
rm -rf ~/.config/tmux/plugins
git clone https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm
~/.config/tmux/plugins/tpm/scripts/install_plugins.sh


echo "Installation complete. Restart terminal to reload environment"