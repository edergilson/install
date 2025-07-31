#!/bin/bash

#loadkeys br-abnt2
#rfkill unblock wifi
#wifi-menu
#timedatectl set-ntp true

#mkfs.ext4 -F /dev/sdb$1
#mount /dev/sdb$1 /mnt
#mkdir /mnt/boot
#mount /dev/sdb$2 /mnt/boot
#cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bkp
#echo "Server = http://archlinux.c3sl.ufpr.br/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel grub-efi-x86_64 efibootmgr intel-ucode os-prober git linux linux-firmware
pacstrap /mnt bash bzip2 dialog wpa_supplicant cryptsetup device-mapper dhcpcd e2fsprogs findutils gawk gcc-libs gettext glibc inetutils iproute2 jfsutils licenses logrotate lvm2 man-db mdadm nano netctl pacman pciutils perl procps-ng psmisc reiserfsprogs s-nail shadow sysfsutils systemd-sysvcompat texinfo usbutils util-linux vi vim xfsprogs
genfstab -U /mnt >> /mnt/etc/fstab
