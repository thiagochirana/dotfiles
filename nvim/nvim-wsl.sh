#!/bin/bash

# Get absolute path of current directory
DIR_LOCAL=$(pwd)

# Name of the package and its config file
DIR_CONFIG="nvim-wsl"
PACKAGE="nvim"

SOURCE="${DIR_LOCAL}/${DIR_CONFIG}"
TARGET="$HOME/.config/${PACKAGE}"

rm $TARGET
echo "Deletado toda a configuracao anterior (se houvesse)..."
       
# Create symlink
if ln -s "$SOURCE" "$TARGET"; then
    echo "Link criado de $SOURCE para $TARGET"
else
    echo "Erro: Falha ao tentar criar um symlink para o ${PACKAGE}"
    exit 1
fi
