#!/bin/bash

# Get absolute path of current directory
DIR_LOCAL=$(pwd)

# Name of the package and its config file
CONFIG_FILE="config.ini"
PACKAGE="polybar"

LAUNCH_FILE="launch.sh"

SOURCE="${DIR_LOCAL}/${CONFIG_FILE}"
SOURCE_LAUNCH="${DIR_LOCAL}/${LAUNCH_FILE}"
TARGET_PACKAGE_DIR="$HOME/.config/${PACKAGE}"

TARGET="${TARGET_PACKAGE_DIR}/${CONFIG_FILE}"
TARGET_LAUNCH="${TARGET_PACKAGE_DIR}/${LAUNCH_FILE}"

# Check if source exists
if [ ! -f "$SOURCE" ]; then
    echo "$SOURCE não existe! Abortando config para ${PACKAGE}"
    exit 1
fi

# Check if package dir exists
if [ ! -e "$TARGET_PACKAGE_DIR" ]; then
    echo "Atenção: $TARGET_PACKAGE_DIR não existe, vou criá-lo"
    mkdir -p "$TARGET_PACKAGE_DIR"
fi

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
    echo "Erro: Falha ao tentar criar um symlink para o ${PACKAGE}"
    exit 1
fi

# bonus : create a syml to launch file
if ln -s "$SOURCE_LAUNCH" "$TARGET_LAUNCH"; then
    echo "Link criado de $SOURCE_LAUNCH para $TARGET_LAUNCH"
else
    echo "Erro: Falha ao tentar criar um $LAUNCH_FILE para o ${PACKAGE}"
    exit 1
fi
