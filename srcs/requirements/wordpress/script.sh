#!/bin/bash

until mysql -s --host=$WORDPRESS_DB_HOST -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SELECT 1" $MYSQL_DATABASE;  # Vérifier la connexion à la base de données
do
	echo "En attente de la connexion à la base de données..."
	sleep 1
done

echo "Connexion à $MYSQL_DATABASE réussie !"

mkdir -p /run/php

mkdir -p /var/www/html/dsenatus.42.fr

cd /var/www/html/dsenatus.42.fr

if [ ! -f "wp-load.php" ]; then
    echo "Téléchargement de WordPress..."
    wp core download --allow-root
fi


if [ ! -f "wp-config.php" ]; then
	echo "Création du fichier wp-config.php..."
	wp config create --allow-root \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=$WORDPRESS_DB_HOST
fi


if ! wp core is-installed --allow-root; then
	echo "Installation de WordPress..."
	wp core install --allow-root \
		--url="https://$DOMAIN_NAME" \
		--title="Inception" \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL
fi


if ! wp user get $WORDPRESS_USER --allow-root > /dev/null 2>&1; then
	echo "Création de l'utilisateur secondaire..."
	wp user create --allow-root \
		$WORDPRESS_USER \
		$WORDPRESS_USER_EMAIL \
		--user_pass=$WORDPRESS_USER_PASSWORD \
		--role=author
fi

#wp option update blogname "Porofessor" --allow-root

php-fpm8.2 -F
