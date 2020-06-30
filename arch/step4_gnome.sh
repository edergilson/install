echo "
[multilib]
Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf

sudo pacman -Syu

git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si && sudo rm -rf ~/yay && yay --editmenu --nodiffmenu --save

sudo sed -i '/#UseSyslog/s/#//g' /etc/pacman.conf
sudo sed -i '/#Color/s/#//g' /etc/pacman.conf
sudo sed -i '/#TotalDownload/s/#//g' /etc/pacman.conf
sudo sed -i '/#VerbosePkgLists/s/#//g' /etc/pacman.conf

sudo pacman -Syu && yay -Syua

## INSTALL BROWSERS ##
sudo pacman -S firefox chromium opera

PACKAGE="gnome-extra qbittorrent tilix pidgin plank pavucontrol pulseaudio"

gpg --recv-keys --keyserver hkp://18.9.60.141 5CC908FDB71E12C2

sudo pacman -Sy exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore flashplugin libdvdcss libdvdread libdvdnav dvd+rw-tools dvdauthor dvgrab

sudo pacman -S zsh vlc clementine virtualbox youtube-dl audacity meld htop docker docker-compose atom mysql-workbench steam git xdotool pulseaudio-bluetooth tlp tlp-rdw $PACKAGE

sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo modprobe vboxdrv && sudo systemctl enable tlp && sudo systemctl start tlp && sudo systemctl enable docker

sudo sed 's/; default-sample-rate = 44100/default-sample-rate = 48000/g' -i /etc/pulse/daemon.conf

cd ~ && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

yay -S google-chrome opera-ffmpeg-codecs vivaldi libreoffice-fresh spotify neofetch-git sublime-text-dev visual-studio-code-bin gitkraken gargoyle-git rambox-bin smartgit insomnia sweethome3d sweethome3d-furniture-library brave-bin freerdp-git sublime-merge
