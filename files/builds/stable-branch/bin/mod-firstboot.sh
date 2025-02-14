#!/bin/bash

####################################################################################################
# Name:         openSUSE Baldur (MicroOS with XFCE) - MicroOS Desktop Firstboot                    #
# Description:  This file will configure Flatpak and install some minimal applications.            #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2023                                                                               #
# Time/Date:    14:30/17.09.2023                                                                   #
# Version:      1.0.8                                                                              #
####################################################################################################

sleep 10
(
echo "# Waiting for Internet connection"
until /usr/bin/ping -q -c 1 8.8.8.8; do sleep 1; done
echo "10"

echo "# Adding Flathub Repository"
/usr/bin/flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
if [ "$?" != 0 ] ; then
        zenity --error \
          --text="Adding Flathub Repo Failed"
        exit 1
fi
echo "20"

echo "# Installing Firefox"
/usr/bin/flatpak install --user --noninteractive flathub org.mozilla.firefox
if [ "$?" != 0 ] ; then
        zenity --error \
          --text="Installing Firefox Failed"
        exit 1
fi

echo "40"
echo "# Installing Calculator"
/usr/bin/flatpak install --user --noninteractive flathub org.gnome.Calculator
if [ "$?" != 0 ] ; then
        zenity --error \
          --text="Installing Calculator Failed"
        exit 1
fi

echo "60"
echo "# Installing Text Editor"
/usr/bin/flatpak install --user --noninteractive flathub org.xfce.mousepad
if [ "$?" != 0 ] ; then
        zenity --error \
          --text="Installing Text Editor Failed"
        exit 1
fi

echo "100"
echo "# Cleaning up"

rm ~/.config/autostart/mod-firstboot.desktop
) |
        zenity --progress --title="MicroOS Desktop Firstboot" --percentage=0 --auto-close --no-cancel --width=300

if [ "$?" != 0 ] ; then
        zenity --error \
          --title="MicroOS Desktop Firstboot" --text="Firstboot configuration was not completed correctly!"
else
        zenity --info \
          --title="MicroOS Desktop Firstboot" --text="Firstboot configuration was completed successfully!"
fi
rm -f /home/steve/.config/autostart/mod-firstboot.desktop
rm -- "$0"

