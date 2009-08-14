#!/bin/bash -xe
# inroot.sh - to be run in the chrooted image

echo starting $0
# mount -t proc none /proc
# mount -t sysfs none /sys
export HOME=/root
export LC_ALL=C

apt-get update 
apt-get dist-upgrade

aptitude clean
rm -rf /tmp/* ~/.bash_history
# rm /etc/resolv.conf
# umount /proc
# umount /sys

