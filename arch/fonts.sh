#!/usr/bin/env bash
set -euo pipefail

echo ">>> Instalando fontes..."

yay -S --noconfirm --needed \
    ttf-font-awesome ttf-cascadia-mono-nerd ttf-ia-writer \
    noto-fonts noto-fonts-emoji noto-fonts-cjk noto-fonts-extra ttf-jetbrains-mono

sudo fc-cache -fv