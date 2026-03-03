# Architecture du Plugin - ShareToAI

## Structure des fichiers

```
sharetoai/
├── sharetoai.php              # Fichier principal du plugin
├── uninstall.php             # Script de désinstallation
├── .gitignore                # Fichiers à ignorer par Git
├── README.md                 # Documentation principale
├── INSTALLATION.md           # Guide d'installation
├── SECURITY-TESTS.md         # Tests de sécurité
├── ARCHITECTURE.md           # Ce fichier
└── assets/
    ├── css/
    │   ├── frontend.css      # Styles frontend
    │   └── admin.css         # Styles admin
    ├── js/
    │   ├── frontend.js       # Scripts frontend
    │   └── admin.js          # Scripts admin
    └── images/
        ├── perplexity.svg    # Icône Perplexity
        ├── chatgpt.svg       # Icône ChatGPT
        ├── claude.svg        # Icône Claude
        ├── grok.svg          # Icône Grok
        └── mistral.svg       # Icône Mistral
```

## Classe principale : ShareToAI

### Pattern Singleton
Le plugin utilise le pattern Singleton pour garantir une seule instance de la classe.

```php
private static $instance = null;
public static function get_instance()
```

### Hooks WordPress

#### Actions
- `plugins_loaded` → Chargement de la traduction
- `wp_enqueue_scripts` → Chargement des assets frontend
- `admin_enqueue_scripts` → Chargement des assets admin
- `admin_menu` → Ajout du menu d'administration
- `admin_init` → Enregistrement des paramètres

#### Filtres
- `the_content` (priorité 999) → Injection des liens IA

#### Shortcodes
- `[sharetoai]` → Affichage manuel

### Méthodes principales

#### Configuration
- `register_settings()` : Enregistre les paramètres du plugin
- `sanitize_options()` : Valide et nettoie les options
- `get_default_options()` : Retourne les options par défaut

#### Affichage
- `add_ai_links_to_content()` : Ajoute les liens au contenu
- `generate_ai_links()` : Génère le HTML des liens
- `shortcode_handler()` : Gère le shortcode

#### Administration
- `render_admin_page()` : Affiche la page de configuration
- `*_field_callback()` : Callbacks pour chaque champ de formulaire

#### Utilitaires
- `get_ai_services()` : Retourne la liste des services IA
- `enqueue_frontend_assets()` : Charge CSS/JS frontend
- `enqueue_admin_assets()` : Charge CSS/JS admin

## Flux de données

### 1. Affichage automatique
```
Article WordPress
    ↓
Filtre the_content (priorité 999)
    ↓
Vérifications (enabled, singular, post_type)
    ↓
generate_ai_links()
    ↓
Récupération URL courante (get_permalink)
    ↓
Remplacement {URL} dans le prompt
    ↓
Encodage URL (urlencode)
    ↓
Génération HTML avec échappement
    ↓
Injection dans le contenu (top/bottom/both)
```

### 2. Shortcode
```
[ai_summary_links] dans le contenu
    ↓
shortcode_handler()
    ↓
generate_ai_links()
    ↓
Retour du HTML
```

### 3. Configuration admin
```
Formulaire de configuration
    ↓
settings_fields() (nonce automatique)
    ↓
Soumission du formulaire
    ↓
sanitize_options()
    ↓
Validation et nettoyage
    ↓
update_option('aisl_options')
```

## Sécurité

### Validation des entrées
- `sanitize_text_field()` : Champs texte simples
- `sanitize_textarea_field()` : Champs textarea
- `array_map('sanitize_text_field')` : Tableaux

### Échappement des sorties
- `esc_html()` : Texte HTML
- `esc_attr()` : Attributs HTML
- `esc_url()` : URLs
- `esc_textarea()` : Contenu textarea

### Vérifications
- `current_user_can('manage_options')` : Capacités utilisateur
- `!defined('ABSPATH')` : Protection inclusion directe
- `is_singular()` : Évite l'affichage sur les archives

## Options enregistrées

```php
'sharetoai_options' => [
    'enabled' => 1,                    // Activation
    'position' => 'bottom',            // Position (top/bottom/both/manual)
    'post_types' => ['post'],          // Types de contenu
    'custom_text' => 'Résumer...',     // Texte personnalisé
    'custom_prompt' => '...',          // Prompt personnalisé
    'ai_services' => [...],            // Services activés
    'display_style' => 'icons'         // Style (icons/buttons/list)
]
```

## Services IA supportés

Chaque service est défini avec :
- `name` : Nom affiché
- `url` : URL avec placeholder {PROMPT}
- `icon` : Fichier SVG

```php
[
    'perplexity' => [...],
    'chatgpt' => [...],
    'claude' => [...],
    'grok' => [...],
    'mistral' => [...]
]
```

## Styles CSS

### Frontend
- `.sharetoai-container` : Conteneur principal
- `.sharetoai-text` : Texte d'invitation
- `.sharetoai-links` : Conteneur des liens
- `.sharetoai-link` : Lien individuel
- `.sharetoai-icon` : Icône
- `.sharetoai-style-*` : Variantes de style

### Responsive
- Media query à 768px pour mobile
- Ajustement des tailles et espacements

## JavaScript

### Frontend
- Tracking des clics (Google Analytics)
- Event listener sur `.sharetoai-link`

### Admin
- Support WP Color Picker (prévu pour futures extensions)

## Hooks d'activation/désactivation

### Activation
```php
add_option('sharetoai_options', $default_options)
```

### Désactivation
- Aucune action (conservation des données)

### Désinstallation (uninstall.php)
```php
delete_option('sharetoai_options')
delete_site_option('sharetoai_options') // Multisite
```

## Extensibilité

Le plugin peut être étendu via :
- Filtres WordPress sur `the_content`
- Ajout de nouveaux services dans `get_ai_services()`
- Personnalisation CSS via le thème enfant
- Hooks personnalisés (à ajouter si besoin)

## Performance

### Optimisations
- Chargement conditionnel des assets admin
- Vérification `is_singular()` pour éviter le traitement inutile
- Singleton pour éviter les instances multiples
- Mise en cache des options via `get_option()`

### Impact
- Minimal : 1 requête BDD pour les options
- Pas de requêtes externes
- CSS/JS légers (<10KB total)

## Compatibilité

### WordPress
- Version minimale : 5.0
- Multisite : Compatible
- Builders : Compatible (Elementor, Divi, etc.)

### PHP
- Version minimale : 7.4
- Pas de dépendances externes

### Thèmes
- Compatible avec tous les thèmes
- Utilise les hooks standards WordPress
