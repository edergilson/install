#!/bin/bash

# Script de instalação Hyprland para Dell Latitude 3420 + LG 29UM69G
# Display Manager: SDDM
# Autor: Gemini AI

set -e 

echo "-------------------------------------------------------"
echo "Iniciando instalação completa: Drivers + Hyprland + SDDM"
echo "-------------------------------------------------------"

# 1. Atualização do Sistema
sudo pacman -Syu --noconfirm

# 2. Drivers de Vídeo (Otimizado para Intel Iris Xe)
sudo pacman -S --noconfirm mesa lib32-mesa vulkan-intel lib32-vulkan-intel \
intel-media-driver libva-intel-driver

# 3. Base do Hyprland e Ferramentas do Sistema
sudo pacman -S --noconfirm hyprland kitty xdg-desktop-portal-hyprland \
polkit-kde-agent qt5-wayland qt6-wayland pipewire wireplumber

# 4. Instalação e Configuração do SDDM (Display Manager)
echo ":: Instalando SDDM..."
sudo pacman -S --noconfirm sddm qt6-5compat qt6-declarative qt6-svg
sudo systemctl enable sddm

# 5. Interface e Utilidades
sudo pacman -S --noconfirm waybar wofi hyprpaper dunst brightnessctl pamixer libnotify

# 6. Gerenciamento de Energia
sudo pacman -S --noconfirm power-profiles-daemon
sudo systemctl enable --now power-profiles-daemon

# 7. Criação dos diretórios de configuração
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar

# 8. Gerando o arquivo hyprland.conf
echo ":: Gerando arquivo de configuração hyprland.conf..."
cat <<EOF > ~/.config/hypr/hyprland.conf
# CONFIGURAÇÃO HYPRLAND - DELL LATITUDE + LG 29UM69G

# --- Monitores ---
monitor=DP-1, 2560x1080@74.99, 0x0, 1
monitor=eDP-1, 1920x1080@60, 320x1080, 1

# --- Auto-execução ---
exec-once = waybar
exec-once = hyprpaper
exec-once = dunst
exec-once = /usr/lib/polkit-kde-authentication-agent-1

# --- Input: Teclado e Trackpad ---
input {
    kb_layout = br
    kb_variant = abnt2
    
    touchpad {
        natural_scroll = true
        tap-to-click = true
        disable_while_typing = true
    }
}

gestures {
    workspace_swipe = true
}

# --- Estética ---
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
}

# --- Atalhos de Teclado ---
bind = SUPER, Q, exec, kitty
bind = SUPER, C, killactive, 
bind = SUPER, M, exit, 
bind = SUPER, R, exec, wofi --show drun

# Teclas de função do Dell Latitude
bindle = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
bindle = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
bindle = , XF86AudioRaiseVolume, exec, pamixer -i 5
bindle = , XF86AudioLowerVolume, exec, pamixer -d 5
bindle = , XF86AudioMute, exec, pamixer -t

# Mouse binds
bindm = SUPER, mouse:272, movewindow
bindm = SUPER, mouse:273, resizewindow
EOF

echo "-------------------------------------------------------"
echo "Instalação Concluída!"
echo "O SDDM iniciará automaticamente no próximo reboot."
echo "Basta selecionar 'Hyprland' no canto da tela de login."
echo "-------------------------------------------------------"
