#!/usr/bin/env bash
set -ev

sudo mkdir /Workspace
sudo chown $USER /Workspace
git config --global user.name "Shailendra Narayen"
# HOME ONLY
#git config --global user.email "shailendranarayen@gmail.com"
#echo '/dev/nvme0n1p5 /Workspace ext4' | sudo tee -a /etc/fstab
#sudo systemctl daemon-reload
#sudo mount /Workspace
./install-packages.sh
sudo usermod -aG docker $USER
xdg-settings set default-web-browser google-chrome.desktop
