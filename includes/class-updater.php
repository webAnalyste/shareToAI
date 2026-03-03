<?php
/**
 * ShareToAI Auto-Updater
 * 
 * Gère les mises à jour automatiques du plugin depuis GitHub
 * 
 * @package ShareToAI
 * @since 1.0.0
 */

if (!defined('ABSPATH')) {
    exit;
}

class ShareToAI_Updater {
    
    private $plugin_slug;
    private $plugin_file;
    private $version;
    private $github_repo;
    private $github_user;
    
    public function __construct($plugin_file, $github_user, $github_repo, $version) {
        $this->plugin_file = $plugin_file;
        $this->plugin_slug = plugin_basename($plugin_file);
        $this->version = $version;
        $this->github_user = $github_user;
        $this->github_repo = $github_repo;
        
        add_filter('pre_set_site_transient_update_plugins', array($this, 'check_update'));
        add_filter('plugins_api', array($this, 'plugin_info'), 20, 3);
        add_filter('upgrader_post_install', array($this, 'after_install'), 10, 3);
    }
    
    /**
     * Vérifie s'il y a une nouvelle version disponible
     */
    public function check_update($transient) {
        if (empty($transient->checked)) {
            return $transient;
        }
        
        $remote_version = $this->get_remote_version();
        
        if ($remote_version && version_compare($this->version, $remote_version, '<')) {
            $plugin_data = array(
                'slug' => dirname($this->plugin_slug),
                'plugin' => $this->plugin_slug,
                'new_version' => $remote_version,
                'url' => "https://github.com/{$this->github_user}/{$this->github_repo}",
                'package' => $this->get_download_url($remote_version),
                'tested' => '6.4',
                'requires_php' => '7.4',
            );
            
            $transient->response[$this->plugin_slug] = (object) $plugin_data;
        }
        
        return $transient;
    }
    
    /**
     * Récupère la version distante depuis GitHub
     */
    private function get_remote_version() {
        $transient_key = 'sharetoai_remote_version';
        $cached_version = get_transient($transient_key);
        
        if ($cached_version !== false) {
            return $cached_version;
        }
        
        $api_url = "https://api.github.com/repos/{$this->github_user}/{$this->github_repo}/releases/latest";
        
        $response = wp_remote_get($api_url, array(
            'timeout' => 10,
            'headers' => array(
                'Accept' => 'application/vnd.github.v3+json',
            ),
        ));
        
        if (is_wp_error($response)) {
            return false;
        }
        
        $body = wp_remote_retrieve_body($response);
        $data = json_decode($body);
        
        if (!empty($data->tag_name)) {
            $version = ltrim($data->tag_name, 'v');
            set_transient($transient_key, $version, 6 * HOUR_IN_SECONDS);
            return $version;
        }
        
        return false;
    }
    
    /**
     * Récupère l'URL de téléchargement du ZIP
     */
    private function get_download_url($version) {
        return "https://github.com/{$this->github_user}/{$this->github_repo}/releases/download/v{$version}/sharetoai-{$version}.zip";
    }
    
    /**
     * Fournit les informations du plugin pour la popup de mise à jour
     */
    public function plugin_info($false, $action, $response) {
        if ($action !== 'plugin_information') {
            return $false;
        }
        
        if (empty($response->slug) || $response->slug !== dirname($this->plugin_slug)) {
            return $false;
        }
        
        $remote_version = $this->get_remote_version();
        $changelog = $this->get_changelog();
        
        $plugin_info = new stdClass();
        $plugin_info->name = 'ShareToAI';
        $plugin_info->slug = dirname($this->plugin_slug);
        $plugin_info->version = $remote_version;
        $plugin_info->author = '<a href="https://www.flowt.fr">Flowt</a>';
        $plugin_info->homepage = "https://github.com/{$this->github_user}/{$this->github_repo}";
        $plugin_info->download_link = $this->get_download_url($remote_version);
        $plugin_info->requires = '5.0';
        $plugin_info->tested = '6.4';
        $plugin_info->requires_php = '7.4';
        $plugin_info->last_updated = date('Y-m-d');
        $plugin_info->sections = array(
            'description' => 'Plugin WordPress qui ajoute automatiquement des liens vers différentes IA pour résumer le contenu de vos posts et Custom Post Types.',
            'changelog' => $changelog,
        );
        
        return $plugin_info;
    }
    
    /**
     * Récupère le changelog depuis GitHub
     */
    private function get_changelog() {
        $transient_key = 'sharetoai_changelog';
        $cached_changelog = get_transient($transient_key);
        
        if ($cached_changelog !== false) {
            return $cached_changelog;
        }
        
        $changelog_url = "https://raw.githubusercontent.com/{$this->github_user}/{$this->github_repo}/main/CHANGELOG.md";
        
        $response = wp_remote_get($changelog_url, array('timeout' => 10));
        
        if (is_wp_error($response)) {
            return 'Voir le changelog sur GitHub';
        }
        
        $changelog = wp_remote_retrieve_body($response);
        
        // Convertir le Markdown en HTML basique
        $changelog = $this->markdown_to_html($changelog);
        
        set_transient($transient_key, $changelog, 12 * HOUR_IN_SECONDS);
        
        return $changelog;
    }
    
    /**
     * Conversion basique Markdown vers HTML
     */
    private function markdown_to_html($markdown) {
        // Titres
        $markdown = preg_replace('/^### (.+)$/m', '<h3>$1</h3>', $markdown);
        $markdown = preg_replace('/^## (.+)$/m', '<h2>$1</h2>', $markdown);
        $markdown = preg_replace('/^# (.+)$/m', '<h1>$1</h1>', $markdown);
        
        // Listes
        $markdown = preg_replace('/^- (.+)$/m', '<li>$1</li>', $markdown);
        $markdown = preg_replace('/(<li>.*<\/li>)/s', '<ul>$1</ul>', $markdown);
        
        // Liens
        $markdown = preg_replace('/\[([^\]]+)\]\(([^\)]+)\)/', '<a href="$2">$1</a>', $markdown);
        
        // Gras
        $markdown = preg_replace('/\*\*(.+?)\*\*/', '<strong>$1</strong>', $markdown);
        
        // Paragraphes
        $markdown = '<p>' . preg_replace('/\n\n/', '</p><p>', $markdown) . '</p>';
        
        return $markdown;
    }
    
    /**
     * Après l'installation, renommer le dossier correctement
     */
    public function after_install($response, $hook_extra, $result) {
        global $wp_filesystem;
        
        $plugin_folder = WP_PLUGIN_DIR . '/' . dirname($this->plugin_slug);
        $wp_filesystem->move($result['destination'], $plugin_folder);
        $result['destination'] = $plugin_folder;
        
        // Réactiver le plugin si nécessaire
        if ($this->is_plugin_active()) {
            activate_plugin($this->plugin_slug);
        }
        
        return $result;
    }
    
    /**
     * Vérifie si le plugin est actif
     */
    private function is_plugin_active() {
        return is_plugin_active($this->plugin_slug);
    }
}
