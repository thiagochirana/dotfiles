#!/bin/bash
set -euo pipefail

# ==== CONFIGURAÇÃO INICIAL ====

# Garante que sudo não peça senha várias vezes
sudo -v
# Mantém a sessão sudo viva enquanto o script roda
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ==== CHECAR CONEXÃO ====
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

# ==== PACMAN CONFIG ====
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel libyaml git curl postgresql postgis eza bat zsh uwsm fftw alsa-lib iniparser pkgconf gtklock makoctl
sudo pacman -S --needed --noconfirm swayosd swayosd-libinput-backend hyprpicker

# ==== INSTALAR YAY ====
tmpdir=$(mktemp -d)
cd "$tmpdir"232123
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~
rm -rf "$tmpdir"

# ==== UTILITÁRIOS ====
sudo pacman -S --needed --noconfirm alacritty mpv ghostty
sudo pacman -S --needed --noconfirm impala btop fastfetch vim neovim cava
sudo pacman -S --needed --noconfirm chromium steam
yay -S --noconfirm google-chrome windsurf walker-bin heroku-cli

# ==== WAYBAR ====
sudo pacman -S --needed --noconfirm \
  gtkmm3 jsoncpp libsigc++ fmt wayland chrono-date spdlog gtk3 \
  gobject-introspection libgirepository libpulse libnl libappindicator-gtk3 \
  libdbusmenu-gtk3 libmpdclient sndio libevdev libxkbcommon upower meson \
  cmake scdoc wayland-protocols glib2-devel


if ! command -v waybar >/dev/null 2>&1; then
  echo "📦 Instalando Waybar a partir do código-fonte..."
  tmpdir=$(mktemp -d)
  cd "$tmpdir"
  git clone https://github.com/Alexays/Waybar
  cd Waybar
  meson setup build
  ninja -C build
  sudo ninja -C build install
  cd ~
  rm -rf "$tmpdir"
else
  echo "🟢 Waybar já está instalado ($(waybar -v)), pulando compilação..."
fi

echo
echo "✅ Instalação concluída com sucesso!"
