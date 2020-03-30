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

sudo pacman -S nvidia nvidia-utils mesa xf86-video-intel bumblebee lib32-virtualgl lib32-nvidia-utils

sudo usermod -aG bumblebee eder && sudo systemctl enable bumblebeed.service

## INSTALL BROWSERS ##
sudo pacman -S firefox chromium opera

PACKAGE="qbittorrent pavucontrol pulseaudio"

gpg --recv-keys --keyserver hkp://18.9.60.141 5CC908FDB71E12C2

sudo pacman -S exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore flashplugin libdvdcss libdvdread libdvdnav dvd+rw-tools dvdauthor dvgrab pepper-flash

sudo pacman -S zsh vlc clementine virtualbox youtube-dl audacity meld htop docker docker-compose atom mysql-workbench steam git xdotool pulseaudio-bluetooth tlp tlp-rdw $PACKAGE

sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo modprobe vboxdrv && sudo systemctl enable tlp && sudo systemctl start tlp && sudo systemctl enable docker

sudo sed 's/; default-sample-rate = 44100/default-sample-rate = 48000/g' -i /etc/pulse/daemon.conf

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

yay -S google-chrome 
yay -S opera-ffmpeg-codecs
yay -S vivaldi 
yay -S wps-office ttf-wps-fonts wps-office-extension-portuguese-brazilian-dictionary 
yay -S spotify 
yay -S neofetch-git 
yay -S sublime-text-dev 
yay -S visual-studio-code-bin 
yay -S gitkraken 
yay -S gargoyle-git 
yay -S smartgit 
yay -S insomnia 
yay -S sweethome3d
