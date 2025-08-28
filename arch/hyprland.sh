#!/usr/bin/env bash
set -euo pipefail

# Verificar se estamos em um ambiente Wayland
if [ "$XDG_SESSION_TYPE" != "wayland" ]; then
    echo "ERRO: Este script deve ser executado em uma sessão Wayland!"
    exit 1
fi

echo ">>> Instalando Hyprland e utilitários..."

# Dependências básicas do Hyprland
sudo pacman -S --needed --noconfirm \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    xdg-utils \
    xwayland \
    qt5-wayland \
    qt6-wayland \
    glfw-wayland \
    wl-clipboard \
    wf-recorder \
    slurp \
    grim \
    wl-clip-persist-git \
    wlrobs-hg \
    wlroots \
    waybar-hyprland \
    mako \
    swaybg \
    swayidle \
    swaylock \
    wlogout \
    wofi \
    wtype \
    wl-clipboard \
    wf-recorder \
    grim \
    slurp \
    jq \
    socat \
    libnotify \
    brightnessctl \
    bluez \
    bluez-utils \
    blueman

# Instalar Hyprland e utilitários via yay
yay -S --noconfirm --needed \
    hyprland \
    hyprshot \
    hyprpicker \
    hyprlock \
    hypridle \
    hyprland-qtutils \
    waybar-hyprland \
    swayosd \
    wofi \
    wlogout \
    swaybg \
    swayidle \
    swaylock \
    wl-clipboard \
    wf-recorder \
    grim \
    slurp \
    jq \
    socat \
    libnotify \
    brightnessctl \
    bluez \
    bluez-utils \
    blueman

# Configuração básica do Hyprland
HYPRLAND_CONFIG_DIR="$HOME/.config/hypr"
mkdir -p "$HYPRLAND_CONFIG_DIR"

# Configuração básica do Hyprland
if [ ! -f "$HYPRLAND_CONFIG_DIR/hyprland.conf" ]; then
    echo "Criando configuração básica do Hyprland..."
    cat > "$HYPRLAND_CONFIG_DIR/hyprland.conf" << EOL
# Configuração básica do Hyprland
# Consulte https://wiki.hyprland.org/Configuring/ para mais opções

# Variáveis de ambiente
env = XDG_CURRENT_DESKTOP,Hyprland
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland

# Configuração do teclado
input {
    kb_layout = br
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =
    repeat_rate = 25
    repeat_delay = 600
    numlock_by_default = true
    follow_mouse = 1
}

# Configuração geral
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
}

decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
    }
    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_is_master = true
}

gestures {
    workspace_swipe = true
}

device {
    name = epic-mouse-v1
    sensitivity = -0.5
}

# Configuração do monitor
# Exemplo para um monitor 1920x1080 @ 144Hz:
# monitor=,preferred,auto,1

# Configuração do workspace
workspace = 1, monitor:HDMI-A-1
workspace = 2, monitor:HDMI-A-1
workspace = 3, monitor:HDMI-A-1
workspace = 4, monitor:HDMI-A-1
workspace = 5, monitor:HDMI-A-1
workspace = 6, monitor:HDMI-A-1
workspace = 7, monitor:HDMI-A-1
workspace = 8, monitor:HDMI-A-1
workspace = 9, monitor:HDMI-A-1
workspace = 10, monitor:HDMI-A-1

# Configuração de atalhos de teclado
$mainMod = SUPER

# Aplicativos
bind = $mainMod, RETURN, exec, alacritty
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, nautilus
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, wofi --show drun
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

# Controle de áudio
bind =, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bind =, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind =, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+

# Brilho
bind =, XF86MonBrightnessDown, exec, brightnessctl set 5%-
bind =, XF86MonBrightnessUp, exec, brightnessctl set 5%+

# Captura de tela
bind =, Print, exec, grim -g "$(slurp)" ~/Pictures/Screenshots/$(date +'%Y-%m-%d-At-%Hh-%Mm-%Ss.png')
bind = $mainMod, Print, exec, grim ~/Pictures/Screenshots/$(date +'%Y-%m-%d-At-%Hh-%Mm-%Ss.png')

# Bloqueio de tela
bind = $mainMod, L, exec, swaylock -f -c 000000

# Recarregar Hyprland
bind = $mainMod SHIFT, C, exec, killall -SIGUSR2 hyprland

# Desligar, reiniciar, sair
bind = $mainMod, X, exec, wlogout

# Workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Mover janela para workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Alternar entre workspaces
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Mover janela para o workspace anterior/próximo
bind = $mainMod CTRL, left, workspace, -1
bind = $mainMod CTRL, right, workspace, +1

# Mover janela para o workspace anterior/próximo com o mouse
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Executar na inicialização
exec-once = waybar
exec-once = mako
exec-once = nm-applet --indicator
exec-once = blueman-applet
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = swaybg -i ~/Pictures/wallpaper.jpg
EOL
fi

echo "Instalação do Hyprland concluída!"
echo "Reinicie a sessão para aplicar as alterações."
