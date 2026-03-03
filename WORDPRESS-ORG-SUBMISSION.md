# Guide de Soumission au Répertoire WordPress.org

Ce guide vous explique comment soumettre le plugin ShareToAI au répertoire officiel WordPress.org.

---

## 📋 Prérequis

### ✅ Votre Plugin Est Prêt

Avant de soumettre, vérifiez que votre plugin respecte toutes les exigences :

- [x] **Code propre et sécurisé** : 22/22 tests de sécurité validés
- [x] **GPL compatible** : Licence GPL v2 or later
- [x] **Pas de code obfusqué** : Code source lisible
- [x] **Fonctionnel** : Testé et fonctionnel sur WordPress 5.0+
- [x] **Documentation** : readme.txt au format WordPress.org
- [x] **Pas de tracking sans consentement** : Aucun tracking externe
- [x] **Pas de contenu premium obligatoire** : Plugin 100% gratuit
- [x] **Nom unique** : "ShareToAI" n'existe pas encore

---

## 🚀 Processus de Soumission (Étape par Étape)

### ÉTAPE 1 : Créer un Compte WordPress.org

1. **Allez sur** : https://login.wordpress.org/register
2. **Remplissez le formulaire** :
   - Username : `flowt` (ou votre choix)
   - Email : Votre email professionnel
3. **Validez votre email**
4. **Complétez votre profil** : https://profiles.wordpress.org/

---

### ÉTAPE 2 : Préparer le Plugin pour Soumission

#### 2.1 Vérifier le readme.txt

Le fichier `readme.txt` est déjà prêt et conforme au format WordPress.org.

Vérifiez-le avec le validateur officiel :
- https://wordpress.org/plugins/developers/readme-validator/

#### 2.2 Ajouter des Screenshots (Recommandé)

Créez des captures d'écran de votre plugin :

1. **Screenshot 1** : Page de configuration (Réglages > ShareToAI)
2. **Screenshot 2** : Affichage en style "Icônes" sur un article
3. **Screenshot 3** : Affichage en style "Boutons"
4. **Screenshot 4** : Affichage en style "Liste"

Nommez-les : `screenshot-1.png`, `screenshot-2.png`, etc.
Taille recommandée : 1280x720px ou 1920x1080px

Placez-les dans le dossier `assets/` de votre repository SVN (après approbation).

#### 2.3 Créer un Banner (Optionnel)

Pour la page du plugin sur WordPress.org :
- `banner-772x250.png` : Banner principal
- `banner-1544x500.png` : Banner haute résolution

---

### ÉTAPE 3 : Soumettre le Plugin

1. **Allez sur** : https://wordpress.org/plugins/developers/add/

2. **Uploadez le ZIP** : `sharetoai-1.0.0.zip`

3. **Remplissez le formulaire** :

   **Plugin Name** : ShareToAI
   
   **Plugin Description** :
   ```
   Plugin WordPress qui ajoute automatiquement des liens vers différentes IA 
   (Perplexity, ChatGPT, Claude, Grok, Mistral) pour résumer le contenu de vos 
   posts et Custom Post Types. Entièrement personnalisable avec shortcode, 
   3 styles d'affichage et mises à jour automatiques.
   ```
   
   **Plugin URL** : https://github.com/webAnalyste/shareToAI

4. **Cochez les cases** :
   - [x] J'ai lu et j'accepte les guidelines
   - [x] Mon plugin est 100% GPL compatible
   - [x] Mon plugin ne contient pas de code malveillant

5. **Cliquez sur "Submit Plugin"**

---

### ÉTAPE 4 : Attendre la Validation

**Délai** : Entre 3 et 14 jours (généralement 5-7 jours)

**Vous recevrez un email** :
- ✅ **Approuvé** : Vous recevez les instructions SVN
- ❌ **Refusé** : Vous recevez les raisons du refus et pouvez corriger

**Pendant l'attente** :
- Ne soumettez pas à nouveau
- Vérifiez votre email régulièrement
- Préparez vos screenshots

---

### ÉTAPE 5 : Configuration SVN (Après Approbation)

Une fois approuvé, vous recevrez un email avec :
- URL du repository SVN : `https://plugins.svn.wordpress.org/sharetoai`
- Instructions de commit

#### 5.1 Installer SVN

```bash
# macOS
brew install svn

# Vérifier l'installation
svn --version
```

#### 5.2 Checkout du Repository

```bash
# Créer un dossier pour SVN
cd ~/Documents/Dev
svn co https://plugins.svn.wordpress.org/sharetoai sharetoai-svn
cd sharetoai-svn
```

Vous verrez cette structure :
```
sharetoai-svn/
├── trunk/        # Version de développement
├── tags/         # Versions publiées
└── assets/       # Screenshots et banners
```

#### 5.3 Copier les Fichiers dans trunk/

```bash
# Copier tous les fichiers du plugin
cp -r ../shareToAI/sharetoai.php trunk/
cp -r ../shareToAI/uninstall.php trunk/
cp -r ../shareToAI/readme.txt trunk/
cp -r ../shareToAI/assets trunk/
cp -r ../shareToAI/includes trunk/

# Ajouter les fichiers à SVN
cd trunk
svn add --force * --auto-props --parents --depth infinity -q
```

#### 5.4 Ajouter les Screenshots (Optionnel)

```bash
# Copier les screenshots dans assets/
cp ~/path/to/screenshot-1.png ../assets/
cp ~/path/to/screenshot-2.png ../assets/
cp ~/path/to/banner-772x250.png ../assets/

cd ../assets
svn add *.png
```

