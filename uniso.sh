#!/bin/bash -xe

# expands a ubuntu live CD so you can hack on it 

# mount the iso
if [ ! -d iso ]; then mkdir iso; fi
sudo mount -o loop ubuntu-9.04-desktop-i386.iso iso

# copy all the files except the squashfs file
if [ ! -d extract-cd ]; then mkdir extract-cd; fi
rsync --exclude=/casper/filesystem.squashfs -a iso/ extract-cd

# mount the squashfs and copy all its files 
if [ ! -d squashfs ]; then mkdir squashfs; fi
sudo mount -t squashfs -o loop iso/casper/filesystem.squashfs squashfs
if [ -d edit ]; then
  sudo rm -rf edit/*
else
  mkdir edit
fi
sudo cp -a squashfs/* edit/

