#!/bin/bash

sudo ip link set $1 up
sudo dhcpcd $1

####### INSTALL KDE!!! #######
sudo pacman -Sy plasma-meta sddm xorg xorg-xinit ttf-dejavu ttf-liberation xf86-input-mouse xf86-input-evdev networkmanager
sudo pacman -Sy konsole okular ark kate gwenview dolphin p7zip unrar tar rsync linux-headers
# sudo nano /etc/X11/xinit/xinitrc ###Comment all exec and add exec startkde
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec /s/^/# /g' ~/.xinitrc
echo "exec startkde" >> ~/.xinitrc
sudo systemctl enable NetworkManager
sudo systemctl enable sddm
