#!/bin/bash

sudo ip link set $1 up
sudo dhcpcd $1

sudo pacman -Syu deepin deepin-extra ttf-dejavu ttf-hack ttf-liberation cantarell-fonts noto-fonts xorg xorg-xinit networkmanager lightdm
sudo pacman -Syu p7zip unrar tar rsync linux-headers
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec /s/^/# /g' ~/.xinitrc
echo "exec startdde" >> ~/.xinitrc
sudo systemctl enable NetworkManager.service
sudo systemctl enable lightdm

echo "Edit the lightdm.conf with:"
echo "---"
echo "greeter-session=lightdm-deepin-greeter"
read -p "Press enter to edit lightdm.conf:"
sudo nano /etc/lightdm/lightdm.conf ###edit greeter-session=lightdm-deepin-greeter