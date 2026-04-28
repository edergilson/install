sudo pacman -Syu

git clone https://aur.archlinux.org/paru.git ~/paru && cd ~/paru && makepkg -si && cd ~ && sudo rm -rf ~/paru

sudo sed -i '/#UseSyslog/s/#//g' /etc/pacman.conf
sudo sed -i '/#Color/s/#//g' /etc/pacman.conf
sudo sed -i '/#TotalDownload/s/#//g' /etc/pacman.conf
sudo sed -i '/#VerbosePkgLists/s/#//g' /etc/pacman.conf
#echo "
#ILoveCandy" | sudo tee -a /etc/pacman.conf

sudo pacman -Syu && yay -Syua

DRIVERS="mesa lib32-mesa vulkan-intel vulkan-headers lib32-vulkan-intel intel-media-driver libva-intel-driver"
ESSENTIALS="base-devel linux-zen-headers jq meson bat eza thermald throttled git wget power-profiles-daemon"
FONTS="inter-font ttf-hack ttf-hack-nerd ttf-jetbrains-mono-nerd noto-fonts-emoji"
KDEPACKAGES="kcalc ktorrent yakuake kget kdeconnect kompare korganizer kmail spectacle elisa falkon kdevelop kdevelop-php ffmpegthumbnailer ffmpegthumbs kdegraphics-thumbnailers qt6-imageformats"
CODECS="exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore libdvdcss libdvdread libdvdnav dvd+rw-tools dvdauthor dvgrab gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav ffmpeg"
APPS="fish vlc virtualbox audacity meld btop docker docker-compose steam git gimp gimp-help-pt_br haruna vivaldi vivaldi-ffmpeg-codecs firefox libreoffice-fresh hunspell-en_US"

YAYAPPS="google-chrome libreoffice-fresh neofetch pfetch pacfetch steamfetch-bin zeitfetch pridefetch sublime-text-4 visual-studio-code-bin gargoyle brave-bin wine-staging lutris megasync-bin pear-desktop vesktop-bin spotify spicetify-cli insomnia-bin dbgate-bin zen-browser-bin genymotion clementine hunspell-pt-br"
YAYPLUGINS="libdbusmenu-gtk3 lib32-libdbusmenu-gtk3 appmenu-gtk-module-git breeze-enhanced plasma6-applets-eventcalendar plasma6-applets-panel-spacer-extended plasma6-applets-arch-update-notifier plasma6-applets-kara-git plasma6-applets-window-title plasma6-applets-panel-colorizer plasma6-applets-kurve-git plasma6-applets-wallpaper-effects plasma6-applets-resources-monitor firefox-extension-enhancer-for-youtube-bin multi-account-containers-lite"

sudo pacman -S $DRIVERS $ESSENTIALS $FONTS $KDEPACKAGES $CODECS $APPS

sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo modprobe vboxdrv && sudo systemctl enable --now docker && sudo systemctl enable --now thermald && sudo systemctl enable --now throttled && sudo systemctl enable --now power-profiles-daemon

paru -S $YAYAPPS $YAYPLUGINS

git clone https://github.com/kupiqu/SierraBreezeEnhanced.git ~/Git/SierraBreezeEnhanced/ && cd ~/Git/SierraBreezeEnhanced/ && chmod +x install.sh && ./install.sh
git clone https://github.com/D3SOX-Forks/applet-window-buttons6.git ~/Git/applet-window-buttons6/ && cd ~/Git/applet-window-buttons6/ && ./install.sh
git clone https://github.com/matinlotfali/KDE-Rounded-Corners.git ~/Git/KDE-Rounded-Corners && cd ~/Git/KDE-Rounded-Corners/ && mkdir build && cd build && cmake .. && cmake --build . -j && sudo make install
git clone https://github.com/walterfang12/LightlyShaders-Plasma6.git ~/Git/LightlyShaders-Plasma6 && cd ~/Git/LightlyShaders-Plasma6/ && mkdir qt6build && cd qt6build && cmake ../ -DCMAKE_INSTALL_PREFIX=/usr && make && sudo make install
