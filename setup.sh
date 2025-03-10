#!/usr/bin/env bash
set -ev

sudo mkdir /Workspace
sudo chown $USER /Workspace
git config --global user.name "Shailendra Narayen"
git config --global user.email "shailendranarayen@gmail.com"

# install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# power10k prompt for oh myzsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

./install-packages.sh
sudo usermod -aG docker $USER
xdg-settings set default-web-browser google-chrome.desktop

git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
