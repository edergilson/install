#!/bin/bash

#sudo ip link set $1 up
#sudo dhcpcd $1

echo "
[multilib]
Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf

sudo pacman -Sy nvidia nvidia-utils mesa bumblebee nvidia-settings lib32-virtualgl lib32-nvidia-utils
sudo usermod -aG bumblebee eder && sudo systemctl enable bumblebeed.service

sudo pacman -Syu gnome gnome-extra ttf-dejavu ttf-hack ttf-liberation cantarell-fonts noto-fonts gdm xorg xorg-xinit libinput xf86-input-evdev networkmanager p7zip unrar tar rsync linux-headers
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec /s/^/# /g' ~/.xinitrc
echo "export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
exec gnome-session" >> ~/.xinitrc
sudo systemctl enable NetworkManager
sudo systemctl enable gdm

sudo reboot
