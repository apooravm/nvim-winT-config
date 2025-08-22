#!/bin/bash

ZSH_URL="sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
GO_URL="https://go.dev/dl/go1.25.0.linux-amd64.tar.gz"
GO_FILE="go1.25.0.linux-amd64.tar.gz"
NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
NVIM_CONFIG="https://github.com/apooravm/nvim-winT-config.git"

mkdir ~/downloads

echo "Updating package lists..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing Zsh..."
sudo apt install -y zsh

# rm -rf /home/admin/.oh-my-zsh
# sh -c "$(curl -fsSL $ZSH_URL)"

sudo passwd

echo "Installing git..."
sudo apt install git -y

echo "Installing build-essential"
sudo apt install build-essential -y

echo "Installing Python"
sudo apt install -y python3 python3-pip -y

echo "Installing go"
curl -LO --output-dir ~/downloads $GO_URL
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf ~/downloads/$GO_FILE
# echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc
# echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc

curl -LO --output-dir ~/downloads $NVIM_URL
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf ~/downloads/nvim-linux-x86_64.tar.gz
# echo "export PATH="$PATH:/opt/nvim-linux-x86_64/bin"" >> ~/.zshrc
# echo "export PATH="$PATH:/opt/nvim-linux-x86_64/bin"" >> ~/.bashrc
# source ~/.zshrc

echo "Installing node"
sudo apt install snapd -y
# echo "export PATH=$PATH:/snap/bin" >> ~/.zshrc
# echo "export PATH=$PATH:/snap/bin" >> ~/.bashrc
sudo snap install node --classic

# mason installation still throws npm not an executable error
# this post explains better - https://www.reddit.com/r/neovim/comments/1972rsm/mason_says_npm_isnt_available_even_though_i_have/
# Basically, mason looks in .zshrc/bashrc for location but it is a function not static path
# this trips it and it cannot find npm
# my solution to this is manually re-adding the path to npm in both .zshrc and .bashrc
# also install unzip, needs for clangd installation

sudo apt install unzip -y
echo "Cloning neovim config"
mkdir ~/.config/nvim
git clone $NVIM_CONFIG ~/.config/nvim/

# autosuggestions for zsh-autosuggestions
# update plugin array in ~/.zshrc by adding zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# /bin/zsh

# echo "Verifying installations..."
# go version
# git --version
# python3 --version
# node --version
# nvim --version
# zsh --version

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BOLD="\e[1m"
YELLOW_BG="\e[43m"
RESET="\e[0m"
EXPORT_PATH="export PATH=\$PATH:/usr/local/go/bin:/opt/nvim-linux-x86_64/bin:/snap/bin"

# without the -e flag escape sequences are treated as literal characters
echo -e "Add binaries to path: \"${YELLOW}echo \"${EXPORT_PATH}\" >> ~/.zshrc${RESET}\""
echo -e "Install oh-my-zsh by running: \"${YELLOW}${ZSH_URL}${RESET}\""
# echo -e "Reload shell: \"${YELLOW}/bin/zsh${RESET}\""
