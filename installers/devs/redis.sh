#!/bin/bash
set -euo pipefail

echo "🧩 Checking Redis (Valkey) installation..."

# Verifica se o binário do Valkey existe
if ! command -v valkey-server >/dev/null 2>&1; then
  echo "📦 Installing Valkey..."
  sudo pacman -S --needed --noconfirm valkey
else
  echo "✅ Valkey (Redis) already installed."
fi

# Habilita e inicia o serviço correto
echo "🚀 Enabling and starting the Valkey service..."
sudo systemctl enable valkey.service
sudo systemctl start valkey.service

# Testa se está respondendo
if valkey-cli ping | grep -q PONG; then
  echo "✅ Redis (Valkey) is active and responding!"
else
  echo "⚠️ Redis (Valkey) service started, but did not respond to ping."
fi
