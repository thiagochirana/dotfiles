#!/bin/bash
set -euo pipefail
sudo -v

packages=(
  i3-wm
  i3status
  i3lock
  dmenu
  playerctl
  swayosd
  wlogout
  gtklock
  mako
)

echo "Installing i3wm and related utilities: ${packages[*]}"
sudo pacman -S --noconfirm --needed "${packages[@]}"
