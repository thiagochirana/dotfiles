#!/usr/bin/env bash
set -euo pipefail

echo ">>> Instalando ferramentas de desenvolvimento..."

# Ferramentas básicas e utilitários
yay -S --noconfirm --needed \
    base-devel git cargo clang llvm wget curl unzip inetutils fd fzf ripgrep zoxide bat jq xmlstarlet \
    lazygit lazydocker-bin github-cli

# Docker
yay -S --noconfirm --needed docker docker-compose docker-buildx
sudo systemctl enable --now docker
sudo usermod -aG docker ${USER}

# Mise (gerenciador de ambientes Ruby/Node/Outros)
yay -S --noconfirm --needed mise
# Adiciona configuração ao zshrc
if ! grep -q "mise init" "$HOME/.zshrc"; then
    echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
fi

# PostgreSQL + PostGIS
yay -S --noconfirm --needed postgresql postgis
sudo systemctl enable --now postgresql

# Valkey (exemplo: instalação de valkey-bin do AUR)
yay -S --noconfirm --needed valkey-bin

echo ">>> Ferramentas de desenvolvimento instaladas e configuradas!"
