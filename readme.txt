=== Fscan - Post to AI ===
Contributors: fscan
Tags: ai, chatgpt, claude, perplexity, summary
Requires at least: 5.0
Tested up to: 6.9
Requires PHP: 7.4
Stable tag: 1.0.7
License: GPLv2 or later
License URI: https://www.gnu.org/licenses/gpl-2.0.html

Automatically add links to various AI services to summarize your posts and Custom Post Types content.

== Description ==

Fscan - Post to AI automatically displays a customizable invitation "Summarize this content with:" followed by clickable icons to various AI services (Perplexity, ChatGPT, Claude, Grok, Mistral).

= Key Features =

* ✅ Automatic display at top, bottom, or both
* ✅ Support for posts and Custom Post Types
* ✅ Shortcode `[expansai-post-to-ai]` for manual placement
* ✅ Customizable text and prompt
* ✅ Choose which AI services to display
* ✅ 3 display styles: icons, buttons, list
* ✅ Responsive and accessible
* ✅ Secure according to WordPress standards
* ✅ Click tracking (Google Analytics compatible)

= Supported AI Services =

* Perplexity
* ChatGPT
* Claude
* Grok
* Mistral

= Usage =

1. Activate the plugin
2. Go to Settings > Fscan - Post to AI
3. Configure your preferences
4. AI links will automatically appear on your posts

You can also use the shortcode `[expansai-post-to-ai]` for manual placement in your content.

= About the Author =

I'm **Franck Scandolera** ([franckscandolera.com](https://franckscandolera.com/)), founder of **[webAnalyste](https://www.webanalyste.com)** - an agency specialized in Data structuring, AI integration, workflow automation (n8n/Make/Python/Apps Script), and digital performance optimization. I also manage **[Formations Analytics](https://www.formations-analytics.com)**, a Qualiopi-certified training organization focused on Analytics, Data, AI, and Automation.

---

**[Version Française]**

Fscan - Post to AI affiche automatiquement une invitation personnalisable "Résumer ce contenu avec :" suivie d'icônes cliquables vers différents services d'IA (Perplexity, ChatGPT, Claude, Grok, Mistral).

**Fonctionnalités :**
* Affichage automatique en haut, en bas ou les deux
* Support des posts et Custom Post Types
* Shortcode `[expansai-post-to-ai]` pour placement manuel
* Texte et prompt personnalisables
* 3 styles d'affichage : icônes, boutons, liste

**À propos de l'auteur :**
Je suis **Franck Scandolera** ([franckscandolera.com](https://franckscandolera.com/)), responsable de l'agence **[webAnalyste](https://www.webanalyste.com)** - une agence experte dans la structuration de la Data, l'intégration de l'IA, l'automatisation des activités (n8n/Make/Python/Apps Script) et l'optimisation de la performance digitale. Je gère également l'organisme de formation certifié Qualiopi **[Formations Analytics](https://www.formations-analytics.com)**.

== Installation ==

= Automatic Installation =

1. Go to Plugins > Add New
2. Search for "Fscan - Post to AI"
3. Click Install then Activate

= Manual Installation =

1. Download the plugin ZIP file
2. Go to Plugins > Add New > Upload Plugin
3. Select the ZIP file
4. Click Install Now then Activate

== Frequently Asked Questions ==

= How to customize the invitation text? =

Go to Settings > Fscan - Post to AI and modify the "Custom Text" field.

= How to choose which AI services to display? =

In Settings > Fscan - Post to AI, check/uncheck services in the "Enabled AI Services" section.

= Does the shortcode work in widgets? =

Yes, the shortcode `[expansai-post-to-ai]` works in posts, pages, text widgets, and PHP templates.

= Is the plugin compatible with page builders? =

Yes, Fscan - Post to AI is compatible with Elementor, Divi, Gutenberg, and all major page builders.

= How to disable the plugin on specific posts? =

Set the position to "Manual" in settings, then use the shortcode only where you want.

= Does the plugin slow down my site? =

No, Fscan - Post to AI is very lightweight (<10KB total) and makes no external requests.

= What placeholders can I use in the custom prompt? =

You can use the following placeholders to personalize your AI prompt:
* `{URL}` - The full URL of the current post
* `{DOMAIN}` - Your website domain (e.g., example.com)
* `{SITE_NAME}` - Your website name
* `{TITLE}` - The post title
* `{AUTHOR}` - The post author name
* `{DATE}` - The post publication date
* `{EXCERPT}` - A short excerpt of the post (30 words)

Example: "Summarize this article titled '{TITLE}' by {AUTHOR} from {DOMAIN}: {URL}"

== Screenshots ==

1. Plugin settings page in Settings > Fscan - Post to AI
2. AI links display in "Icons" style on a post
3. Display in "Buttons with text" style
4. Display in "List" style
5. Prompt customization with {URL} placeholder

== Changelog ==

= 1.0.7 - 2026-04-26 =
* Fix: Default texts now in French (simple and effective)
* Removed unnecessary migration system

= 1.0.6 - 2026-04-26 =
* Feature: 7 placeholders available ({URL}, {DOMAIN}, {SITE_NAME}, {TITLE}, {AUTHOR}, {DATE}, {EXCERPT})
* Fix: SVG icons now have proper dimensions (32x32px)
* Fix: Default texts are now properly translated based on WordPress language
* Fix: Automatic migration of existing settings to translated versions
* Improvement: Full internationalization (English by default + French translation)

= 1.0.5 - 2026-04-26 =
* Plugin name: Fscan - Post to AI
* WordPress.org slug: expansai-post-to-ai
* Shortcode: `[expansai-post-to-ai]`
* Updated text domain: expansai-post-to-ai

= 1.0.4 - 2026-03-24 =
* Plugin renamed to PostToAI
* Fixed naming inconsistencies (text domain, shortcode, CSS classes)

= 1.0.3 - 2026-03-03 =
* Test version for automatic update system

= 1.0.2 - 2026-03-03 =
* Updated author information: Franck Scandolera / webAnalyste
* Fixed default prompt

= 1.0.1 - 2026-03-03 =
* Added rel="nofollow" to all AI links (SEO)
* Fixed button style (removed underline)
* Visual improvement of buttons with border

= 1.0.0 - 2026-03-03 =
* Initial release
* Automatic display and shortcode
* 5 supported AI services (Perplexity, ChatGPT, Claude, Grok, Mistral)
* 3 display styles (icons, buttons, list)
* Complete admin interface
* Text and prompt customization
* Custom Post Types support
* Responsive and accessible
* Secure according to WordPress standards

== Upgrade Notice ==

= 1.0.6 =
Major update: 7 placeholders, fixed SVG sizes, automatic translation migration. Your settings will be automatically updated to match your WordPress language.

= 1.0.5 =
Plugin name: Fscan - Post to AI. Update your shortcodes: `[posttoai]` must be replaced with `[expansai-post-to-ai]`.

== Support ==

For any questions or issues:
* GitHub: https://github.com/webAnalyste/shareToAI/issues
* Website: https://www.webanalyste.com
* Author: https://franckscandolera.com

== Development ==

Source code is available on GitHub: https://github.com/webAnalyste/shareToAI

Contributions welcome!
