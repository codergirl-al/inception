#!/bin/bash

create_sql_file() {
	cat << EOF > bootstrap.sql
	FLUSH PRIVILEGES;
	CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
	FLUSH PRIVILEGES;
EOF
}


run_bootstrap() {
	echo "hello world"
	mysqld --user=mysql --bootstrap < bootstrap.sql
	rm -f bootstrap.sql
}

if [ ! -d "var/lib/mysql/${MYSQL_DATABASE}" ]; then
	create_sql_file
	run_bootstrap
fi

exec /usr/sbin/mysqld --datadir=/var/lib/mysql --user=mysql