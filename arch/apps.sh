#!/usr/bin/env bash
set -euo pipefail

echo ">>> Instalando aplicativos de usuário..."

yay -S --noconfirm --needed \
    chromium google-chrome-stable mpv evince imv \
    nautilus sushi ffmpegthumbnailer gvfs-mtp \
    slurp satty alacritty \
    brightnessctl playerctl pamixer wiremix wireplumber \
    fcitx5 fcitx5-gtk fcitx5-qt wl-clip-persist