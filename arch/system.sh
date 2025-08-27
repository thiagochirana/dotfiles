#!/usr/bin/env bash
set -euo pipefail

echo ">>> Atualizando o sistema e habilitando multilib..."
sudo pacman -Syu --noconfirm

if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    sudo sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
    sudo pacman -Syu --noconfirm
fi

echo ">>> Instalando pacotes básicos..."
sudo pacman -S --needed --noconfirm \
    git curl zsh vim neovim fontconfig eza bat
