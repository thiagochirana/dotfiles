#!/bin/bash
set -euo pipefail

# ==== CONFIGURAÇÃO INICIAL ====

# Garante que sudo não peça senha várias vezes
sudo -v
# Mantém a sessão sudo viva enquanto o script roda
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Pergunta Wi-Fi e senha
read -rp "Nome do Wi-Fi: " WIFI
read -rsp "Senha do Wi-Fi: " PASS
echo

# ==== CONECTAR AO WI-FI ====
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

# ==== PACMAN CONFIG ====
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm base-devel libyaml git curl postgresql postgis eza bat zsh uwsm fftw alsa-lib iniparser pulseaudio pkgconf gtklock

# ==== INSTALAR YAY ====
tmpdir=$(mktemp -d)
cd "$tmpdir"
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

cd /tmp
git clone https://github.com/Alexays/Waybar
cd Waybar
meson setup build
ninja -C build
sudo ninja -C build install
cd ~
rm -rf /tmp/Waybar

echo
echo "✅ Instalação concluída com sucesso!"
