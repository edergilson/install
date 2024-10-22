# Update the system
sudo zypper ref && sudo zypper dup

# Add Packman Repo
sudo zypper addrepo -cfp 90 'https://mirror.karneval.cz/pub/linux/packman/suse/openSUSE_Tumbleweed/' packman
sudo zypper --gpg-auto-import-keys ref
sudo zypper dist-upgrade --from packman --allow-vendor-change

# Install required packages
sudo zypper install curl

# Install Flatpak
sudo zypper in flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Codecs
sudo zypper install --from packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec
sudo zypper ar -f http://opensuse-guide.org/repo/openSUSE_Tumbleweed/ dvd
sudo rpm --import http://opensuse-guide.org/repo/openSUSE_Tumbleweed/repodata/repomd.xml.key
sudo zypper in libdvdcss2

# Add new keys
sudo zypper ar https://packages.microsoft.com/yumrepos/edge microsoft-edge
sudo zypper ar https://packages.microsoft.com/yumrepos/vscode code
sudo zypper ar -f https://mega.nz/linux/repo/openSUSE_Tumbleweed/ megasync
sudo zypper ar https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo zypper addrepo -g -f https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
echo -e "[google-chrome] \nname=google-chrome \nenabled=1 \nautorefresh=1 \nbaseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64 \ntype=rpm-md \ngpgcheck=1 \ngpgkey=https://dl.google.com/linux/linux_signing_key.pub \nkeeppackages=0 \n"|sudo tee /etc/zypp/repos.d/google-chrome.repo
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo rpm --import https://mega.nz/linux/repo/openSUSE_Tumbleweed/repodata/repomd.xml.key
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub


# Install packages
sudo zypper in bzip2 cabextract lhasa lzip 7zip unrar unzip zip
sudo zypper in fish vim clementine youtube-dl meld htop btop docker docker-compose lutris git google-chrome-stable brave-browser sublime-text code audacity kodi gimp inkscape kdenlive krita discord steam microsoft-edge-stable megasync dolphin-megasync opi

# Post Install Activities
sudo usermod -aG docker $USER && sudo systemctl enable docker
curl -O https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl && sudo chmod +x betterdiscordctl && sudo mv betterdiscordctl /usr/local/bin
opi codecs
chsh -s /usr/bin/fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
