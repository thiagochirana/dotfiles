#!/usr/bin/env bash

echo "[*] Corrigindo dependências essenciais..."
sudo pacman -Syu --needed --noconfirm \
  xdg-desktop-portal \
  xdg-desktop-portal-hyprland \
  pipewire \
  pipewire-audio \
  pipewire-pulse \
  pipewire-alsa \
  pipewire-jack \
  wireplumber

echo "[*] Configurando portal padrão para Hyprland..."
sudo mkdir -p /etc/xdg/xdg-desktop-portal
echo -e "[preferred]\ndefault=xdg-desktop-portal-hyprland" | sudo tee /etc/xdg/xdg-desktop-portal/portals.conf > /dev/null

echo "[*] Removendo possíveis locks do PipeWire..."
rm -f /run/user/$(id -u)/pipewire-0.lock

echo "[*] Reiniciando serviços do usuário..."
systemctl --user daemon-reexec
systemctl --user restart pipewire wireplumber

echo "[*] Finalizando portais antigos..."
killall -e xdg-desktop-portal-hyprland 2>/dev/null
killall xdg-desktop-portal 2>/dev/null

echo "[*] Iniciando portais..."
/usr/lib/xdg-desktop-portal-hyprland & disown
sleep 2
/usr/lib/xdg-desktop-portal & disown

echo "[✓] Tudo pronto. Tente compartilhar a tela novamente."

