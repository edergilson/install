#!/bin/bash

# sudo ip link set $1 up
# sudo dhcpcd $1
#sudo rfkill unblock wifi
sudo wifi-menu

####### INSTALL KDE!!! #######
echo "
[multilib]
Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf

sudo pacman -Sy nvidia nvidia-utils mesa nvidia-prime nvidia-settings lib32-virtualgl lib32-nvidia-utils
# sudo usermod -aG bumblebee eder && sudo systemctl enable bumblebeed.service

sudo pacman -Sy plasma-meta sddm xorg xorg-xinit ttf-dejavu ttf-liberation libinput xf86-input-evdev networkmanager
sudo pacman -Sy konsole okular ark kate gwenview dolphin p7zip unrar tar rsync linux-headers
# sudo nano /etc/X11/xinit/xinitrc ###Comment all exec and add exec startkde
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
sed -i '/exec /s/^/# /g' ~/.xinitrc
echo "exec startkde" >> ~/.xinitrc
sudo systemctl enable NetworkManager
sudo systemctl enable sddm
