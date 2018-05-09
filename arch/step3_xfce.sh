#!/bin/bash

sudo ip link set $1 up
sudo dhcpcd $1

sudo pacman -Sy xorg xorg-xinit
sudo pacman -Sy xfce4 xfce4-goodies networkmanager ttf-dejavu ttf-hack ttf-liberation cantarell-fonts noto-fonts lightdm lightdm-gtk-greeter
sudo pacman -Sy xfce4-notifyd network-manager-applet udisks2 thunar-volman gvfs p7zip unrar tar rsync linux-headers
sudo systemctl enable NetworkManager.service
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec /s/^/# /g' ~/.xinitrc
echo "exec startxfce4" >> ~/.xinitrc
sudo chmod +x ~/.xinitrc
sudo systemctl enable NetworkManager
sudo systemctl enable lightdm
echo "Change the file /etc/lightdm/lightdm.conf and add:"
echo "greeter-session=lightdm-gtk-greeter"
echo "---"
# sudo reboot
