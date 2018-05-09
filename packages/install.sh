#!/usr/bin/env bash

sudo apt install -y python-software-properties software-properties-common
for repo in $(cat repositories.txt)
do
    apt-add-repository $repo   
done
sudo apt update -qq
sudo apt -y upgrade

sudo apt install -y $(cat apt.txt)
pip install -r pip.txt
for gorepo in $(cat go.txt)
do
    go get -u $gopkg
done
