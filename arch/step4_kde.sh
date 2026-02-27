sudo pacman -Syu

git clone https://aur.archlinux.org/yay.git ~/yay && cd ~/yay && makepkg -si && sudo rm -rf ~/yay && yay --editmenu --nodiffmenu --save

sudo sed -i '/#UseSyslog/s/#//g' /etc/pacman.conf
sudo sed -i '/#Color/s/#//g' /etc/pacman.conf
sudo sed -i '/#TotalDownload/s/#//g' /etc/pacman.conf
sudo sed -i '/#VerbosePkgLists/s/#//g' /etc/pacman.conf
echo "
ILoveCandy" | sudo tee -a /etc/pacman.conf

sudo pacman -Syu && yay -Syua

KDEPACKAGES="kcalc ktorrent yakuake kget kdeconnect kompare korganizer kmail spectacle elisa falkon kdevelop kdevelop-php ffmpegthumbnailer ffmpegthumbs"
CODECS="exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore libdvdcss libdvdread libdvdnav dvd+rw-tools dvdauthor dvgrab"
APPS="fish vlc virtualbox audacity meld htop docker docker-compose steam git gimp	gimp-help-pt_br haruna vivaldi vivaldi-ffmpeg-codecs"

YAYAPPS="google-chrome libreoffice-fresh neofetch pfetch pacfetch steamfetch-bin zeitfetch pridefetch sublime-text-4 visual-studio-code-bin gargoyle brave-bin wine-staging lutris megasync-bin pear-desktop vesktop-bin spotify spicetify-cli insomnia-bin dbgate-bin zen-browser-bin genymotion clementine"
YAYPLUGINS="libdbusmenu-gtk3 lib32-libdbusmenu-gtk3 appmenu-gtk-module-git breeze-enhanced sierra-breeze-enhanced plasma6-applet-freeradio plasma6-applets-eventcalendar plasma6-applets-panel-spacer-extended plasma6-applets-arch-update-notifier plasma6-applets-kara-git plasma6-wallpapers-blurredwallpaper-git plasma6-applets-window-title plasma6-applets-uswitch plasma6-applets-panel-colorizer plasma6-wallpapers-smart-video-wallpaper-reborn plasma6-applets-kurve-git plasma6-applets-wallpaper-effects plasma6-applets-resources-monitor firefox-globalmenu firefox-extension-enhancer-for-youtube-bin multi-account-containers-lite"

sudo pacman -S $KDEPACKAGES $CODECS $APPS

sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo modprobe vboxdrv && sudo systemctl enable --now docker && sudo systemctl enable --now bluetooth

yay -S $YAYAPPS $YAYPLUGINS
