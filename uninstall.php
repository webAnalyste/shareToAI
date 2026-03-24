<?php
if (!defined('WP_UNINSTALL_PLUGIN')) {
    exit;
}

delete_option('posttoai_options');

delete_site_option('posttoai_options');
