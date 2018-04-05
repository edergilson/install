#!/bin/bash

loadkeys br-abnt2
timedatectl set-ntp true

mkfs.ext4 -F /dev/sda$1
mount /dev/sda$1 /mnt
mkdir /mnt/boot
mount /dev/sda$2 /mnt/boot
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bkp
echo "Server = http://archlinux.c3sl.ufpr.br/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel grub-efi-x86_64 efibootmgr
genfstab -U /mnt >> /mnt/etc/fstab
