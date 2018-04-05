#!/bin/bash

USERNAME="eder"
HOSTNAME="Arch-Aspire-E5-573G"

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "$HOSTNAME" >> /etc/hostname

nano /etc/locale.gen  ###Uncomment en_US.UTF-8 UTF-8 and pt_BR.UTF-8 UTF-8
# sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen
# sed -i '/pt_BR.UTF-8/s/^#//g' /etc/locale.gen
EDITOR=nano visudo ###Uncomment %wheel ALL = ALL
# sed -i '/sudo /s/^# //g' /etc/sudoers

locale-gen
mkinitcpio -p linux

echo -r "$1" | passwd

useradd $USERNAME
echo -r "$1" | passwd $USERNAME
gpasswd -a $USERNAME sudo
gpasswd -a $USERNAME power
gpasswd -a $USERNAME users
gpasswd -a $USERNAME storage
mkdir -p /home/$USERNAME/Documents
mkdir -p /home/$USERNAME/Downloads/Torrents/.files
mkdir -p /home/$USERNAME/Music/.others
mkdir -p /home/$USERNAME/Pictures/.others
mkdir -p /home/$USERNAME/Pictures/Wallpapers/.others
mkdir -p /home/$USERNAME/Videos/.others
chown $USERNAME:$USERNAME /home/$USERNAME

grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=Arch
grub-mkconfig -o /boot/grub/grub.cfg
