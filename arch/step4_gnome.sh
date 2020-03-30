echo "
[multilib]
Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf

echo "
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch" | sudo tee -a /etc/pacman.conf

sudo pacman -Syu yaourt && yaourt -Syu

sudo pacman -Sy nvidia nvidia-utils mesa xf86-video-intel bumblebee lib32-virtualgl lib32-nvidia-utils

sudo usermod -aG bumblebee eder && sudo systemctl enable bumblebeed.service

## INSTALL BROWSERS ##
sudo pacman -S firefox chromium opera

PACKAGE="gnome-calculator qbittorrent tilda guake pidgin plank pavucontrol pulseaudio"

gpg --recv-keys --keyserver hkp://18.9.60.141 5CC908FDB71E12C2

sudo pacman -Sy exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore flashplugin libdvdcss libdvdread libdvdnav dvd+rw-tools dvdauthor dvgrab

sudo pacman -S zsh vlc clementine virtualbox thunderbird youtube-dl audacity meld htop docker docker-compose atom mysql-workbench steam git xdotool pulseaudio-bluetooth tlp tlp-rdw $PACKAGE

sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo modprobe vboxdrv && sudo systemctl enable tlp && sudo systemctl start tlp && sudo systemctl enable docker

sudo sed 's/; default-sample-rate = 44100/default-sample-rate = 48000/g' -i /etc/pulse/daemon.conf

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#yaourt -S google-chrome 
#yaourt -S vivaldi 
#yaourt -S wps-office 
#yaourt -S spotify 
#yaourt -S neofetch-git 
#yaourt -S sublime-text-dev 
#yaourt -S visual-studio-code-bin 
#yaourt -S gitkraken 
#yaourt -S gargoyle-git 
#yaourt -S rambox 
#yaourt -S smartgit 
#yaourt -S postman 
#yaourt -S sweethome3d
