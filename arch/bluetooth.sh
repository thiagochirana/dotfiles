#!/usr/bin/env bash
set -euo pipefail

echo ">>> Instalando e habilitando Bluetooth..."
yay -S --noconfirm --needed blueberry
sudo systemctl enable --now bluetooth.service
