FROM debian:bullseye

RUN apt update -y && apt upgrade -y && \
    apt install -y curl gnupg && \
    curl -sSL https://packages.sury.org/php/README.txt | bash - && \
    apt install -y php8.2 php8.2-fpm php8.2-zip \
    php8.2-mysqli php8.2-cli php8.2-mysql mariadb-client curl

RUN apt-get -y install wget

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY www.conf /etc/php/8.2/fpm/pool.d/.

COPY script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["/bin/bash", "/script.sh"]

CMD ["php-fpm8.2", "-F"]
