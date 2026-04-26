#!/bin/bash

# Script de déploiement WordPress.org pour Fscan - Post to AI (slug: expansai-post-to-ai)
# Respecte les règles de sécurité et versioning

set -e

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PLUGIN_SLUG="expansai-post-to-ai"
PLUGIN_VERSION="1.0.6"
SVN_URL="https://plugins.svn.wordpress.org/${PLUGIN_SLUG}"
SVN_USERNAME="fscan"
PLUGIN_DIR="$(pwd)"
SVN_DIR="${PLUGIN_DIR}/../${PLUGIN_SLUG}-svn"

echo -e "${GREEN}=== Déploiement WordPress.org ===${NC}"
echo "Plugin: ${PLUGIN_SLUG}"
echo "Version: ${PLUGIN_VERSION}"
echo ""

# Vérification que nous sommes dans le bon répertoire
if [ ! -f "expansai-post-to-ai.php" ]; then
    echo -e "${RED}Erreur: fichier principal du plugin non trouvé${NC}"
    echo "Assurez-vous d'exécuter ce script depuis le répertoire du plugin"
    exit 1
fi

# Vérification GIT
echo -e "${YELLOW}Vérification GIT...${NC}"
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${RED}Erreur: modifications non commitées détectées${NC}"
    echo "Veuillez commiter ou stasher vos modifications avant de déployer"
    git status
    exit 1
fi
echo -e "${GREEN}✓ GIT propre${NC}"

# Demande du mot de passe SVN
echo ""
echo -e "${YELLOW}Mot de passe SVN requis${NC}"
echo "Votre nom d'utilisateur SVN: ${SVN_USERNAME}"
read -sp "Entrez votre mot de passe SVN: " SVN_PASSWORD
echo ""

if [ -z "$SVN_PASSWORD" ]; then
    echo -e "${RED}Erreur: mot de passe SVN requis${NC}"
    exit 1
fi

# Checkout ou update du repository SVN
if [ -d "$SVN_DIR" ]; then
    echo -e "${YELLOW}Mise à jour du repository SVN existant...${NC}"
    cd "$SVN_DIR"
    svn update --username "$SVN_USERNAME" --password "$SVN_PASSWORD" --non-interactive
else
    echo -e "${YELLOW}Checkout du repository SVN...${NC}"
    svn checkout "$SVN_URL" "$SVN_DIR" --username "$SVN_USERNAME" --password "$SVN_PASSWORD" --non-interactive
    cd "$SVN_DIR"
fi

echo -e "${GREEN}✓ Repository SVN prêt${NC}"

# Nettoyage du trunk
echo -e "${YELLOW}Nettoyage du trunk...${NC}"
rm -rf trunk/*

# Copie des fichiers du plugin
echo -e "${YELLOW}Copie des fichiers du plugin...${NC}"

# Fichiers principaux
cp "$PLUGIN_DIR/expansai-post-to-ai.php" trunk/
cp "$PLUGIN_DIR/readme.txt" trunk/
cp "$PLUGIN_DIR/uninstall.php" trunk/

# Répertoires
cp -r "$PLUGIN_DIR/includes" trunk/
cp -r "$PLUGIN_DIR/assets/css" trunk/assets/
cp -r "$PLUGIN_DIR/assets/js" trunk/assets/
mkdir -p trunk/assets/images
cp -r "$PLUGIN_DIR/assets/images/"*.svg trunk/assets/images/ 2>/dev/null || true

# Langues (si présentes)
if [ -d "$PLUGIN_DIR/languages" ] && [ "$(ls -A $PLUGIN_DIR/languages)" ]; then
    cp -r "$PLUGIN_DIR/languages" trunk/
fi

echo -e "${GREEN}✓ Fichiers copiés dans trunk/${NC}"

# Copie des assets WordPress.org (screenshots, bannières)
echo -e "${YELLOW}Copie des assets WordPress.org...${NC}"
mkdir -p assets

# Recherche et copie des screenshots et bannières
if [ -d "$PLUGIN_DIR/assets/images" ]; then
    # Screenshots
    for ext in png jpg jpeg; do
        for file in "$PLUGIN_DIR/assets/images/screenshot-"*."$ext"; do
            [ -f "$file" ] && cp "$file" assets/
        done
    done
    
    # Bannières
    for ext in png jpg jpeg; do
        for file in "$PLUGIN_DIR/assets/images/banner-"*."$ext"; do
            [ -f "$file" ] && cp "$file" assets/
        done
    done
    
    # Icône
    for ext in png jpg jpeg svg; do
        for file in "$PLUGIN_DIR/assets/images/icon-"*."$ext"; do
            [ -f "$file" ] && cp "$file" assets/
        done
    done
fi

echo -e "${GREEN}✓ Assets copiés${NC}"

# Affichage des modifications
echo ""
echo -e "${YELLOW}Modifications à commiter:${NC}"
svn status

# Ajout des nouveaux fichiers
echo -e "${YELLOW}Ajout des nouveaux fichiers...${NC}"
svn add --force trunk/* --auto-props --parents --depth infinity -q 2>/dev/null || true
svn add --force assets/* --auto-props --parents --depth infinity -q 2>/dev/null || true

# Suppression des fichiers supprimés
DELETED_FILES=$(svn status | grep '^!' | awk '{print $2}')
if [ -n "$DELETED_FILES" ]; then
    echo "$DELETED_FILES" | xargs svn delete
fi

# Confirmation avant commit
echo ""
echo -e "${YELLOW}Prêt à commiter vers WordPress.org${NC}"
echo "Version: ${PLUGIN_VERSION}"
read -p "Continuer? (o/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Oo]$ ]]; then
    echo -e "${RED}Déploiement annulé${NC}"
    exit 1
fi

# Commit vers trunk
echo -e "${YELLOW}Commit vers trunk...${NC}"
svn commit -m "Version ${PLUGIN_VERSION}" --username "$SVN_USERNAME" --password "$SVN_PASSWORD" --non-interactive

echo -e "${GREEN}✓ Trunk committé${NC}"

# Création du tag
echo -e "${YELLOW}Création du tag ${PLUGIN_VERSION}...${NC}"

if [ -d "tags/${PLUGIN_VERSION}" ]; then
    echo -e "${YELLOW}Le tag ${PLUGIN_VERSION} existe déjà, il sera écrasé${NC}"
    svn delete "tags/${PLUGIN_VERSION}"
    svn commit -m "Suppression du tag ${PLUGIN_VERSION} pour recréation" --username "$SVN_USERNAME" --password "$SVN_PASSWORD" --non-interactive
fi

svn copy trunk "tags/${PLUGIN_VERSION}"
svn commit -m "Tagging version ${PLUGIN_VERSION}" --username "$SVN_USERNAME" --password "$SVN_PASSWORD" --non-interactive

echo -e "${GREEN}✓ Tag ${PLUGIN_VERSION} créé${NC}"

# Succès
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ DÉPLOIEMENT RÉUSSI !${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Votre plugin sera visible sur WordPress.org dans quelques minutes:"
echo "https://wordpress.org/plugins/${PLUGIN_SLUG}/"
echo ""
echo "Note: Les résultats de recherche peuvent prendre jusqu'à 72h pour être mis à jour."
echo ""

# Retour au répertoire du plugin
cd "$PLUGIN_DIR"

echo -e "${GREEN}✓ Script terminé${NC}"
