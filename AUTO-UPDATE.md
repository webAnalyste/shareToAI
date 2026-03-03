# Système de Mise à Jour Automatique - ShareToAI

Le plugin ShareToAI intègre un système de **mise à jour automatique** qui vérifie et installe automatiquement les nouvelles versions depuis GitHub.

## 🔄 Comment Ça Fonctionne

### Pour les Utilisateurs

**Aucune action requise !** Le plugin se met à jour automatiquement comme n'importe quel plugin WordPress.

1. **Notification automatique** : Quand une nouvelle version est disponible, WordPress affiche une notification dans Extensions > Extensions installées
2. **Mise à jour en un clic** : Cliquez sur "Mettre à jour maintenant"
3. **Installation automatique** : Le plugin télécharge et installe la nouvelle version depuis GitHub
4. **Réactivation** : Le plugin est automatiquement réactivé après la mise à jour

### Vérification des Mises à Jour

WordPress vérifie automatiquement les mises à jour :
- **Toutes les 12 heures** (par défaut)
- **Manuellement** : Extensions > Extensions installées > Vérifier les mises à jour

---

## 🛠️ Architecture Technique

### Composants

1. **`includes/class-updater.php`** : Classe principale de gestion des mises à jour
2. **GitHub Releases API** : Source des informations de version
3. **WordPress Update API** : Intégration native WordPress

### Flux de Mise à Jour

```
WordPress vérifie les mises à jour
    ↓
ShareToAI_Updater::check_update()
    ↓
Appel GitHub API : /repos/webAnalyste/shareToAI/releases/latest
    ↓
Comparaison version locale vs distante
    ↓
Si nouvelle version disponible
    ↓
Notification dans WordPress admin
    ↓
Utilisateur clique "Mettre à jour"
    ↓
Téléchargement du ZIP depuis GitHub Releases
    ↓
Installation automatique
    ↓
Réactivation du plugin
```

### Hooks WordPress Utilisés

```php
// Vérification des mises à jour
add_filter('pre_set_site_transient_update_plugins', 'check_update');

// Informations du plugin (popup de mise à jour)
add_filter('plugins_api', 'plugin_info');

// Post-installation (renommage du dossier)
add_filter('upgrader_post_install', 'after_install');
```

---

## 📋 Pour les Développeurs

### Publier une Nouvelle Version

#### 1. Mettre à jour la version

```bash
# Éditer sharetoai.php
Version: 1.1.0
define('SHARETOAI_VERSION', '1.1.0');

# Éditer readme.txt
Stable tag: 1.1.0

# Mettre à jour CHANGELOG.md
## [1.1.0] - 2026-03-XX
- Nouvelles fonctionnalités...
```

#### 2. Créer le ZIP de release

```bash
./build-release.sh 1.1.0
```

#### 3. Commiter et pousser

```bash
git add -A
git commit -m "release: version 1.1.0"
git push origin main
```

#### 4. Créer la Release GitHub

```bash
gh release create v1.1.0 sharetoai-1.1.0.zip \
  --title "ShareToAI v1.1.0" \
  --notes "$(cat CHANGELOG.md | sed -n '/## \[1.1.0\]/,/## \[/p' | head -n -1)"
```

**Important** : Le fichier ZIP doit être nommé `sharetoai-X.X.X.zip` et uploadé sur la release GitHub.

#### 5. Les utilisateurs sont notifiés automatiquement

Dans les 12 heures suivantes, tous les utilisateurs verront la notification de mise à jour dans leur admin WordPress.

---

## 🔍 Détails Techniques

### Cache et Performance

- **Cache de version** : 6 heures (transient `sharetoai_remote_version`)
- **Cache changelog** : 12 heures (transient `sharetoai_changelog`)
- **Timeout API** : 10 secondes

### Gestion des Erreurs

Si l'API GitHub est indisponible :
- Le cache précédent est utilisé
- Pas de notification d'erreur à l'utilisateur
- Nouvelle tentative au prochain check (12h)

### Sécurité

- ✅ Utilisation de `wp_remote_get()` (fonction WordPress sécurisée)
- ✅ Vérification SSL automatique
- ✅ Timeout pour éviter les blocages
- ✅ Validation du format de version
- ✅ Téléchargement uniquement depuis GitHub officiel

---

## 🧪 Tester le Système de Mise à Jour

### En Développement

1. **Installer la version 1.0.0** sur un site WordPress de test
2. **Créer une version 1.0.1** avec un changement mineur
3. **Publier la release v1.0.1** sur GitHub
4. **Forcer la vérification** :
   ```php
   // Dans wp-admin, exécuter via un plugin temporaire
   delete_transient('sharetoai_remote_version');
   wp_update_plugins();
   ```
5. **Vérifier** : Extensions > Extensions installées
6. **Mettre à jour** et vérifier que tout fonctionne

### Vérifier Manuellement

```bash
# Tester l'API GitHub
curl -s https://api.github.com/repos/webAnalyste/shareToAI/releases/latest | jq '.tag_name'

# Vérifier que le ZIP existe
curl -I https://github.com/webAnalyste/shareToAI/releases/download/v1.0.0/sharetoai-1.0.0.zip
```

---

## 🐛 Dépannage

### La mise à jour ne s'affiche pas

**Causes possibles :**
1. Cache WordPress non vidé
2. Transient bloqué
3. API GitHub inaccessible
4. Format de version incorrect

**Solutions :**
```php
// Vider les transients
delete_transient('sharetoai_remote_version');
delete_transient('sharetoai_changelog');

// Forcer la vérification
wp_update_plugins();
```

### Erreur lors du téléchargement

**Vérifier :**
- Le fichier ZIP existe sur GitHub Releases
- Le nom du fichier est correct : `sharetoai-X.X.X.zip`
- Le serveur peut accéder à GitHub (pas de firewall bloquant)

### Le plugin ne se réactive pas

**Cause :** Erreur PHP dans la nouvelle version

**Solution :**
1. Activer `WP_DEBUG` et `WP_DEBUG_LOG`
2. Vérifier `/wp-content/debug.log`
3. Corriger l'erreur et republier

---

## 📊 Monitoring

### Logs WordPress

Activer le debug pour voir les requêtes :

```php
// wp-config.php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

### Statistiques GitHub

Voir les téléchargements de chaque release :
- GitHub > Releases > Assets > Download count

---

## 🔮 Améliorations Futures

Fonctionnalités envisagées :
- [ ] Notifications par email aux admins
- [ ] Rollback automatique en cas d'erreur
- [ ] Beta testing (canal de mise à jour beta)
- [ ] Statistiques d'installation dans l'admin
- [ ] Changelog dans l'admin WordPress

---

## 📞 Support

Pour toute question sur le système de mise à jour :
- GitHub Issues : https://github.com/webAnalyste/shareToAI/issues
- Documentation : https://github.com/webAnalyste/shareToAI

---

**Le système de mise à jour automatique est actif dès la version 1.0.0 !**
