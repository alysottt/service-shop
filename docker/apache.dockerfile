FROM php:7.2-apache

ARG FILES_UID=1000
ENV FILES_UID=$FILES_UID
ARG FILES_GID=1000
ENV FILES_GID=$FILES_GID

# File permision fix
RUN cat /etc/group

RUN groupmod -g ${FILES_GID} www-data \
    && usermod -d /var/www/html -u ${FILES_UID} -g www-data -s /bin/bash www-data

RUN chown -R www-data:www-data /var/www/html
USER www-data:www-data

FROM php:7.2-apache

RUN touch /etc/apache2/sites-enabled/local.conf \
    && echo 'Include sites-enabled/local.conf' >> /etc/apache2/apache2.conf

RUN a2enmod rewrite \
 && a2enmod headers \
 && a2enmod deflate
