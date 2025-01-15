#!/bin/bash

# Get absolute path of current directory
DIR_LOCAL=$(pwd)

# Name of the package and its config file
CONFIG_FILE=".p10k.zsh"

SOURCE="${DIR_LOCAL}/${CONFIG_FILE}"
TARGET_PACKAGE_DIR="$HOME"
TARGET="${TARGET_PACKAGE_DIR}/${CONFIG_FILE}"

# Check if target already exists
if [ -e "$TARGET" ]; then
    echo "Atenção: $TARGET já existe!"
    read -p "Sobrescrever? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Cancelou!"
        exit 1
    fi
    mv "${TARGET} ${TARGET}_bkp"
    echo "Info: feito backup da configuração anterior"
fi

# Create symlink
if ln -s "$SOURCE" "$TARGET"; then
    echo "Link criado de $SOURCE para $TARGET"
else
    echo "Erro: Falha ao tentar criar um symlink para o ${TARGET}"
    exit 1
fi
