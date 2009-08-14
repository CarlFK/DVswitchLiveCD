#!/bin/bash +x
# inroot.sh - to be run in the chrooted image

mount -t proc none /proc
mount -t sysfs none /sys
export HOME=/root
export LC_ALL=C

apt-get purge openoffice.org-common openoffice.org-help-en-gb openoffice.org-l10n-common openoffice.org-hyphenation openoffice.org-hyphenation-en-us
apt-get purge evolution-common evolution-webcal evolution-documentation-en
apt-get purge compiz compiz-core
apt-get install vim, curl

DIST=jaunty
sed -i "s/\($DIST\(-security\|-updates\)* main restricted$\)/\1 multiverse universe/" /etc/apt/sources.list
printf "\ndeb http://ppa.launchpad.net/carlfk/ppa/ubuntu $DIST main\n" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A224C43C
printf "\ndeb http://apt.wxwidgets.org/ $DIST-wx main\n" >> /etc/apt/sources.list
curl http://apt.wxwidgets.org/key.asc | sudo apt-key add -

apt-get update 
apt-get upgrade
apt-get install dvsmon
# apt-get install python-wxgtk2.8 python-wxtools wx2.8-i18n
apt-get install screen openssh-server nfs-common xclip python-setuptools kerneloops kexec-tools tftp
apt-get install ffmpeg ffmpeg2theora oggfwd
apt-get install kino mplayer
# apt-get install alsa-tools audacious-plugins audacity avidemux avidemux-common bug-buddy cdrdao console-tools\
# deskbar-applet fdutils flac freeglut3 gimp gimp-python gstreamer0.10-ffmpeg gstreamer0.10-plugins-bad\
#  gstreamer0.10-plugins-ugly hwtest hwtest-gtk iamerican ibritish idjc ispell jackd mii-diag mozilla-plugin-vlc\
#   nautilus-cd-burner openssl-blacklist qjackctl scantv scrollkeeper sweep sysvutils twinkle util-linux-locales\
#    v4l-conf vlc vlc-nox vlc-plugin-pulse vorbis-tools wvdial xawtv xawtv-plugins xbase-clients xutils

printf "# ieee1394 devices\nKERNEL==\"raw1394\",    GROUP=\"video\"">  /etc/udev/rules.d/91-permissions.rules

# put user in video group
printf "\nADD_EXTRA_GROUPS=1\nEXTRA_GROUPS="video"\n" >> /etc/adduser.conf

# disable cpu freq scaling
# no clue if this A) works B) needed
# cat  etc/init.d/cpufrequtils 
# GOVERNOR=performance

# add icons to desktop
cd /usr/share/applications/
cp gnome-terminal.desktop dvsmon.desktop /etc/skel/

# make dvswitch monitor run on boot:
cd etc/xdg/autostart
# ln -s /usr/share/applications/dvsmon.desktop # no work
cp ../../../usr/share/applications/dvsmon.desktop .

# make dvswitch listen on all interfaces
cat <<EOT > /etc/dvswitchrc
MIXER_HOST=0.0.0.0
MIXER_PORT=54321
EOT

aptitude clean
rm -rf /tmp/* ~/.bash_history
# rm /etc/resolv.conf
umount /proc
umount /sys
echo exit
echo sudo umount edit/dev

