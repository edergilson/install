#/bin/sh

# Fix Dell Latitude 7420 slow CPU
# sudo rmmod intel_rapl_msr
# echo "blacklist intel_rapl_msr" | sudo tee -a /etc/modprobe.d/intel_rapl_msr-blacklist.conf

# Install RPM Fusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf group upgrade -y core

# Update files
sudo dnf -y update
sudo dnf -y upgrade --refresh
sudo dnf group upgrade -y core

# Media Codecs
sudo dnf group upgrade -y 'core' 'multimedia' --setopt='install_weak_deps=False' --allowerasing && sync
sudo dnf swap -y 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=true
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav lame\* ffmpeg ffmpeg-libs libva libva-utils openh264 gstreamer1-plugin-openh264 mozilla-openh264 --exclude=gstreamer1-plugins-bad-free-devel --exclude=lame-devel 

# Flatpak Update
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak update

# Importing Keys
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

# Adding Repos
printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscode.repo
echo -e "[microsoft-edge]\nname=microsoft-edge\nbaseurl=https://packages.microsoft.com/yumrepos/edge/\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc"|sudo tee /etc/yum.repos.d/microsoft-edge.repo
sudo dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf copr enable -y observeroftime/betterdiscordctl
sudo dnf copr enable -y hazel-bunny/ricing

# Enable packages
sudo dnf config-manager setopt google-chrome.enabled=true

# Apps
sudo dnf install -y mesa-dri-drivers.i686 mesa-libGL.i686 xorg-x11-drv-intel unzip p7zip p7zip-plugins unrar fish vim gnome-tweaks clementine youtube-dl audacity meld htop btop tilix docker docker-compose steam lutris git discord google-chrome-stable code microsoft-edge-stable sublime-text betterdiscordctl

# Flatpaks
flatpak install flathub io.github.lime3ds.Lime3DS net.kuribo64.melonDS net.pcsx2.PCSX2 com.snes9x.Snes9x io.mgba.mGBA org.ryujinx.Ryujinx nz.mega.MEGAsync

# Configs
sudo usermod -aG docker $USER && sudo systemctl enable docker

# Install SierraBreezeEnhanced Theme
sudo dnf install -y cmake extra-cmake-modules kf6-kiconthemes-devel qt6-qt5compat-devel kf6-kcmutils-devel qt6-qtbase-private-devel kf6-kcoreaddons-devel "cmake(Qt6Core)" "cmake(Qt6Gui)" "cmake(Qt6DBus)" "cmake(KF6GuiAddons)" "cmake(KF6WindowSystem)" "cmake(KF6I18n)" "cmake(KDecoration3)" "cmake(KF6CoreAddons)" "cmake(KF6ConfigWidgets)"
git clone https://github.com/kupiqu/SierraBreezeEnhanced.git ~/Git/SierraBreezeEnhanced/ && cd ~/Git/SierraBreezeEnhanced/ && chmod +x install.sh && ./install.sh

# Install Applets
sudo dnf install -y kf6-ksvg-devel kf6-kdeclarative-devel libplasma-devel kwin-devel
git clone https://github.com/moodyhunter/applet-window-buttons6.git ~/Git/applet-window-buttons6/ && cd ~/Git/applet-window-buttons6/ && ./install.sh

sudo git clone https://github.com/dhruv8sh/plasma6-window-title-applet.git /usr/share/plasma/plasmoids/org.kde.windowtitle && sudo rm /usr/share/plasma/plasmoids/org.kde.windowtitle/README.md

git clone https://github.com/ryanoasis/nerd-fonts.git ~/Git/nerd-fonts && cd ~/Git/nerd-fonts && ./install.sh Hack
# Hazzel Ricing new Items
sudo dnf install -y kara chatai-plasmoid kde-rounded-corners kwin-effects-forceblur lightlyshaders

# Install Oh-My-Fish
chsh -s /usr/bin/fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v6
