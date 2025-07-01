FROM php:8.2-apache

# System-Tools & PHP-Erweiterungen installieren
RUN apt-get update && apt-get install -y \
    unzip zip git curl libzip-dev libonig-dev libxml2-dev libpng-dev libjpeg-dev libfreetype6-dev libicu-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip tokenizer xml gd intl

# Composer installieren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Webroot vorbereiten
WORKDIR /var/www/html

# TastyIgniter installieren
RUN composer create-project tastyigniter/tastyigniter .

# Apache Rewrite aktivieren
RUN a2enmod rewrite

# Rechte setzen (optional)
RUN chown -R www-data:www-data /var/www/html
