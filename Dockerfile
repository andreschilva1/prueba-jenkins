
FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    git unzip curl zip libzip-dev libpng-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Habilita mod_rewrite
RUN a2enmod rewrite

# Establece DocumentRoot en /public
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/000-default.conf

# Copia el script de inicialización
COPY docker/init.sh /init.sh
RUN chmod +x /init.sh

WORKDIR /var/www/html

CMD ["/init.sh"]
