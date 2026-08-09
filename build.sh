#!/usr/bin/env bash
set -e

IMAGE_NAME="dokos-env"

echo "🛠️  [1/2] Construction de l'image Docker (${IMAGE_NAME})..."
docker build --platform=linux/amd64 -t ${IMAGE_NAME} .

echo "⚙️  [2/2] Compilation du noyau dokOS..."
docker run --rm --platform=linux/amd64 -v "$(pwd)":/workspace ${IMAGE_NAME} make

echo ""
echo "✅ Compilation terminée avec succès !"
echo "👉 Pour lancer l'OS, exécute : ./run.sh"
