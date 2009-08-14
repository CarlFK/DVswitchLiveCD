#!/bin/bash -xe

VER=0.7

KVER=2.6.28-14-generic
# cp edit/boot/vmlinuz-$KVER extract-cd/casper/vmlinuz
# cp edit/boot/initrd.img-$KVER extract-cd/casper/initrd.gz

chmod +w extract-cd/casper/filesystem.manifest
chroot edit dpkg-query -W --showformat='${Package} ${Version}\n' > extract-cd/casper/filesystem.manifest
cp extract-cd/casper/filesystem.manifest extract-cd/casper/filesystem.manifest-desktop
sed -i '/ubiquity/d' extract-cd/casper/filesystem.manifest-desktop

rm -f extract-cd/casper/filesystem.squashfs
mksquashfs edit/ extract-cd/casper/filesystem.squashfs -nolzma
# mksquashfs /home/carl/Videos/ubuntu/jaunty/dvswitch/edit/ extract-cd/casper/filesystem.squashfs -nolzma
# mksquashfs /home/carl/Videos/ubuntu/jaunty/dvswitch-v$VER/edit/ extract-cd/casper/filesystem.squashfs -nolzma
# mksquashfs /home/carl/Videos/ubuntu/jaunty/dvswitch/edit/ extract-cd/casper/filesystem.squashfs -nolzma
rm extract-cd/md5sum.txt
(cd extract-cd && find . -type f -print0 | xargs -0 md5sum | tee md5sum.draft)
cat extract-cd/md5sum.draft | grep -v md5sum.txt | grep -v isolinux/boot.cat > extract-cd/md5sum.txt
rm extract-cd/md5sum.draft

cd extract-cd
IMAGE_NAME=DVswitch-$VER
DST=../ubuntu-9.04-dvswitch-i386-$VER.iso 
mkisofs -D -r -V "$IMAGE_NAME" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o $DST .
chmod 777 $DST
chown carl:carl $DST
cp $DST /mnt/nfs/shaz/root/var/lib/tftpboot/ubuntu/jaunty/dvswitch/ & cp $DST ~/a &
# cdrecord -eject $DST

