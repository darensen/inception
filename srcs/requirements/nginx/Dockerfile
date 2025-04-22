FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt install -y nginx

RUN mkdir -p /run/nginx

RUN mkdir -p /etc/nginx/ssl

RUN apt install -y openssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/dsenatus.42.fr.crt -keyout /etc/nginx/ssl/dsenatus.42.fr.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=dsenatus.42.fr/UID=dsenatus"

COPY default ./etc/nginx/sites-available/

CMD ["nginx", "-g", "daemon off;"]
