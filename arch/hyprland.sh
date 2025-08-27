#!/usr/bin/env bash
set -euo pipefail

echo ">>> Instalando Hyprland e utilitários..."
yay -S --noconfirm --needed \
    hyprland hyprshot hyprpicker hyprlock hypridle hyprsunset hyprland-qtutils \
    waybar mako swaybg swayosd \
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
