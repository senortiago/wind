<?php
// PHP built-in server router
$uri = urldecode(parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));

// Case 1: URI is an absolute filesystem path (e.g. /home/runner/workspace/templates/...)
// This happens because surl() builds URLs from absolute paths on this server setup.
if (file_exists($uri) && !is_dir($uri)) {
    $ext = strtolower(pathinfo($uri, PATHINFO_EXTENSION));
    $mimes = [
        'css'  => 'text/css',
        'js'   => 'application/javascript',
        'png'  => 'image/png',
        'gif'  => 'image/gif',
        'jpg'  => 'image/jpeg',
        'jpeg' => 'image/jpeg',
        'svg'  => 'image/svg+xml',
        'ico'  => 'image/x-icon',
        'woff' => 'font/woff',
        'woff2'=> 'font/woff2',
        'ttf'  => 'font/ttf',
        'eot'  => 'application/vnd.ms-fontobject',
        'map'  => 'application/json',
        'json' => 'application/json',
        'txt'  => 'text/plain',
        'html' => 'text/html',
    ];
    $mime = isset($mimes[$ext]) ? $mimes[$ext] : 'application/octet-stream';
    header('Content-Type: ' . $mime);
    readfile($uri);
    return true;
}

// Case 2: URI matches a file relative to the project root
if ($uri !== '/' && file_exists(__DIR__ . $uri) && !is_dir(__DIR__ . $uri)) {
    return false;
}

// Route all other requests to index.php
$_SERVER['SCRIPT_NAME'] = '/index.php';
require_once __DIR__ . '/index.php';
