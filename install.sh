#!/bin/bash
set -euo pipefail
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
BIN_DIR="$HOME/.local/bin"

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "🔍 Verificando conexão com a internet..."
if ping -q -c 1 -W 2 google.com >/dev/null 2>&1; then
  echo "🌐 Conexão detectada. Pulando configuração de Wi-Fi."
else
  echo "📶 Nenhuma conexão detectada. Configurando Wi-Fi..."
  read -rp "Nome do Wi-Fi: " WIFI
  read -rsp "Senha do Wi-Fi: " PASS
  echo

  sudo rfkill unblock all
  sudo rfkill unblock bluetooth
  sudo rfkill list bluetooth
  sudo rfkill unblock wifi
  sudo rfkill list wifi

  iwctl device list
  iwctl device wlan0 set-property Powered on
  iwctl station wlan0 scan
  iwctl station wlan0 get-networks
  iwctl --passphrase "$PASS" station wlan0 connect "$WIFI"
fi

./installers/pacman.sh
./installers/fonts.sh
./installers/hyprland.sh
./installers/yay.sh
./installers/dev.sh
./installers/utilities.sh
./installers/waybar.sh
./dotfiles.sh

hyprctl reload

echo
echo "✅ Installation completed successfully!"
