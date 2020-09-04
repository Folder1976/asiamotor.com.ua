<?php
// Version
define('VERSION', '2.3.0.0');

// Configuration
if (is_file('../admin/config.php')) {
    require_once('../admin/config.php');
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

$application_config = 'admin';

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$config->load('default');
$config->load($application_config);
$registry->set('config', $config);

// Request
$registry->set('request', new Request());

// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$registry->set('response', $response);

// Database
if ($config->get('db_autostart')) {
    $registry->set('db', new DB($config->get('db_type'), $config->get('db_hostname'), $config->get('db_username'), $config->get('db_password'), $config->get('db_database'), $config->get('db_port')));
}

// Session
if ($config->get('session_autostart')) {
    $session = new Session();
    $session->start();
    $registry->set('session', $session);
}

$config->set('config_url', HTTP_CATALOG);
$config->set('config_ssl', HTTPS_CATALOG);

// Cache
$registry->set('cache', new Cache($config->get('cache_type'), $config->get('cache_expire')));

// Url
$registry->set('url', new Url($config->get('site_ssl')));

// Language
$language = new Language($config->get('language_default'));
$language->load($config->get('language_default'));
$registry->set('language', $language);

// Document
$registry->set('document', new Document());

// Event
$event = new Event($registry);
$registry->set('event', $event);

// Event Register
if ($config->has('action_event')) {
    foreach ($config->get('action_event') as $key => $value) {
        $event->register($key, new Action($value));
    }
}

// Config Autoload
if ($config->has('config_autoload')) {
    foreach ($config->get('config_autoload') as $value) {
        $loader->config($value);
    }
}

// Language Autoload
if ($config->has('language_autoload')) {
    foreach ($config->get('language_autoload') as $value) {
        $loader->language($value);
    }
}

// Library Autoload
if ($config->has('library_autoload')) {
    foreach ($config->get('library_autoload') as $value) {
        $loader->library($value);
    }
}

// Model Autoload
if ($config->has('model_autoload')) {
    foreach ($config->get('model_autoload') as $value) {
        $loader->model($value);
    }
}

// Front Controller
$controller = new Front($registry);

// Pre Actions
if ($config->has('action_pre_action')) {
    foreach ($config->get('action_pre_action') as $value) {
        if ($value != "startup/login") {
            $controller->addPreAction(new Action($value));
        }
    }
}

// Проверка IP-адреса
$ipList = $config->get("neoseo_exchange1c_ip_list");
if (trim($ipList) != "") {
    $found = false;
    foreach (explode("\n", $ipList) as $ip) {
        if (trim($ip) == $_SERVER['REMOTE_ADDR']) {
            $found = true;
            break;
        }
    }
    if (!$found) {
        file_put_contents(DIR_LOGS . "neoseo_exchange1c.log", date("Y-m-d H:i:s - ") . " доступ заблокирован клиенту с адресом " . $_SERVER['REMOTE_ADDR'] . "\r\n", FILE_APPEND);
        echo "Access Denied";
        exit;
    }
}

// Router
$request = $registry->get('request');
if (isset($request->get['mode']) && $request->get['type'] == 'catalog') {

    switch ($request->get['mode']) {
        case 'checkauth':
            $action = new Action('tool/neoseo_exchange1c/modeCheckauth');
            break;

        case 'init':
            $action = new Action('tool/neoseo_exchange1c/modeCatalogInit');
            break;

        case 'file':
            $action = new Action('tool/neoseo_exchange1c/modeFile');
            break;

        case 'import':
            $action = new Action('tool/neoseo_exchange1c/modeImport');
            break;

        case 'export':
            $action = new Action('tool/neoseo_exchange1c/modeExport');
            break;

        case 'exportall':
            $action = new Action('tool/neoseo_exchange1c/modeExportAll');
            break;

        default:
            echo "success\n";
    }

} else if (isset($request->get['mode']) && $request->get['type'] == 'sale') {

    switch ($request->get['mode']) {
        case 'checkauth':
            $action = new Action('tool/neoseo_exchange1c/modeCheckauth');
            break;

        case 'init':
            $action = new Action('tool/neoseo_exchange1c/modeSaleInit');
            break;

        case 'file':
            $action = new Action('tool/neoseo_exchange1c/modeFile');
            break;

        case 'import':
            $action = new Action('tool/neoseo_exchange1c/modeImport');
            break;

        case 'query':
            $action = new Action('tool/neoseo_exchange1c/modeQueryOrders');
            break;

        default:
            echo "success\n";
    }

} else {
    echo "success\n";
    exit;
}

// Dispatch
if (isset($action)) {
    //header('Content-Type: text/html; charset=utf-8', true);
    $controller->dispatch($action, new Action('action_error'));
}

// Dispatch
//$controller->dispatch(new Action($config->get('action_router')), new Action($config->get('action_error')));

// Output
$response->setCompression($config->get('config_compression'));
$response->output();