FROM php:8.2-apache

# System-Abhängigkeiten & PHP Extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        unzip \
        zip \
        git \
        curl \
        libzip-dev \
        libonig-dev \
        libxml2-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libicu-dev \
        libcurl4-openssl-dev \
        libssl-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        zip \
        tokenizer \
        xml \
        gd \
        intl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Composer installieren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Apache Rewrite aktivieren
RUN a2enmod rewrite

# Arbeitsverzeichnis
WORKDIR /var/www/html

# TastyIgniter installieren
RUN composer create-project tastyigniter/tastyigniter .

# Rechte setzen
RUN chown -R www-data:www-data /var/www/html

# Optionaler Hinweis-Port
EXPOSE 80
