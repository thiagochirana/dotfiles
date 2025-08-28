#!/usr/bin/env bash
set -euo pipefail

echo ">>> Instalando ferramentas de desenvolvimento..."

# Ferramentas básicas de desenvolvimento (usando pacman para maior estabilidade)
sudo pacman -S --needed --noconfirm \
    base-devel git clang llvm wget curl unzip inetutils \
    jq xmlstarlet docker docker-compose docker-buildx

# Ferramentas de linha de comando (via yay)
yay -S --noconfirm --needed \
    fd fzf ripgrep zoxide bat \
    lazygit lazydocker-bin github-cli heroku-cli

# Docker
if ! systemctl is-active --quiet docker; then
    echo "Iniciando e habilitando o Docker..."
    sudo systemctl enable --now docker
    sudo usermod -aG docker "$USER"
fi

# Mise (gerenciador de ambientes Ruby/Node/Outros)
if ! command -v mise &> /dev/null; then
    echo "Instalando Mise..."
    yay -S --noconfirm --needed mise
    # Adiciona configuração ao zshrc se não existir
    if [ -f "$HOME/.zshrc" ] && ! grep -q "mise init" "$HOME/.zshrc"; then
        echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
    fi
fi

# Banco de Dados
if ! systemctl is-active --quiet postgresql; then
    echo "Instalando e configurando PostgreSQL..."
    yay -S --noconfirm --needed postgresql postgis
    sudo systemctl enable --now postgresql

    # Inicializa o banco de dados se não existir
    if [ ! -d "/var/lib/postgres/data" ]; then
        echo "Inicializando o banco de dados PostgreSQL..."
        sudo -u postgres initdb -D /var/lib/postgres/data
        sudo systemctl restart postgresql
    fi
fi

# Valkey (Redis moderno)
if ! command -v valkey-server &> /dev/null; then
    echo "Instalando Valkey..."
    yay -S --noconfirm --needed valkey-bin
    sudo systemctl enable --now valkey
fi

echo "Ferramentas de desenvolvimento instaladas e configuradas!"
