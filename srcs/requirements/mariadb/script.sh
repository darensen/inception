#!/bin/bash

mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

mysql_install_db --user=mysql --ldata=/var/lib/mysql
mysqld_safe --datadir=/var/lib/mysql & 

sleep 1

# Créer la base de données et l'utilisateur
mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" 
mysql -e "FLUSH PRIVILEGES;"

# Arrêter MariaDB proprement
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Démarrer MariaDB en mode définitif
exec mysqld_safe
