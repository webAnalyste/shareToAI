# Guide de Test du Système de Mise à Jour

**Date** : 7 mars 2026  
**Version actuelle** : 1.0.3  
**Nouvelle version disponible** : 1.1.0  
**Statut** : ✅ Système opérationnel

---

## ✅ Configuration Terminée

- ✅ Dépôt GitHub public : https://github.com/webAnalyste/shareToAI
- ✅ Release v1.1.0 créée avec succès
- ✅ API GitHub fonctionnelle
- ✅ Fichier ZIP téléchargeable
- ✅ Code sécurisé et conforme aux standards WordPress

---

## 🧪 Test du Système de Mise à Jour

### Étape 1 : Activer les Logs de Debugging

Dans votre fichier `wp-config.php` :

```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

### Étape 2 : Forcer la Vérification des Mises à Jour

**Option A - Via l'admin WordPress** :
1. Allez dans **Extensions > Extensions installées**
2. Cliquez sur **"Vérifier les mises à jour"** en haut de la page
3. Vous devriez voir une notification pour ShareToAI v1.1.0

**Option B - Via code (plugin temporaire ou console)** :
```php
// Vider les caches
delete_transient('sharetoai_remote_version');
delete_transient('sharetoai_changelog');

// Forcer la vérification
wp_update_plugins();
```

### Étape 3 : Vérifier les Logs

Consultez le fichier de log :
```bash
tail -f wp-content/debug.log | grep "ShareToAI Updater"
```

**Logs attendus** :
```
[ShareToAI Updater] [INFO] Vérification de la version distante sur : https://api.github.com/repos/webAnalyste/shareToAI/releases/latest
[ShareToAI Updater] [INFO] Version distante trouvée : 1.1.0
[ShareToAI Updater] [INFO] Nouvelle version disponible : 1.1.0 (actuelle : 1.0.3)
```

### Étape 4 : Installer la Mise à Jour

1. Dans **Extensions > Extensions installées**
2. Sous ShareToAI, cliquez sur **"Mettre à jour maintenant"**
3. Attendez la fin de l'installation
4. Le plugin devrait se réactiver automatiquement

**Logs attendus pendant l'installation** :
```
[ShareToAI Updater] [INFO] Suppression de l'ancien dossier : /path/to/wp-content/plugins/sharetoai
[ShareToAI Updater] [INFO] Déplacement de /tmp/... vers /path/to/wp-content/plugins/sharetoai
[ShareToAI Updater] [INFO] Réactivation du plugin après mise à jour
[ShareToAI Updater] [INFO] Installation terminée avec succès
```

### Étape 5 : Vérifier la Version Installée

Dans **Extensions > Extensions installées**, vérifiez que la version affichée est **1.1.0**.

---

## 🎯 Améliorations de la Version 1.1.0

Cette version contient des améliorations critiques du système de mise à jour :

### Sécurité Renforcée
- ✅ Vérification de l'initialisation de `WP_Filesystem()`
- ✅ Validation de l'existence des dossiers source/destination
- ✅ Suppression sécurisée de l'ancien dossier avant déplacement
- ✅ Gestion d'erreurs à chaque étape critique

### Logs de Debugging
- ✅ Nouvelle fonction `log()` pour tracer toutes les opérations
- ✅ Logs dans `check_update()`, `get_remote_version()`, `after_install()`
- ✅ Détection des erreurs HTTP, JSON, filesystem
- ✅ Messages d'erreur explicites et actionnables

### Gestion d'Erreurs Robuste
- ✅ Détection des erreurs HTTP (404 = dépôt privé/inexistant)
- ✅ Validation du décodage JSON
- ✅ Vérification de chaque opération filesystem
- ✅ Rollback automatique en cas d'échec

---

## 🐛 Dépannage

### La mise à jour ne s'affiche pas

**Vérifier** :
```bash
# L'API GitHub est accessible
curl -s https://api.github.com/repos/webAnalyste/shareToAI/releases/latest | jq '.tag_name'
# Devrait retourner : "v1.1.0"
```

**Solution** :
```php
// Vider les caches et forcer la vérification
delete_transient('sharetoai_remote_version');
delete_transient('sharetoai_changelog');
wp_update_plugins();
```

### Erreur lors du téléchargement

**Vérifier** :
```bash
# Le fichier ZIP est téléchargeable
curl -I https://github.com/webAnalyste/shareToAI/releases/download/v1.1.0/sharetoai-1.1.0.zip
# Devrait retourner : HTTP/2 302
```

**Consulter les logs** :
```bash
tail -50 wp-content/debug.log | grep "ShareToAI Updater"
```

### Le plugin ne se réactive pas

**Cause possible** : Erreur PHP dans la nouvelle version

**Solution** :
1. Activer `WP_DEBUG` et `WP_DEBUG_LOG`
2. Vérifier `/wp-content/debug.log`
3. Corriger l'erreur et republier

---

## 📊 Checklist de Validation

- [ ] WP_DEBUG_LOG activé
- [ ] Cache vidé (`delete_transient`)
- [ ] Notification de mise à jour visible dans WordPress admin
- [ ] Logs montrent la détection de la version 1.1.0
- [ ] Mise à jour installée sans erreur
- [ ] Plugin réactivé automatiquement
- [ ] Version affichée = 1.1.0
- [ ] Aucune erreur dans debug.log
- [ ] Fonctionnalités du plugin opérationnelles

---

## 🔄 Workflow pour les Futures Mises à Jour

### 1. Mettre à jour la version

Dans `sharetoai.php` :
```php
Version: 1.2.0
define('SHARETOAI_VERSION', '1.2.0');
```

Dans `readme.txt` :
```
Stable tag: 1.2.0
```

### 2. Mettre à jour le CHANGELOG.md

```markdown
## [1.2.0] - 2026-XX-XX
- Nouvelles fonctionnalités...
```

### 3. Créer le ZIP

```bash
./build-release.sh 1.2.0
```

### 4. Commiter et pousser

```bash
git add -A
git commit -m "release: version 1.2.0"
git push origin main
```

### 5. Créer la Release GitHub

```bash
gh release create v1.2.0 sharetoai-1.2.0.zip \
  --title "ShareToAI v1.2.0" \
  --notes "$(cat CHANGELOG.md | sed -n '/## \[1.2.0\]/,/## \[/p' | head -n -1)"
```

### 6. Les utilisateurs sont notifiés automatiquement

Dans les 12 heures suivantes, tous les utilisateurs verront la notification de mise à jour.

---

## 📞 Support

- **GitHub Issues** : https://github.com/webAnalyste/shareToAI/issues
- **Documentation** : https://github.com/webAnalyste/shareToAI
- **Diagnostic** : `DIAGNOSTIC-MISE-A-JOUR.md`

---

**Le système de mise à jour automatique est maintenant pleinement opérationnel ! 🎉**
