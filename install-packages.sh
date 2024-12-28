#!/usr/bin/env bash
set -ev

for package in $(cat packages/pacman.txt)
do
    sudo pacman -Sy $package --noconfirm
done

for package in $(cat packages/yay.txt)
do
    yay -Sy $package --noconfirm
done

sudo usermod -aG docker $USER

pip install -r pip.txt

for gorepo in $(cat packages/go.txt)
do
    go install $gopkg
done
