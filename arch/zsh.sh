#!/usr/bin/env bash
set -euo pipefail

echo ">>> Instalando Zsh e utilitários..."

# Instalar zsh via pacman (mais estável que via yay)
sudo pacman -S --noconfirm --needed zsh

# Instalar plugins e temas via yay
yay -S --noconfirm --needed \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    fast-syntax-highlighting \
    zsh-autocomplete

# Definir zsh como shell padrão, se ainda não estiver definido
if [[ "$SHELL" != "$(which zsh)" ]]; then
    echo "Definindo zsh como shell padrão..."
    chsh -s "$(which zsh)" "$USER"
fi

# Copiar configuração do zsh
echo "Configurando .zshrc..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CONFIG_SRC="$SCRIPT_DIR/zsh/.zshrc"
ZSH_CONFIG_DEST="$HOME/.zshrc"

if [ -f "$ZSH_CONFIG_SRC" ]; then
    rm -f "$ZSH_CONFIG_DEST"
    cp "$ZSH_CONFIG_SRC" "$ZSH_CONFIG_DEST"
    chmod 644 "$ZSH_CONFIG_DEST"
    echo "Arquivo .zshrc configurado com sucesso!"
else
    echo "Atenção: Arquivo de configuração do zsh não encontrado em $ZSH_CONFIG_SRC"
fi

# Instalar Oh My Zsh se não estiver instalado
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Instalando Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi