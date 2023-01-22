sudo pacman -Syu

git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si && sudo rm -rf ~/yay && yay --editmenu --nodiffmenu --save

sudo sed -i '/#UseSyslog/s/#//g' /etc/pacman.conf
sudo sed -i '/#Color/s/#//g' /etc/pacman.conf
sudo sed -i '/#TotalDownload/s/#//g' /etc/pacman.conf
sudo sed -i '/#VerbosePkgLists/s/#//g' /etc/pacman.conf

sudo pacman -Syu && yay -Syua

## INSTALL BROWSERS ##
sudo pacman -S firefox

PACKAGE="kcalc ktorrent yakuake kget kdeconnect kompare ksysguard korganizer kmail spectacle elisa falkon kdevelop kdevelop-php ffmpegthumbnailer ffmpegthumbs"

gpg --recv-keys --keyserver hkp://18.9.60.141 5CC908FDB71E12C2

sudo pacman -S exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore libdvdcss libdvdread libdvdnav dvd+rw-tools dvdauthor dvgrab cups

sudo pacman -S fish vlc clementine virtualbox youtube-dl audacity meld htop docker docker-compose dbeaver steam git xdotool pulseaudio-bluetooth tlp tlp-rdw $PACKAGE

sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo modprobe vboxdrv && sudo systemctl enable tlp && sudo systemctl start tlp && sudo systemctl enable docker && sudo systemctl enable bluetooth

sudo sed 's/; default-sample-rate = 44100/default-sample-rate = 48000/g' -i /etc/pulse/daemon.conf

yay -S google-chrome libreoffice-fresh neofetch-git sublime-text-4 visual-studio-code-bin gitkraken gargoyle-git ferdium-bin smartgit sweethome3d sweethome3d-furniture-library brave-bin wine-staging lutris

yay -S latte-dock-git libdbusmenu-gtk3 lib32-libdbusmenu-gtk3 appmenu-gtk-module-git breeze-enhanced-git plasma5-applets-window-title-git plasma5-applets-window-appmenu-git plasma5-applets-window-buttons-git kwin-effect-shapecorners-git libinput-gestures-git plasma5-applets-eventcalendar pfetch-git
