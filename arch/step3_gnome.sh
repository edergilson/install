#!/bin/bash

sudo ip link set $1 up
sudo dhcpcd $1

sudo pacman -Syu gnome gnome-extra ttf-dejavu ttf-hack ttf-liberation ttf-ms-fonts cantarell-fonts noto-fonts gdm xorg xorg-xinit
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec /s/^/# /g' ~/.xinitrc
echo "exec gnome-session" >> ~/.xinitrc
sudo systemctl enable NetworkManager
sudo systemctl enable gdm
