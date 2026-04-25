<?php
if (!defined('WP_UNINSTALL_PLUGIN')) {
    exit;
}

delete_option('expansai_ptai_options');

delete_site_option('expansai_ptai_options');
