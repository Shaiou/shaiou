#!/usr/bin/env bash

apt install -y python-software-properties software-properties-common
for repo in $(cat repositories.txt)
do
    apt-add-repository $repo   
done
apt update -qq
apt -y upgrade

for package in $(cat apt.txt)
do
    apt install -y $package
done

pip install -r pip.txt
for gorepo in $(cat go.txt)
do
    go get -u $gopkg
done
