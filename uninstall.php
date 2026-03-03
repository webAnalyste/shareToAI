<?php
if (!defined('WP_UNINSTALL_PLUGIN')) {
    exit;
}

delete_option('sharetoai_options');

delete_site_option('sharetoai_options');
