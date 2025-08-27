#!/usr/bin/env bash
set -euo pipefail

# Caminho para a pasta arch
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)/arch"

# Lista de scripts na ordem de execução
SCRIPTS=(
    "system.sh"
    "drivers.sh"
    "hyprland.sh"
    "apps.sh"
    "bluetooth.sh"
    "fonts.sh"
    "dev.sh"
    "finish.sh"
)

# Executa cada script
for script in "${SCRIPTS[@]}"; do
    /bin/bash "$SCRIPT_DIR/$script"
done

echo ">>> Instalação completa! Reinicie o sistema."
