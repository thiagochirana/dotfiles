#!/usr/bin/env bash
set -euo pipefail

echo ">>> Instalando drivers e bibliotecas gráficas..."

KERNEL_HEADERS="linux-headers"

# Detect GPU
if lspci | grep -qi 'nvidia'; then
    echo ">>> GPU NVIDIA detectada"
    NVIDIA_DRIVER="nvidia-dkms"
    sudo pacman -S --needed --noconfirm $KERNEL_HEADERS $NVIDIA_DRIVER nvidia-utils lib32-nvidia-utils
else
    echo ">>> GPU AMD detectada ou integrada"
    sudo pacman -S --needed --noconfirm \
        $KERNEL_HEADERS mesa lib32-mesa \
        vulkan-radeon lib32-vulkan-radeon \
        libva-mesa-driver lib32-libva-mesa-driver \
        mesa-vdpau lib32-mesa-vdpau \
        egl-wayland qt5-wayland qt6-wayland
fi
