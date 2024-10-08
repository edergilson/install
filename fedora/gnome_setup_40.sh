#/bin/sh

# Fix Dell Latitude 7420 slow CPU
sudo rmmod intel_rapl_msr
echo "blacklist intel_rapl_msr" | sudo tee -a /etc/modprobe.d/intel_rapl_msr-blacklist.conf

# Fast Updates
echo "[main] 
gpgcheck=1 
installonly_limit=3 
clean_requirements_on_remove=True 
best=False 
skip_if_unavailable=True 
fastestmirror=1 
max_parallel_downloads=10 
deltarpm=true" | sudo tee -a /etc/dnf/dnf.conf

# Install RPM Fusion
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate -y core

# Update files
sudo dnf -y update
sudo dnf -y upgrade --refresh
sudo dnf groupupdate -y core

# Media Codecs
sudo dnf groupupdate -y 'core' 'multimedia' 'sound-and-video' --setopt='install_weak_deps=False' --exclude='PackageKit-gstreamer-plugin' --allowerasing && sync
sudo dnf swap -y 'ffmpeg-free' 'ffmpeg' --allowerasing
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
sudo dnf install -y lame\* --exclude=lame-devel
sudo dnf group upgrade -y --with-optional Multimedia
sudo dnf install -y ffmpeg ffmpeg-libs libva libva-utils
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264

# Flatpak Update
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak update

# Importing Keys
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Adding Repos
printf "[vscode]\nname=packages.microsoft.com\nbaseurl=https://packages.microsoft.com/yumrepos/vscode/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscode.repo
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf copr enable -y observeroftime/betterdiscordctl

# Enable packages
sudo dnf config-manager --enable google-chrome

# Apps
sudo dnf install -y unzip p7zip p7zip-plugins unrar fish vim gnome-tweaks clementine youtube-dl audacity meld htop btop tilix docker docker-compose steam lutris git discord google-chrome-stable code microsoft-edge-stable sublime-text brave-browser lpf-spotify-client betterdiscordctl

# Install Oh-My-Fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
chsh -s /usr/bin/fish

# Configs
sudo usermod -aG docker $USER && sudo systemctl enable docker
