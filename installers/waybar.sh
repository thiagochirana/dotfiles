#!/bin/bash

sudo pacman -S --needed --noconfirm \
  gtkmm3 jsoncpp libsigc++ fmt wayland chrono-date spdlog gtk3 \
  gobject-introspection libgirepository libpulse libnl libappindicator-gtk3 \
  libdbusmenu-gtk3 libmpdclient sndio libevdev libxkbcommon upower meson \
  cmake scdoc wayland-protocols glib2-devel cava

if ! command -v waybar >/dev/null 2>&1; then
  echo "📦 Installing Waybar from source..."
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
  echo "🟢 Waybar already installed ($(waybar -v)), skipping compilation..."
fi