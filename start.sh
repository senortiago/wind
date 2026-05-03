#!/bin/bash
set -e

MYSQL_DATA=/home/runner/mysql-data
MYSQL_RUN=/home/runner/mysql-run
MYSQL_SOCK=$MYSQL_RUN/mysqld.sock

mkdir -p "$MYSQL_DATA" "$MYSQL_RUN"

# Initialize MySQL data directory if needed
if [ ! -d "$MYSQL_DATA/mysql" ]; then
    echo "Initializing MySQL data directory..."
    mysqld --initialize-insecure --datadir="$MYSQL_DATA" --user=runner 2>&1
fi

# Kill any stale MySQL processes
pkill -9 mysqld 2>/dev/null || true
sleep 1
rm -f "$MYSQL_SOCK" "$MYSQL_RUN/mysqld.sock.lock" "$MYSQL_RUN/mysqld.pid"

# Start MySQL
echo "Starting MySQL..."
mysqld --datadir="$MYSQL_DATA" \
    --socket="$MYSQL_SOCK" \
    --pid-file="$MYSQL_RUN/mysqld.pid" \
    --user=runner \
    --port=3306 \
    --mysqlx=OFF \
    --sql-mode="NO_ENGINE_SUBSTITUTION" \
    --daemonize=ON 2>&1

# Wait for MySQL to be ready
echo "Waiting for MySQL..."
for i in $(seq 1 30); do
    if mysql -u root --socket="$MYSQL_SOCK" -e "SELECT 1;" > /dev/null 2>&1; then
        echo "MySQL is ready"
        break
    fi
    sleep 1
done

# Setup database and user
mysql -u root --socket="$MYSQL_SOCK" <<'EOSQL' 2>/dev/null || true
CREATE DATABASE IF NOT EXISTS wind CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS 'wind'@'localhost' IDENTIFIED BY 'windpass';
GRANT ALL PRIVILEGES ON wind.* TO 'wind'@'localhost';
FLUSH PRIVILEGES;
EOSQL

# Import schema if tables don't exist
TABLE_COUNT=$(mysql -u root --socket="$MYSQL_SOCK" wind -e "SHOW TABLES;" 2>/dev/null | wc -l)
if [ "$TABLE_COUNT" -lt 2 ]; then
    echo "Importing schema..."
    # Fix MySQL 8 strict mode: disable NO_ZERO_DATE for schema import
    mysql -u root --socket="$MYSQL_SOCK" wind -e "SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';" 2>/dev/null
    mysql -u root --socket="$MYSQL_SOCK" wind --init-command="SET SESSION sql_mode='NO_ENGINE_SUBSTITUTION';" < /home/runner/workspace_install_backup/schema.sql 2>&1
    mysql -u root --socket="$MYSQL_SOCK" wind -e "INSERT IGNORE INTO \`update_log\` (version_major, version_minor) VALUES(1,1);" 2>/dev/null
    echo "Schema imported"
fi

# Create admin user if no users exist
USER_COUNT=$(mysql -u root --socket="$MYSQL_SOCK" wind -e "SELECT COUNT(*) FROM users;" 2>/dev/null | tail -1)
if [ "$USER_COUNT" = "0" ]; then
    echo "Creating default admin user..."
    mysql -u root --socket="$MYSQL_SOCK" wind <<'EOSQL' 2>/dev/null
INSERT INTO users (username, password, name, surname, email, date_in, status)
VALUES ('admin', MD5('admin123'), 'Admin', 'User', 'admin@example.com', NOW(), 'activated');
SET @userid = LAST_INSERT_ID();
INSERT INTO rights (user_id, type) VALUES (@userid, 'admin'), (@userid, 'hostmaster');
EOSQL
    echo "Admin user created (username: admin, password: admin123)"
fi

echo "Starting PHP web server on port 5000..."
exec php -S 0.0.0.0:5000 -t /home/runner/workspace /home/runner/workspace/router.php
