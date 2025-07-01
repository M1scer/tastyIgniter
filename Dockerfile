# Dockerfile
FROM php:8.1-apache

# Systemabhängigkeiten
RUN apt-get update && apt-get install -y \
    unzip git curl libzip-dev zip libonig-dev libxml2-dev libpng-dev \
    && docker-php-ext-install pdo_mysql zip

# Composer installieren
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# DocumentRoot ändern
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Apache-Rewrite aktivieren
RUN a2enmod rewrite

# TastyIgniter installieren (neueste Version)
WORKDIR /var/www/html
RUN composer create-project tastyigniter/tastyigniter .

# Rechte setzen
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80
