FROM php:8.1.8-fpm-alpine

ARG FRESHRSS_VERSION

RUN apk add --no-cache wget unzip \
    && wget https://github.com/FreshRSS/FreshRSS/archive/refs/tags/${FRESHRSS_VERSION}.zip \
    && unzip -oq $FRESHRSS_VERSION.zip \
    && mv FreshRSS-${FRESHRSS_VERSION}/ /app \
    && apk del wget unzip \
    && chown -R www-data:www-data /app

RUN apk add --no-cache gmp gmp-dev icu icu-dev libzip-dev libzip \
    && docker-php-ext-install opcache gmp intl zip \
	&& docker-php-ext-enable opcache gmp intl zip \
    && apk add --no-cache gmp icu libzip-dev libzip

RUN php -m

WORKDIR /app
