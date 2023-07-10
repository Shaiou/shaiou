#!/usr/bin/env bash

for package in $(cat pacman.txt)
do
    pacman -Sy $package
done

pip install -r pip.txt

for gorepo in $(cat go.txt)
do
    go install $gopkg
done
