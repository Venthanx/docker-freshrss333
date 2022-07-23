FROM php:8.1.8-fpm-alpine

ARG FRESHRSS_VERSION

RUN apk add --no-cache wget unzip \
    && wget https://github.com/FreshRSS/FreshRSS/archive/refs/tags/${FRESHRSS_VERSION}.zip \
    && unzip -oq $FRESHRSS_VERSION.zip \
    && mv FreshRSS-${FRESHRSS_VERSION}/ /app \
    && apk del wget unzip \
    && chown -R www-data:www-data /app

RUN apk add --no-cache gmp-dev \
    && docker-php-ext-install opcache gmp \
	&& docker-php-ext-enable opcache \
    && apk add --no-cache gmp

RUN php -m

WORKDIR /app