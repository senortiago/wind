# WiND - Wireless Nodes Database

## Project Overview
WiND is a PHP web application for managing Wireless Community Networks. Originally created by the Athens Wireless Metropolitan Network (AWMN) as a replacement for NodeDB.

## Tech Stack
- **Language**: PHP 8.2
- **Database**: MySQL 8.0 (started via startup script)
- **Template Engine**: Smarty 2.x (installed via Composer)
- **Frontend**: jQuery, Bootstrap, OpenLayers maps
- **Web Server**: PHP built-in server (port 5000)

## Project Structure
- `index.php` - Main entry point
- `globals/` - Core system logic and classes
  - `mysql_compat.php` - **Custom PHP 8 compatibility shim** for legacy mysql_* functions
  - `common.php` - Initialization (loads config, DB, Smarty)
  - `classes/` - Database, form, table, user classes
  - `functions.php` - Global utility functions
- `includes/` - Page-level logic and layout components
- `templates/basic/` - Smarty templates and static assets
- `config/config.php` - Application configuration (DB credentials, paths, etc.)
- `vendor/` - Composer dependencies (Smarty 2.x)
- `start.sh` - Startup script that launches MySQL + PHP server
- `router.php` - PHP built-in server routing script

## Key Setup Notes

### PHP 8 Compatibility Fixes Applied
1. **`globals/mysql_compat.php`** - Shimmed all `mysql_*` functions with `mysqli`
2. Fixed `each()` removal - replaced with `foreach()` in mysql.php, form.php, table.php
3. Fixed curly brace string/array access `$str{$i}` → `$str[$i]`
4. Fixed `${var}` in strings → `{$var}` 
5. Fixed old-style constructors (method same name as class) → `__construct()`
6. Fixed `mb_ereg()` → `preg_match()`
7. Error reporting set to suppress deprecated/warnings from Smarty 2.x

### MySQL Configuration
- MySQL data: `/home/runner/mysql-data/`
- MySQL socket: `/home/runner/mysql-run/mysqld.sock`
- Database: `wind`
- User: `wind` / Password: `windpass`
- Schema backup: `/home/runner/workspace_install_backup/schema.sql`
- MySQL 8 strict mode disabled with `--sql-mode=NO_ENGINE_SUBSTITUTION` to allow legacy `0000-00-00 00:00:00` datetime defaults

### Default Admin Credentials
- Username: `admin`
- Password: `admin123`

### Install Directory
The `install/` directory was moved to `/home/runner/workspace_install_backup/` to allow the app to run (it checks for the presence of `install/` directory and refuses to start if found).

## Workflow
- **Start application**: `bash /home/runner/workspace/start.sh`
  - Starts MySQL daemon
  - Creates database/user if needed
  - Imports schema if not yet imported
  - Creates default admin user if no users exist
  - Starts PHP built-in server on port 5000

## Dependencies
- PHP 8.2 (with mysqli, gd, mbstring extensions)
- MySQL 8.0 (installed via Nix: `mysql80`)
- Smarty 2.x (installed via Composer: `smarty/smarty:~2.6`)
