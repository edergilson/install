#!/bin/bash

sudo ip link set $1 up
sudo dhcpcd $1

sudo pacman -Syu deepin deepin-extra ttf-dejavu ttf-hack ttf-liberation cantarell-fonts noto-fonts xorg xorg-xinit xf86-input-mouse xf86-input-evdev networkmanager lightdm
sudo pacman -Syu p7zip unrar tar rsync linux-headers
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec /s/^/# /g' ~/.xinitrc
echo "exec startdde" >> ~/.xinitrc
sudo systemctl enable NetworkManager.service
sudo systemctl enable lightdm

sudo sed -i '/#greeter-session=/s/^#//g' /etc/lightdm/lightdm.conf
sudo sed -i '/^greeter-session=/s/example-gtk-gnome/lightdm-deepin-greeter/g' /etc/lightdm/lightdm.conf
sudo reboot
