# Guide de Distribution - ShareToAI

Ce guide explique comment distribuer le plugin ShareToAI aux utilisateurs finaux.

## 📦 Pour les Utilisateurs Finaux

### Méthode 1 : Installation via GitHub Releases (Recommandée)

1. **Télécharger le plugin**
   - Allez sur https://github.com/webAnalyste/shareToAI/releases
   - Téléchargez le fichier `sharetoai-X.X.X.zip`

2. **Installer sur WordPress**
   - Connectez-vous à votre admin WordPress
   - Allez dans **Extensions** > **Ajouter**
   - Cliquez sur **Téléverser une extension**
   - Sélectionnez le fichier ZIP téléchargé
   - Cliquez sur **Installer maintenant**
   - Activez le plugin

3. **Configurer**
   - Allez dans **Réglages** > **ShareToAI**
   - Configurez selon vos préférences
   - Enregistrez

### Méthode 2 : Installation via Git (Pour développeurs)

```bash
cd /var/www/html/wp-content/plugins/
git clone https://github.com/webAnalyste/shareToAI.git
```

Puis activez le plugin dans WordPress.

---

## 🛠️ Pour les Développeurs/Mainteneurs

### Créer une Nouvelle Release

#### 1. Mettre à jour la version

Éditez ces fichiers :
- `sharetoai.php` : Ligne 6 `Version: X.X.X`
- `sharetoai.php` : Ligne 19 `define('SHARETOAI_VERSION', 'X.X.X');`
- `readme.txt` : Ligne 6 `Stable tag: X.X.X`
- `CHANGELOG.md` : Ajoutez la nouvelle version

#### 2. Créer le fichier ZIP

```bash
./build-release.sh 1.0.0
```

Cela crée `sharetoai-1.0.0.zip` prêt pour la distribution.

#### 3. Tester le ZIP

1. Installez le ZIP sur un site WordPress de test
2. Vérifiez que tout fonctionne
3. Testez l'activation/désactivation
4. Testez la désinstallation

#### 4. Créer la Release GitHub

**Via l'interface GitHub :**
1. Allez sur https://github.com/webAnalyste/shareToAI/releases
2. Cliquez sur **"Draft a new release"**
3. Tag : `v1.0.0`
4. Title : `ShareToAI v1.0.0`
5. Description : Copiez depuis CHANGELOG.md
6. Uploadez le fichier `sharetoai-1.0.0.zip`
7. Cliquez sur **"Publish release"**

**Via GitHub CLI :**
```bash
gh release create v1.0.0 sharetoai-1.0.0.zip \
  --title "ShareToAI v1.0.0" \
  --notes-file CHANGELOG.md
```

---

## 📊 Checklist de Release

Avant de publier une release, vérifiez :

- [ ] Version mise à jour dans tous les fichiers
- [ ] CHANGELOG.md à jour
- [ ] Tests de sécurité passés (voir SECURITY-TESTS.md)
- [ ] Plugin testé sur WordPress 5.0+ et 6.4+
- [ ] Plugin testé sur PHP 7.4+ et 8.0+
- [ ] Aucune erreur PHP (WP_DEBUG activé)
- [ ] Fichiers inutiles exclus du ZIP (.git, .github, etc.)
- [ ] readme.txt formaté correctement
- [ ] Screenshots à jour
- [ ] Documentation complète

---

## 🌐 Soumission au WordPress Plugin Directory (Optionnel)

Pour rendre le plugin disponible dans le répertoire officiel WordPress :

### 1. Créer un compte WordPress.org

https://wordpress.org/support/register.php

### 2. Soumettre le plugin

1. Allez sur https://wordpress.org/plugins/developers/add/
2. Uploadez le fichier ZIP
3. Remplissez le formulaire
4. Attendez la validation (peut prendre quelques jours)

### 3. Préparer pour la validation

Le plugin doit respecter :
- [Plugin Guidelines](https://developer.wordpress.org/plugins/wordpress-org/detailed-plugin-guidelines/)
- Pas de code obfusqué
- Pas de tracking sans consentement
- GPL compatible
- Sécurité conforme

### 4. Utiliser SVN (après approbation)

WordPress.org utilise SVN pour héberger les plugins :

```bash
# Checkout du repository SVN
svn co https://plugins.svn.wordpress.org/sharetoai sharetoai-svn
cd sharetoai-svn

# Copier les fichiers dans trunk/
cp -r ../shareToAI/* trunk/

# Ajouter les fichiers
svn add trunk/*

# Commit
svn ci -m "Version 1.0.0"

# Créer un tag
svn cp trunk tags/1.0.0
svn ci -m "Tagging version 1.0.0"
```

---

## 📈 Promotion du Plugin

### Sur GitHub
- README.md attractif avec badges
- Screenshots dans le repository
- Issues et Discussions activées
- GitHub Topics : `wordpress`, `wordpress-plugin`, `ai`, `chatgpt`

### Sur WordPress.org (si soumis)
- Description détaillée
- Screenshots de qualité
- FAQ complète
- Support actif dans les forums

### Communication
- Article de blog sur flowt.fr
- Partage sur réseaux sociaux
- Documentation vidéo (optionnel)

---

## 🔄 Mises à Jour

Pour publier une mise à jour :

1. Développez les nouvelles fonctionnalités
2. Mettez à jour CHANGELOG.md
3. Incrémentez la version (suivez [Semantic Versioning](https://semver.org/))
   - **Patch** (1.0.1) : Corrections de bugs
   - **Minor** (1.1.0) : Nouvelles fonctionnalités rétrocompatibles
   - **Major** (2.0.0) : Changements non rétrocompatibles
4. Créez une nouvelle release
5. Les utilisateurs seront notifiés dans leur admin WordPress

---

## 📞 Support Utilisateurs

### Canaux de support
- GitHub Issues : Bugs et demandes de fonctionnalités
- GitHub Discussions : Questions générales
- Site web : https://www.flowt.fr

### Répondre aux issues
- Réponse sous 48h maximum
- Étiquettes : `bug`, `enhancement`, `question`, `documentation`
- Fermeture après résolution et confirmation

---

## 📊 Statistiques

### GitHub
- Stars, Forks, Watchers
- Traffic : Vues, Clones
- Issues ouvertes/fermées

### WordPress.org (si soumis)
- Installations actives
- Notes et avis
- Downloads par version

---

## 🎯 Roadmap

Fonctionnalités futures envisagées :
- Support de nouveaux services IA (Gemini, DeepSeek)
- Statistiques de clics dans l'admin
- Widget Gutenberg dédié
- Personnalisation des couleurs
- Templates personnalisables

Voir CHANGELOG.md section "Non publié" pour plus de détails.
