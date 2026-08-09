#!/usr/bin/env bash
set -e

IMAGE_NAME="dokos-env"

# Vérifie si le noyau a été compilé
if [ ! -f "kernel.elf" ]; then
    echo "⚠️  Le noyau (kernel.elf) n'a pas été trouvé."
    echo "🚀 Lancement de la compilation..."
    ./build.sh
fi

echo "🖥️  Lancement de dokOS dans QEMU via Docker..."
echo "ℹ️  (Pour quitter QEMU : presse 'Ctrl + A' puis 'X')"
echo "---------------------------------------------------"

docker run --rm -it --platform=linux/amd64 -v "$(pwd)":/workspace ${IMAGE_NAME} make qemu
