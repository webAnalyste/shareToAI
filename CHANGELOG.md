# Changelog - ShareToAI

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [1.0.0] - 2026-03-03

### Ajouté
- ✨ Affichage automatique des liens de résumé IA sur les posts et CPT
- ✨ Support de 5 services IA : Perplexity, ChatGPT, Claude, Grok, Mistral
- ✨ Shortcode `[sharetoai]` pour placement manuel
- ✨ Interface d'administration complète dans Réglages > ShareToAI
- ✨ Personnalisation du texte d'invitation
- ✨ Personnalisation du prompt avec placeholder `{URL}`
- ✨ Choix de la position : haut, bas, les deux, ou manuel
- ✨ Sélection des types de contenu (posts, pages, CPT)
- ✨ Sélection des services IA à afficher
- ✨ 3 styles d'affichage : icônes, boutons, liste
- ✨ Icônes SVG personnalisées pour chaque service IA
- ✨ Design responsive et accessible
- ✨ Tracking des clics compatible Google Analytics
- ✨ Support de l'internationalisation (i18n)
- ✨ **Système de mise à jour automatique depuis GitHub**
- 🔒 Sécurité conforme aux standards WordPress
- 📚 Documentation complète (README, INSTALLATION, ARCHITECTURE, SECURITY-TESTS)
- 🔄 Versioning GIT complet

### Sécurité
- 🔒 Protection contre l'inclusion directe de fichiers
- 🔒 Validation et échappement de toutes les entrées/sorties
- 🔒 Vérification des capacités utilisateur (manage_options)
- 🔒 Utilisation exclusive des fonctions natives WordPress
- 🔒 Nonces automatiques via settings_fields()
- 🔒 Aucune fonction dangereuse (eval, exec, etc.)

### Technique
- 🏗️ Architecture Singleton pour la classe principale
- 🏗️ Séparation frontend/admin
- 🏗️ Hooks WordPress standards
- 🏗️ Options enregistrées via Settings API
- 🏗️ Assets chargés conditionnellement
- 🏗️ Code compatible PHP 7.4+
- 🏗️ Compatible WordPress 5.0+
- 🏗️ Compatible multisite

### Documentation
- 📖 README.md : Documentation principale
- 📖 INSTALLATION.md : Guide d'installation pas à pas
- 📖 ARCHITECTURE.md : Documentation technique de l'architecture
- 📖 SECURITY-TESTS.md : Tests de sécurité et validation (22/22 tests réussis)
- 📖 CHANGELOG.md : Historique des versions

### Commits GIT
- `f6603af` - feat: création plugin ShareToAI v1.0.0
- `1dd6c63` - docs: ajout documentation tests sécurité et guide installation
- `fc8b380` - docs: ajout documentation architecture du plugin

---

## [Non publié]

### Prochaines fonctionnalités envisagées
- 🔮 Ajout de nouveaux services IA (Gemini, DeepSeek, etc.)
- 🔮 Personnalisation des couleurs via Color Picker
- 🔮 Statistiques de clics dans l'admin
- 🔮 Export/Import des paramètres
- 🔮 Templates personnalisables
- 🔮 Support des meta boxes pour activation/désactivation par post
- 🔮 Widget Gutenberg dédié
- 🔮 Shortcode avec paramètres (services spécifiques, style, etc.)

---

**Légende :**
- ✨ Nouvelle fonctionnalité
- 🔒 Sécurité
- 🐛 Correction de bug
- 🏗️ Technique
- 📖 Documentation
- 🔮 Futur
