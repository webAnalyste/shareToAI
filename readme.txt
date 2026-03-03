=== ShareToAI ===
Contributors: franckscan
Tags: ai, artificial intelligence, chatgpt, claude, perplexity, summary, content
Requires at least: 5.0
Tested up to: 6.9
Requires PHP: 7.4
Stable tag: 1.1.0
License: GPLv2 or later
License URI: https://www.gnu.org/licenses/gpl-2.0.html

Ajoutez automatiquement des liens vers différentes IA pour résumer le contenu de vos posts et Custom Post Types.

== Description ==

ShareToAI permet d'afficher automatiquement une invitation personnalisable "Résumer ce contenu avec :" suivie d'icônes cliquables vers différents services d'IA (Perplexity, ChatGPT, Claude, Grok, Mistral).

= Fonctionnalités principales =

* ✅ Affichage automatique en haut, en bas ou les deux
* ✅ Support des posts et Custom Post Types
* ✅ Shortcode `[sharetoai]` pour placement manuel
* ✅ Texte et prompt personnalisables
* ✅ Choix des services IA à afficher
* ✅ 3 styles d'affichage : icônes, boutons, liste
* ✅ Responsive et accessible
* ✅ Sécurisé selon les standards WordPress
* ✅ Traçabilité des clics (compatible Google Analytics)

= Services IA supportés =

* Perplexity
* ChatGPT
* Claude
* Grok
* Mistral

= Utilisation =

1. Activez le plugin
2. Allez dans Réglages > ShareToAI
3. Configurez vos préférences
4. Les liens IA apparaîtront automatiquement sur vos articles

Vous pouvez aussi utiliser le shortcode `[sharetoai]` pour un placement manuel dans vos contenus.

== Installation ==

= Installation automatique =

1. Allez dans Extensions > Ajouter
2. Recherchez "ShareToAI"
3. Cliquez sur Installer puis Activer

= Installation manuelle =

1. Téléchargez le fichier ZIP du plugin
2. Allez dans Extensions > Ajouter > Téléverser une extension
3. Sélectionnez le fichier ZIP
4. Cliquez sur Installer maintenant puis Activer

= Installation via GitHub =

1. Téléchargez la dernière version depuis https://github.com/webAnalyste/shareToAI/releases
2. Décompressez le fichier dans `/wp-content/plugins/`
3. Activez le plugin dans Extensions > Extensions installées

== Frequently Asked Questions ==

= Comment personnaliser le texte d'invitation ? =

Allez dans Réglages > ShareToAI et modifiez le champ "Texte personnalisé".

= Comment choisir quels services IA afficher ? =

Dans Réglages > ShareToAI, cochez/décochez les services dans la section "Services IA activés".

= Le shortcode fonctionne-t-il dans les widgets ? =

Oui, le shortcode `[sharetoai]` fonctionne dans les articles, pages, widgets texte et templates PHP.

= Le plugin est-il compatible avec les page builders ? =

Oui, ShareToAI est compatible avec Elementor, Divi, Gutenberg et tous les page builders majeurs.

= Comment désactiver le plugin sur certains articles ? =

Réglez la position sur "Manuel" dans les paramètres, puis utilisez le shortcode uniquement où vous le souhaitez.

= Le plugin ralentit-il mon site ? =

Non, ShareToAI est très léger (<10KB total) et n'effectue aucune requête externe.

== Screenshots ==

1. Page de configuration du plugin dans Réglages > ShareToAI
2. Affichage des liens IA en style "Icônes" sur un article
3. Affichage en style "Boutons avec texte"
4. Affichage en style "Liste"
5. Personnalisation du prompt avec placeholder {URL}

== Changelog ==

= 1.1.0 - 2026-03-03 =
* Version optimisée pour WordPress.org
* Suppression du système de mise à jour personnalisé (WordPress.org gère nativement les mises à jour)
* Suppression de load_plugin_textdomain() (automatique depuis WP 4.6)
* Mise à jour compatibilité WordPress 6.9

= 1.0.3 - 2026-03-03 =
* Version de test pour le système de mise à jour automatique

= 1.0.2 - 2026-03-03 =
* Mise à jour des informations d'auteur : Franck Scandolera / webAnalyste
* Correction du prompt par défaut

= 1.0.1 - 2026-03-03 =
* Ajout de rel="nofollow" sur tous les liens IA (SEO)
* Correction du style des boutons (suppression du soulignement)
* Amélioration visuelle des boutons avec bordure

= 1.0.0 - 2026-03-03 =
* Version initiale
* Affichage automatique et shortcode
* 5 services IA supportés (Perplexity, ChatGPT, Claude, Grok, Mistral)
* 3 styles d'affichage (icônes, boutons, liste)
* Interface d'administration complète
* Personnalisation du texte et du prompt
* Support des Custom Post Types
* Responsive et accessible
* Sécurisé selon les standards WordPress

== Upgrade Notice ==

= 1.0.0 =
Version initiale du plugin ShareToAI.

== Support ==

Pour toute question ou problème :
* GitHub : https://github.com/webAnalyste/shareToAI/issues
* Site web : https://www.webanalyste.com

== Développement ==

Le code source est disponible sur GitHub : https://github.com/webAnalyste/shareToAI

Contributions bienvenues !