#### 5.5 Premier Commit

```bash
cd ..
svn ci -m "Initial commit of ShareToAI v1.0.0"
```

**Entrez vos identifiants WordPress.org quand demandé.**

#### 5.6 Créer le Premier Tag (Version 1.0.0)

```bash
# Créer le tag depuis trunk
svn cp trunk tags/1.0.0
svn ci -m "Tagging version 1.0.0"
```

**🎉 Votre plugin est maintenant publié sur WordPress.org !**

Il apparaîtra dans quelques minutes sur :
- https://wordpress.org/plugins/sharetoai/

---

## 🔄 Publier une Mise à Jour

Quand vous avez une nouvelle version (ex: 1.1.0) :

### 1. Mettre à jour les fichiers

```bash
cd ~/Documents/Dev/sharetoai-svn/trunk

# Copier les nouveaux fichiers
cp -r ../../shareToAI/sharetoai.php .
cp -r ../../shareToAI/readme.txt .
# etc...

# Commit
svn ci -m "Update to version 1.1.0"
```

### 2. Créer le nouveau tag

```bash
svn cp trunk tags/1.1.0
svn ci -m "Tagging version 1.1.0"
```

### 3. Les utilisateurs sont notifiés

WordPress.org notifie automatiquement tous les utilisateurs de la mise à jour disponible.

---

## 📊 Après Publication

### Votre Plugin sur WordPress.org

URL : https://wordpress.org/plugins/sharetoai/

**Fonctionnalités disponibles** :
- ✅ Installation directe depuis WordPress admin
- ✅ Mises à jour automatiques natives WordPress
- ✅ Statistiques d'installation
- ✅ Notes et avis utilisateurs
- ✅ Forum de support
- ✅ Visibilité dans le répertoire

### Gérer les Avis et Support

1. **Forum de support** : https://wordpress.org/support/plugin/sharetoai/
   - Répondez aux questions dans les 48h
   - Marquez les sujets comme résolus

2. **Avis** : https://wordpress.org/support/plugin/sharetoai/reviews/
   - Remerciez les avis positifs
   - Répondez aux avis négatifs avec solutions

### Statistiques

Accédez aux stats sur :
- https://wordpress.org/plugins/sharetoai/advanced/

Vous verrez :
- Installations actives
- Téléchargements par version
- Notes moyennes
- Tendances

---

## ⚠️ Guidelines Importantes

### Ce Qui Est INTERDIT

❌ **Tracking sans consentement** : Pas de Google Analytics, tracking, etc. sans opt-in explicite
❌ **Appels externes non déclarés** : Toute API externe doit être documentée
❌ **Code obfusqué** : Le code doit être lisible
❌ **Contenu premium obligatoire** : Le plugin doit être 100% fonctionnel gratuitement
❌ **Spam** : Pas de liens excessifs vers votre site
❌ **Marques déposées** : Pas d'utilisation de marques sans permission

### Ce Qui Est RECOMMANDÉ

✅ **Support actif** : Répondre aux questions rapidement
✅ **Mises à jour régulières** : Maintenir le plugin à jour
✅ **Documentation claire** : README complet et à jour
✅ **Code propre** : Suivre les WordPress Coding Standards
✅ **Sécurité** : Valider et échapper toutes les données
✅ **Compatibilité** : Tester avec les dernières versions WP

---

## 🔗 Ressources Officielles

- **Guidelines** : https://developer.wordpress.org/plugins/wordpress-org/detailed-plugin-guidelines/
- **Soumettre un plugin** : https://wordpress.org/plugins/developers/add/
- **Documentation SVN** : https://developer.wordpress.org/plugins/wordpress-org/how-to-use-subversion/
- **readme.txt validator** : https://wordpress.org/plugins/developers/readme-validator/
- **Forum développeurs** : https://wordpress.org/support/forum/plugins-and-hacks/

---

## 🎯 Checklist Finale Avant Soumission

- [ ] Compte WordPress.org créé et validé
- [ ] Plugin testé sur WordPress 5.0+ et 6.4+
- [ ] Plugin testé sur PHP 7.4+ et 8.0+
- [ ] readme.txt validé avec le validateur officiel
- [ ] Aucune erreur PHP (WP_DEBUG activé)
- [ ] Screenshots préparés (4 minimum recommandés)
- [ ] Banner créé (optionnel mais recommandé)
- [ ] Code conforme aux WordPress Coding Standards
- [ ] Licence GPL v2 or later
- [ ] Pas de tracking sans consentement
- [ ] Documentation complète
- [ ] Version testée et stable

---

## 💡 Avantages WordPress.org vs GitHub

| Critère | WordPress.org | GitHub Releases |
|---------|---------------|-----------------|
| **Installation** | Directe depuis WP admin | Upload manuel du ZIP |
| **Mises à jour** | Automatiques natives | Via notre système custom |
| **Visibilité** | Répertoire officiel | Communauté GitHub |
| **Support** | Forum intégré | GitHub Issues |
| **Stats** | Installations actives | Download count |
| **Validation** | Review par WordPress | Aucune |
| **Délai** | 3-14 jours | Immédiat |

**Recommandation** : Publier sur **les deux** !
- WordPress.org pour la visibilité et l'adoption massive
- GitHub pour les développeurs et les contributions

---

## 📞 Support

Pour toute question sur la soumission :
- Forum développeurs : https://wordpress.org/support/forum/plugins-and-hacks/
- Slack WordPress : https://make.wordpress.org/chat/

---

**Bonne chance pour votre soumission ! 🚀**
