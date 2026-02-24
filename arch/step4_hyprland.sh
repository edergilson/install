#!/bin/bash

# Script Consolidado de Instalação: Produtividade, Dev, Entretenimento e Fontes
# Hardware: Dell Latitude 3420 (Intel i7 11th Gen)
# Autor: Gemini AI

set -e

echo "-------------------------------------------------------"
echo "Iniciando instalação completa de software e tipografia"
echo "-------------------------------------------------------"

# 1. Preparação e AUR Helper (Yay)
echo ":: Preparando dependências e Yay..."
sudo pacman -S --needed --noconfirm base-devel git wget

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git ~/Git/yay && cd ~/Git/yay && makepkg -si --noconfirm && cd ~ && rm -rf ~/Git/yay
fi

# 2. Tipografia (Fontes solicitadas)
echo ":: Instalando fontes (Inter, Hack, Hack Nerd Font)..."
sudo pacman -S --noconfirm inter-font ttf-hack ttf-hack-nerd ttf-jetbrains-mono-nerd noto-fonts-emoji

# 3. Codecs de Áudio, Vídeo e Suporte a Mídia
echo ":: Instalando principais codecs e bibliotecas de mídia..."
sudo pacman -S --noconfirm alsa-utils alsa-ucm-conf pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber sof-firmware gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav ffmpeg libva-intel-driver pavucontrol

# 4. Navegadores e Comunicação
echo ":: Instalando navegadores e ferramentas de comunicação..."
sudo pacman -S --noconfirm firefox vivaldi vivaldi-ffmpeg-codecs meld kompare
yay -S --noconfirm brave-bin teams-for-linux-bin spotify

# 5. Desenvolvimento e Banco de Dados
echo ":: Instalando ferramentas de desenvolvimento..."
yay -S --noconfirm vscodium-bin sublime-text-4 insomnia-bin dbgate-bin genymotion kate

# 6. Virtualização e Containers
echo ":: Configurando Docker e VirtualBox..."
sudo pacman -S --noconfirm docker docker-compose docker-buildx virtualbox virtualbox-host-modules-arch
sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo systemctl enable --now docker.service && sudo systemctl enable --now bluetooth

# 7. Games e Torrent
echo ":: Instalando Steam, Lutris e Gerenciador de Torrent..."
sudo pacman -S --noconfirm steam lutris qbittorrent

# 8. Utilitários do Sistema (Thunar, PDF, Calculadora, etc)
echo ":: Instalando utilitários do sistema..."
sudo pacman -S --noconfirm dolphin dolphin-plugins ark okular elisa haruna kcalc kcolorchooser gwenview kio kio-extras kio-gdrive kio-admin kdegraphics-thumbnailers ffmpegthumbnailer mpv fish vlc audacity htop btop steam p7zip unrar tar rsync ntfs-3g kdialog
yay -S --noconfirm neofetch-git gargoyle-git wine-staging lutris pfetch-git

sudo pacman -S --noconfirm xdg-desktop-portal-hyprland xdg-desktop-portal-kde xdg-desktop-portal-gtk kde-gtk-config papirus-icon-theme nwg-look qt5ct qt6ct breeze-icons breeze-gtk

# 9. Noctalia Shell
echo ":: Instalando o Noctalia Shell ..."
yay -S --noconfirm noctalia-shell cliphist cava wlsunset ddcutil

# 10. Variáveis de Ambiente e Fixes
# Criando a regra de portal que discutimos para não quebrar o Teams
mkdir -p ~/.config/xdg-desktop-portal
cat <<EOF > ~/.config/xdg-desktop-portal/hyprland-portals.conf
[preferred]
default=kde
org.freedesktop.impl.portal.ScreenCast=hyprland
org.freedesktop.impl.portal.Screenshot=hyprland
EOF

# 10. Variáveis de Ambiente e Fixes de Interface
echo ":: Ajustando variáveis de ambiente para Qt..."
{
    echo 'export QT_QPA_PLATFORMTHEME=qt5ct'
    echo 'export XDG_CURRENT_DESKTOP=Hyprland'
    echo 'export MOZ_ENABLE_WAYLAND=1'
    echo 'export XDG_MENU_PREFIX=plasma-'
} >> ~/.bash_profile

echo "-------------------------------------------------------"
echo "Instalação finalizada!"
echo "-------------------------------------------------------"
echo "SUGESTÃO DE USO DE FONTES:"
echo "- Interface (nwg-look): Inter"
echo "- Terminal/Editor: Hack Nerd Font"
echo "-------------------------------------------------------"
echo "Configuração da Waybar gerada com sucesso!"
echo "Pressione SUPER+C para recarregar o Hyprland ou digite 'killall waybar && waybar &'"
echo "-------------------------------------------------------"
echo "Configuração do Hyprpaper concluída!"
echo "Wallpaper salvo em: $WP_PATH"
echo "-------------------------------------------------------"
