#!/usr/bin/env bash

for package in $(cat pacman.txt)
do
    pacman -Sy $package --noconfirm
done

for gorepo in $(cat go.txt)
do
    go install $gopkg
done

for asdfplugin in $(cat asdf.txt)
do
    asdf plugin-add $asdfplugin
    asdf install $asdfplugin latest
    asdf global $asdfplugin latest
done

# Add crontab for battery
#crontab -e
#* * * * *  export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus && /home/shailendra/bin/battery.sh

