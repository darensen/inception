FROM debian:bullseye

RUN apt update -y && apt upgrade -y && apt-get install -y mariadb-server

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY script.sh /script.sh

RUN chmod +x script.sh

ENTRYPOINT ["/script.sh"]

CMD ["mysqld"]


