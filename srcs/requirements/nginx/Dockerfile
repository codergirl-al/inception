FROM debian:buster

RUN apt -y update && apt -y upgrade && apt -y install nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=DE/ST=Baden Wurttemberg/L=Heilbronn/O=42/OU=42/CN=apeposhi.42.fr"

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# CMD ["nginx", "-g", "daemon off;"]

CMD [ "tail", "-f", "/dev/null" ]