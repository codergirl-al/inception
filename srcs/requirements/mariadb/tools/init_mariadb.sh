#!/bin/bash

sql_settings() {
	cat << EOF > bootstrap.sql
	FLUSH PRIVILEGES;
	CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
	FLUSH PRIVILEGES;
EOF
}

bootstrap_start() {
	mysqld --user=mysql --bootstrap < bootstrap.sql
	rm -f bootstrap.sql
}

if [ ! -d "var/lib/mysql/${MYSQL_DATABASE}" ]; then
	sql_settings
	bootstrap_start
fi

exec /usr/sbin/mysqld --datadir=/var/lib/mysql --user=mysql
