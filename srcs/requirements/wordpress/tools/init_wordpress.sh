#!/bin/bash

cd /var/www/html

rm -rf *

wp core download --allow-root

wp config create --allow-root --force \
		--url="$WORDPRESS_URL" \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost="mariadb:3306"


wp core install --allow-root --url="$WORDPRESS_URL" \
		--title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN_NAME" \
		--admin_password="$WORDPRESS_ADMIN_PASS" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" \
		--skip-email

wp user create --allow-root $WORDPRESS_USER_NAME \
		$WORDPRESS_USER_EMAIL \
		--user_pass="$WORDPRESS_USER_PASSWORD"

php-fpm7.3 -F