#!/bin/bash -x
ISO=ubuntu-9.04-desktop-i386.iso
qemu -boot d -m 512 -cdrom $ISO
