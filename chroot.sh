#!/bin/bash -x

cp /etc/resolv.conf edit/etc/
cp sources.list edit/etc/apt/

# mount --bind /dev/ edit/dev

IROOT=inroottest.sh
cp $IROOT edit/tmp
chmod u+x edit/tmp/$IROOT
chroot edit tmp/$IROOT

# chroot edit 

# mount -t proc none /proc
# mount -t sysfs none /sys
# umount edit/dev

