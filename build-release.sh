#!/bin/bash

# Script de création d'une release du plugin ShareToAI
# Usage: ./build-release.sh [version]

set -e

# Couleurs
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

VERSION=${1:-1.0.0}
PLUGIN_NAME="sharetoai"
BUILD_DIR="build"
RELEASE_DIR="$BUILD_DIR/$PLUGIN_NAME"
ZIP_NAME="sharetoai-${VERSION}.zip"

echo -e "${BLUE}🚀 Création de la release ShareToAI v${VERSION}${NC}"

# Nettoyer le dossier de build
echo -e "${YELLOW}📦 Nettoyage du dossier de build...${NC}"
rm -rf "$BUILD_DIR"
mkdir -p "$RELEASE_DIR"

# Copier les fichiers nécessaires
echo -e "${YELLOW}📋 Copie des fichiers...${NC}"
cp sharetoai.php "$RELEASE_DIR/"
cp uninstall.php "$RELEASE_DIR/"
cp readme.txt "$RELEASE_DIR/"
cp README.md "$RELEASE_DIR/"
cp CHANGELOG.md "$RELEASE_DIR/"
cp -r assets "$RELEASE_DIR/"
cp -r includes "$RELEASE_DIR/"

# Créer le ZIP
echo -e "${YELLOW}🗜️  Création du fichier ZIP...${NC}"
cd "$BUILD_DIR"
zip -r "../$ZIP_NAME" "$PLUGIN_NAME" -x "*.DS_Store" "*.git*"
cd ..

# Nettoyer
rm -rf "$BUILD_DIR"

# Résumé
echo ""
echo -e "${GREEN}✅ Release créée avec succès !${NC}"
echo -e "${GREEN}📦 Fichier : ${ZIP_NAME}${NC}"
echo -e "${GREEN}📊 Taille : $(du -h "$ZIP_NAME" | cut -f1)${NC}"
echo ""
echo -e "${BLUE}Prochaines étapes :${NC}"
echo "1. Tester l'installation du ZIP sur un site WordPress"
echo "2. Créer une release sur GitHub"
echo "3. Uploader le fichier $ZIP_NAME"
echo ""
echo -e "${YELLOW}Commande GitHub Release :${NC}"
echo "gh release create v${VERSION} ${ZIP_NAME} --title \"ShareToAI v${VERSION}\" --notes \"Voir CHANGELOG.md\""
