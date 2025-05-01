#!/usr/bin/env bash

echo "[*] Finalizando portais antigos..."
killall -e xdg-desktop-portal-hyprland 2>/dev/null
killall xdg-desktop-portal 2>/dev/null

echo "[*] Iniciando xdg-desktop-portal-hyprland..."
/usr/lib/xdg-desktop-portal-hyprland & disown
sleep 2

echo "[*] Iniciando xdg-desktop-portal..."
/usr/lib/xdg-desktop-portal & disown

echo "[✓] Compartilhamento de tela ativado."

