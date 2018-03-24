loadkeys br-abnt2
timedatectl set-ntp true
wifi-menu

mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bkp
echo "Server = http://archlinux.c3sl.ufpr.br/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel grub-efi-x86_64 efibootmgr
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
echo "$HOSTNAME" >> /etc/hostname

nano /etc/locale.gen  ###Uncomment en_US.UTF-8 UTF-8
EDITOR=nano visudo ###Uncomment %wheel ALL = ALL

locale-gen
mkinitcpio -p linux

passwd

USERNAME=eder

useradd $USERNAME
passwd $USERNAME
gpasswd -a $USERNAME wheel
gpasswd -a $USERNAME power
gpasswd -a $USERNAME users
gpasswd -a $USERNAME storage
mkdir /home/$USERNAME
chown $USERNAME:$USERNAME /home/$USERNAME

grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg
exit
reboot

////////////////////////////////////////////////////////

sudo ip link set enp0s3 up
sudo dhcpcd enp0s3

/////// INSTALL KDE!!! ///////
sudo pacman -Sy plasma-meta sddm xorg xorg-xinit ttf-dejavu ttf-liberation networkmanager
sudo pacman -Sy konsole okular ark kate gwenview dolphin p7zip unrar tar rsync linux-headers
sudo nano /etc/X11/xinit/xinitrc ###Comment all exec and add exec startkde
sudo systemctl enable NetworkManager
sudo systemctl enable sddm
sudo reboot

/////// INSTALL GNOME ///////
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
vi /etc/rc.conf ###Add DAEMONS=(syslog-ng dbus network crond)
vi /etc/rc.conf ###Add MODULES=(fuse usblp)
sudo pacman -Syu gnome gnome-extra gdm xorg xorg-xinit
sudo vi ~/.xinitrc ###Comment all exec and add exec gnome-session

/////// INSTALL XFCE ///////
sudo pacman -Sy xorg xorg-xinit
sudo pacman -Sy xfce4 xfce4-goodies xfce4-plugins netowrkmanager slim slim-themes archlinux-themes-slim ###Themes List: /usr/share/slim/themes, /etc/slim.conf | Test: slim -p /usr/share/slim/themes/<nome do tema>
sudo pacman -Sy xfce4-notifyd network-manager-applet udisks2 thunar-volman gvfs p7zip unrar tar rsync linux-headers
sudo systemctl enable NetworkManager.service
sudo systemctl enable slim
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
sudo nano ~/.xinitrc ###Comment all exec and add exec startxfce4
sudo chmod +x ~/.xinitrc
sudo reboot

/////// INSTALL DEEPIN ///////
sudo pacman -Syu deepin deepin-extra xorg xorg-xinit xorg-server networkmanager lightdm
sudo pacman -Syu p7zip unrar tar rsync linux-headers
sudo systemctl enable NetworkManager.service
sudo systemctl enable lightdm
sudo vi /etc/lightdm/lightdm.conf ###edit greeter-session=lightdm-deepin-greeter

////////////////////////////////////////////////////////

// INSTALL YAOURT //
echo "
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf

pacman -Syu yaourt && yaourt -Syu

// INSTALL BROWSERS //
sudo pacman -S firefox chromium opera

# GNOME PACKAGES: PACKAGE="gnome-calculator qbittorrent tilda pidgin plank pavucontrol pulseaudio"
# KDE PACKAGES: PACKAGE="kcalc ktorrent yakuake kdenetwork-kget kdenetwork-kopete amarok kdeconnect kompare ksysguard latte-dock"

gpg --recv-keys --keyserver hkp://18.9.60.141 5CC908FDB71E12C2

sudo pacman -Sy exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore flashplugin libdvdcss libdvdread libdvdnav dvd+rw-tools dvdauthor dvgrab

sudo pacman -S zsh vlc clementine virtualbox thunderbird youtube-dl audacity meld htop docker docker-compose atom mysql-workbench steam git xdotool pulseaudio-bluetooth $PACKAGE

sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo modprobe vboxdrv && sudo systemctl enable tlp && sudo systemctl start tlp && sudo systemctl enable docker

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

yaourt -S google-chrome vivaldi wps-office spotify neofetch-git sublime-text-dev visual-studio-code-bin gitkraken gargoyle-git rambox smartgit postman sweethome3d

sudo pacman -S nvidia nvidia-utils mesa xf86-video-intel bumblebee lib32-virtualgl lib32-nvidia-utils

sudo usermod -aG bumblebee eder && sudo systemctl enable bumblebeed.service





# "update_check": false
