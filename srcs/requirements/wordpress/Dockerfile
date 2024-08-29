FROM debian:buster

RUN apt update && apt install -y php-fpm php-mysql curl && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf && \
	mkdir -p /run/php /var/www /var/log/php

COPY ./tools/init_wordpress.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 9000

CMD ["/usr/local/bin/startup.sh"]