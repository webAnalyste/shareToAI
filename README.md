# ShareToAI

Plugin WordPress qui ajoute automatiquement des liens vers différentes IA pour résumer le contenu de vos posts et Custom Post Types.

[![GitHub](https://img.shields.io/badge/GitHub-shareToAI-blue)](https://github.com/webAnalyste/shareToAI)

## Description

Ce plugin permet d'afficher automatiquement une invitation personnalisable "Résumer ce contenu avec :" suivie d'icônes cliquables vers différents services d'IA (Perplexity, ChatGPT, Claude, Grok, Mistral).

## Fonctionnalités

- ✅ Affichage automatique en haut, en bas ou les deux
- ✅ Support des posts et Custom Post Types
- ✅ Shortcode `[sharetoai]` pour placement manuel
- ✅ Texte et prompt personnalisables
- ✅ Choix des services IA à afficher
- ✅ 3 styles d'affichage : icônes, boutons, liste
- ✅ Responsive et accessible
- ✅ Sécurisé selon les standards WordPress
- ✅ Traçabilité des clics (compatible Google Analytics)

## Installation

1. Télécharger le dossier `sharetoai`
2. Le placer dans `/wp-content/plugins/`
3. Activer le plugin dans l'administration WordPress
4. Configurer les options dans Réglages > ShareToAI

## Configuration

### Paramètres disponibles

- **Activer le plugin** : Active/désactive l'affichage automatique
- **Position** : En haut, en bas, les deux, ou manuel (shortcode uniquement)
- **Types de contenu** : Sélectionner les post types où afficher les liens
- **Texte personnalisé** : Texte affiché avant les icônes
- **Prompt personnalisé** : Message envoyé aux IA (utilisez `{URL}` pour l'URL de la page)
- **Services IA activés** : Choisir quels services afficher
- **Style d'affichage** : Icônes, boutons ou liste

### Utilisation du shortcode

Pour afficher les liens manuellement dans vos contenus :

```
[sharetoai]
```

## Services IA supportés

- **Perplexity** : https://www.perplexity.ai
- **ChatGPT** : https://chat.openai.com
- **Claude** : https://claude.ai
- **Grok** : https://grok.com
- **Mistral** : https://chat.mistral.ai

## Sécurité

Le plugin respecte toutes les bonnes pratiques WordPress :
- Validation et échappement de toutes les entrées/sorties
- Vérification des capacités utilisateur
- Protection contre l'inclusion directe
- Utilisation des fonctions natives WordPress
- Nonces pour les formulaires
- Sanitization des options

## Compatibilité

- WordPress 5.0+
- PHP 7.4+
- Compatible multisite
- Compatible avec tous les thèmes

## Support

- GitHub : https://github.com/webAnalyste/shareToAI
- Site web : https://www.flowt.fr

## Changelog

### 1.0.0 (2026-03-03)
- Version initiale
- Affichage automatique et shortcode
- 5 services IA supportés
- 3 styles d'affichage
- Interface d'administration complète

## Licence

GPL v2 or later

## Auteur

Développé par Flowt - Agence Data et IA
https://www.flowt.fr
