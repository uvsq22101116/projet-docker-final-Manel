FROM php:7.4-apache

RUN docker-php-ext-install pdo_mysql

RUN a2enmod rewrite

COPY . /var/www/html/

WORKDIR /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update && apt-get install -y git zip unzip && rm -rf /var/lib/apt/lists/*
RUN composer install --no-interaction --no-scripts

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2-foreground"]