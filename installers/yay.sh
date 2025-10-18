#!/bin/bash
set -euo pipefail

echo "🔍 Verificando instalação do yay..."

if ! command -v yay >/dev/null 2>&1; then
  echo "📦 yay não encontrado. Instalando..."
  tmpdir=$(mktemp -d)
  cd "$tmpdir"
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ~
  rm -rf "$tmpdir"
  echo "✅ yay instalado com sucesso!"
else
  echo "✅ yay já está instalado. Pulando instalação."
fi
