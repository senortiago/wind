<?php
/*
 * MySQL compatibility shim for PHP 8.x
 * Provides legacy mysql_* functions using mysqli
 */

$GLOBALS['__mysqli_link'] = null;

function mysql_connect($server, $user, $password, $new_link = false) {
    // Support "host:/path/to/socket" format
    $host = $server;
    $socket = null;
    if (strpos($server, ':/') !== false) {
        $parts = explode(':', $server, 2);
        $host = $parts[0] ?: 'localhost';
        $socket = $parts[1];
    }
    $link = new mysqli($host, $user, $password, '', 0, $socket);
    if ($link->connect_errno) {
        return false;
    }
    $link->set_charset('utf8');
    $GLOBALS['__mysqli_link'] = $link;
    return $link;
}

function mysql_select_db($database, $link = null) {
    $link = $link ?: $GLOBALS['__mysqli_link'];
    return $link->select_db($database);
}

function mysql_query($query, $link = null) {
    $link = $link ?: $GLOBALS['__mysqli_link'];
    $result = $link->query($query);
    return $result;
}

function mysql_fetch_assoc($result) {
    if ($result === true || $result === false) return false;
    return $result->fetch_assoc();
}

function mysql_fetch_array($result, $type = MYSQLI_BOTH) {
    if ($result === true || $result === false) return false;
    return $result->fetch_array($type);
}

function mysql_fetch_row($result) {
    if ($result === true || $result === false) return false;
    return $result->fetch_row();
}

function mysql_num_rows($result) {
    if ($result === true || $result === false) return 0;
    return $result->num_rows;
}

function mysql_affected_rows($link = null) {
    $link = $link ?: $GLOBALS['__mysqli_link'];
    return $link->affected_rows;
}

function mysql_insert_id($link = null) {
    $link = $link ?: $GLOBALS['__mysqli_link'];
    return $link->insert_id;
}

function mysql_free_result($result) {
    if ($result && $result !== true && $result !== false) {
        $result->free();
    }
    return true;
}

function mysql_close($link = null) {
    $link = $link ?: $GLOBALS['__mysqli_link'];
    return $link->close();
}

function mysql_errno($link = null) {
    $link = $link ?: $GLOBALS['__mysqli_link'];
    if (!$link) return 0;
    return $link->errno;
}

function mysql_error($link = null) {
    $link = $link ?: $GLOBALS['__mysqli_link'];
    if (!$link) return '';
    return $link->error;
}

function mysql_real_escape_string($string, $link = null) {
    $link = $link ?: $GLOBALS['__mysqli_link'];
    return $link->real_escape_string($string);
}

function mysql_result($result, $row, $field = 0) {
    if ($result === true || $result === false) return false;
    $result->data_seek($row);
    $row_data = $result->fetch_array();
    if (is_numeric($field)) {
        return $row_data[$field];
    }
    return $row_data[$field];
}

function mysql_num_fields($result) {
    if ($result === true || $result === false) return 0;
    return $result->field_count;
}

function mysql_fetch_field($result) {
    if ($result === true || $result === false) return false;
    return $result->fetch_field();
}

if (!defined('MYSQL_NUM')) define('MYSQL_NUM', MYSQLI_NUM);
if (!defined('MYSQL_ASSOC')) define('MYSQL_ASSOC', MYSQLI_ASSOC);
if (!defined('MYSQL_BOTH')) define('MYSQL_BOTH', MYSQLI_BOTH);
