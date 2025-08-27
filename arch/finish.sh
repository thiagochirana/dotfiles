#!/usr/bin/env bash
set -euo pipefail

echo ">>> Configurando Hyprland e sistema..."

# Configuração Hyprland (exemplo teclado)
HYPRCONF="$HOME/.config/hypr/hyprland.conf"
mkdir -p "$(dirname "$HYPRCONF")"

conf="/etc/vconsole.conf"
layout=$(grep '^XKBLAYOUT=' "$conf" | cut -d= -f2 | tr -d '"')
variant=$(grep '^XKBVARIANT=' "$conf" | cut -d= -f2 | tr -d '"')

if [[ -n "$layout" ]]; then
    echo "kb_layout = $layout" >> "$HYPRCONF"
fi
if [[ -n "$variant" ]]; then
    echo "kb_variant = $variant" >> "$HYPRCONF"
fi
