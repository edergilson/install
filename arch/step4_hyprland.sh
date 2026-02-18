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
sudo pacman -S --needed --noconfirm base-devel git

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git ~/Git/yay && cd ~/Git/yay && makepkg -si --noconfirm && cd ~ rm -rf ~/Git/yay
fi

# 2. Tipografia (Fontes solicitadas)
echo ":: Instalando fontes (Inter, Hack, Hack Nerd Font)..."
sudo pacman -S --noconfirm inter-font ttf-hack ttf-hack-nerd ttf-jetbrains-mono-nerd noto-fonts-emoji

# 3. Codecs de Áudio, Vídeo e Suporte a Mídia
echo ":: Instalando principais codecs e bibliotecas de mídia..."
sudo pacman -S --noconfirm alsa-utils pulseaudio-alsa gst-plugins-good gst-plugins-bad gst-plugins-ugly exfat-utils fuse-exfat a52dec faac faad2 flac jasper lame libdca libdv gst-libav libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore libdvdcss libdvdread libdvdnav dvd+rw-tools dvdauthor dvgrab cups libde265 libva-intel-driver ffmpeg

# 4. Navegadores e Comunicação
echo ":: Instalando navegadores e ferramentas de comunicação..."
sudo pacman -S --noconfirm firefox vivaldi vivaldi-ffmpeg-codecs meld
yay -S --noconfirm brave-bin teams-for-linux-bin spotify

# 5. Desenvolvimento e Banco de Dados
echo ":: Instalando ferramentas de desenvolvimento..."
yay -S --noconfirm vscodium-bin sublime-text-4 insomnia-bin dbgate-bin genymotion

# 6. Virtualização e Containers
echo ":: Configurando Docker e VirtualBox..."
sudo pacman -S --noconfirm docker docker-compose docker-buildx virtualbox virtualbox-host-modules-arch
sudo usermod -aG docker $USER && sudo usermod -aG vboxusers $USER && sudo systemctl enable --now docker.service && sudo systemctl enable --now bluetooth

# 7. Games e Torrent
echo ":: Instalando Steam, Lutris e Gerenciador de Torrent..."
sudo pacman -S --noconfirm steam lutris qbittorrent

# 8. Utilitários do Sistema (Thunar, PDF, Calculadora, etc)
echo ":: Instalando utilitários do sistema..."
sudo pacman -S --noconfirm thunar thunar-archive-plugin thunar-volman tumbler file-roller kcalc zathura zathura-pdf-mupdf mpv amberol gvfs gvfs-mtp gvfs-smb fish vlc audacity meld htop btop steam p7zip unrar tar rsync ntfs-3g
yy -S --noconfirm neofetch-git gargoyle-git wine-staging lutris pfetch-git

sudo pacman -S --noconfirm papirus-icon-theme nwg-look qt5ct qt6ct

# 10. Variáveis de Ambiente e Fixes
echo ":: Ajustando ~/.bash_profile..."
{
    echo 'export QT_QPA_PLATFORMTHEME=qt5ct'
    echo 'export XDG_CURRENT_DESKTOP=Hyprland'
    echo 'export MOZ_ENABLE_WAYLAND=1'
} >> ~/.bash_profile

mkdir -p ~/.config/waybar

# 1. Criando o arquivo de configuração (Layout)
cat <<EOF > ~/.config/waybar/config
{
    "layer": "top",
    "position": "top",
    "mod": "dock",
    "exclusive": true,
    "passthrough": false,
    "gtk-layer-shell": true,
    "height": 40,
    "modules-left": ["hyprland/workspaces", "hyprland/window"],
    "modules-center": ["clock"],
    "modules-right": ["network", "cpu", "memory", "battery", "pulseaudio", "tray"],

    "hyprland/workspaces": {
        "format": "{icon}",
        "on-click": "activate"
    },

    "clock": {
        "format": " {:%H:%M   %d/%m/%y}",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
    },

    "battery": {
        "states": {
            "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": " {capacity}%",
        "format-plugged": " {capacity}%",
        "format-icons": ["", "", "", "", ""]
    },

    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": "",
        "format-icons": {
            "default": ["", "", ""]
        },
        "on-click": "pamixer -t"
    },

    "network": {
        "format-wifi": " {essid}",
        "format-ethernet": " {ifname}",
        "format-disconnected": "⚠ Disconnected"
    },

    "cpu": {
        "interval": 10,
        "format": " {usage}%"
    },

    "memory": {
        "interval": 30,
        "format": " {}%"
    }
}
EOF

# 2. Criando o arquivo de estilo (Visual)
cat <<EOF > ~/.config/waybar/style.css
* {
    border: none;
    border-radius: 0;
    font-family: "Hack Nerd Font", Inter, sans-serif;
    font-size: 14px;
    min-height: 0;
}

window#waybar {
    background: rgba(21, 18, 27, 0.8);
    color: #cdd6f4;
    transition-property: background-color;
    transition-duration: .5s;
    border-bottom: 2px solid rgba(255, 255, 255, 0.1);
}

#workspaces button {
    padding: 0 5px;
    color: #a6adc8;
}

#workspaces button.active {
    color: #89b4fa;
    border-bottom: 3px solid #89b4fa;
}

#clock, #battery, #cpu, #memory, #network, #pulseaudio, #tray {
    padding: 0 10px;
    margin: 4px 0;
    border-left: 1px solid rgba(255, 255, 255, 0.2);
}

#battery.critical:not(.charging) {
    background-color: #f38ba8;
    color: #11111b;
}
EOF

#!/bin/bash

# Script de configuração do Hyprpaper (Dual Monitor)
# Autor: Gemini AI

mkdir -p ~/.config/hypr

# 1. Definindo o caminho do wallpaper
# Você pode trocar este link por qualquer imagem local depois
WP_PATH="$HOME/.config/hypr/wallpaper.jpg"

echo ":: Baixando um wallpaper minimalista de exemplo..."
curl -L "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=2560&auto=format&fit=crop" -o "$WP_PATH"

# 2. Gerando o arquivo hyprpaper.conf
cat <<EOF > ~/.config/hypr/hyprpaper.conf
# Pré-carrega a imagem na memória (essencial para performance)
preload = $WP_PATH

# Define o wallpaper para o monitor UltraWide (LG)
wallpaper = DP-1,$WP_PATH

# Define o mesmo wallpaper para o monitor do Laptop (Dell)
wallpaper = eDP-1,$WP_PATH

# Desabilita o splash de texto no fundo (opcional)
splash = false
EOF

# 3. Garantindo que o hyprpaper inicie com o sistema
# Vamos verificar se o comando já existe no seu hyprland.conf
if ! grep -q "exec-once = hyprpaper" ~/.config/hypr/hyprland.conf; then
    echo ":: Adicionando hyprpaper ao auto-start do Hyprland..."
    echo "exec-once = hyprpaper" >> ~/.config/hypr/hyprland.conf
fi

# Reinicia o hyprpaper se ele já estiver rodando para aplicar as mudanças
killall hyprpaper || true
hyprpaper &

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
